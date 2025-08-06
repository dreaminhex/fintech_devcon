import { ApolloServer } from '@apollo/server';
import { ApolloGateway, RemoteGraphQLDataSource } from '@apollo/gateway';
import { expressMiddleware } from '@apollo/server/express4';
import { ApolloServerPluginLandingPageLocalDefault } from '@apollo/server/plugin/landingPage/default';
import { ApolloServerPluginDrainHttpServer } from '@apollo/server/plugin/drainHttpServer';
import { composeServices } from '@apollo/composition';
import { parse } from 'graphql';
import express from 'express';
import cors from 'cors';
import bodyParser from 'body-parser';
import Redis from 'ioredis';
import { express as voyagerMiddleware } from 'graphql-voyager/middleware';
import crypto from 'crypto';
import jwt from 'jsonwebtoken';
import path from 'path';
import http from 'http';

const JWT_SECRET = '688159e9-ea80-800a-ab08-8c51afaec3c0'; // Store securely in real apps
const redis = new Redis("gateway-redis");
const PORT = 2025;

let server: ApolloServer;
let currentHash = '';

/**
 * Get the services (SDL, URL) federated to Redis.
 */
async function loadFederatedServices() {
    const keys = await redis.keys('gateway:*:schema');
    const services = [];

    for (const key of keys) {
        const name = key.split(':')[1];
        const sdl = await redis.get(key);
        const url = await redis.get(`gateway:${name}:url`);

        if (!sdl || !url) {
            console.warn(`⚠️ Missing SDL or URL for service "${name}"`);
            continue;
        }

        services.push({
            name,
            url,
            typeDefs: parse(sdl),
        });
    }

    return services;
}

/**
 * Create or update the Apollo Gateway and server.
 */
async function createGatewayAndServer(app: express.Express, httpServer: http.Server) {
    const services = await loadFederatedServices();

    const serviceUrlMap: Record<string, string> = {};
    for (const svc of services) {
        serviceUrlMap[svc.name] = svc.url;
    }

    const compositionResult = composeServices(services);

    if (compositionResult.errors) {
        console.error('❌ Composition errors:', compositionResult.errors);
        throw new Error('Composition failed');
    }

    const newHash = computeHash(compositionResult.supergraphSdl);

    if (newHash === currentHash) {
        return;
    }

    currentHash = newHash;
    console.log('🔁 Reloading schema...');

    const gateway = new ApolloGateway({
        supergraphSdl: async () => ({
            id: Buffer.from(Date.now().toString()).toString('base64'),
            supergraphSdl: compositionResult.supergraphSdl,
        }),
        buildService({ name }) {
            const url = serviceUrlMap[name];
            if (!url) {
                throw new Error(`Missing service URL for "${name}"`);
            }
            return new RemoteGraphQLDataSource({
                url,
                willSendRequest({ request, context }) {
                    const auth = context.req?.headers['authorization'];
                    if (auth) {
                        request.http?.headers.set('authorization', auth);
                    }

                    if (context?.user) {
                        const roles = context.user.roles.join(',');
                        request.http?.headers.set('x-user-id', context.user.id);
                        request.http?.headers.set('x-user-roles', roles);
                    }
                }
            });
        }
    });

    const newServer = new ApolloServer({
        gateway,
        introspection: true,
        plugins: [
            ApolloServerPluginLandingPageLocalDefault({ embed: true }),
            ApolloServerPluginDrainHttpServer({ httpServer }),
        ],
    });

    await newServer.start();

    if (server) {
        await server.stop(); // Gracefully stop old server
    }

    app.use('/graphql', cors(), bodyParser.json(), expressMiddleware(newServer, {
        context: async ({ req }) => {
            const rawAuth = req.headers['authorization'];
            const auth = Array.isArray(rawAuth) ? rawAuth[0] : rawAuth || '';

            const token = auth.startsWith('Bearer ') ? auth.slice(7) : null;
            const localJwt = req.headers['x-jwt'];
            const jwtToken = token || localJwt;

            let user = null;
            if (jwtToken) {
                try {
                    const payload = jwt.verify(jwtToken, JWT_SECRET) as any;
                    user = {
                        id: payload.sub,
                        roles: payload.roles?.split(',') || []
                    };
                } catch (err: any) {
                    console.warn('Invalid JWT:', err.message);
                }
            }

            return { user, req };
        }
    }));

    server = newServer;
    console.log(`🚀 Gateway schema updated. Hash: ${currentHash}`);
}

/**
 * Start the web server and begin polling Redis for updates.
 */
async function start() {
    const app = express();
    app.use(express.json());
    app.use(express.static(path.join(__dirname, 'public')));
    app.get('/', (_, res) => {
        res.sendFile(path.join(__dirname, 'public', 'index.html'));
    });

    app.use('/voyager', voyagerMiddleware({ endpointUrl: '/graphql' }));

    const httpServer = http.createServer(app);

    await createGatewayAndServer(app, httpServer);

    httpServer.listen(PORT, () => {
        console.log(`🚀 Gateway: http://localhost:${PORT}/graphql`);
        console.log(`🛰 Voyager: http://localhost:${PORT}/voyager`);
    });

    // Reload schema every 10s
    setInterval(() => {
        createGatewayAndServer(app, httpServer).catch(err => {
            console.error('Schema reload error:', err.message);
        });
    }, 10000);

    // Graceful shutdown on SIGINT/SIGTERM
    process.on('SIGINT', async () => {
        console.log('🛑 SIGINT received. Shutting down...');
        await server?.stop();
        httpServer.close(() => process.exit(0));
    });

    process.on('SIGTERM', async () => {
        console.log('🛑 SIGTERM received. Shutting down...');
        await server?.stop();
        httpServer.close(() => process.exit(0));
    });
}

/**
 * Create a hash of SDL string.
 */
function computeHash(sdl: string): string {
    return crypto.createHash('sha256').update(sdl).digest('hex');
}

start().catch(err => {
    console.error('Fatal startup error:', err.message);
});
