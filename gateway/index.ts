import { ApolloServer } from '@apollo/server';
import { ApolloGateway, RemoteGraphQLDataSource } from '@apollo/gateway';
import { expressMiddleware } from '@apollo/server/express4';
import { ApolloServerPluginLandingPageLocalDefault } from '@apollo/server/plugin/landingPage/default';
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

const JWT_SECRET = '688159e9-ea80-800a-ab08-8c51afaec3c0'; // Must match .NET key, should be stored as a secret in real app.
const redis = new Redis("gateway-redis");
const PORT = 2025;

let server: ApolloServer;
let currentHash = '';

/**
 * Get the services (SDL, URL) federated to Redis.
 * @returns Array of services.
 */
async function loadFederatedServices() {
    const keys = await redis.keys('gateway:*:schema');
    const services = [];

    for (const key of keys) {
        const name = key.split(':')[1]; // e.g. "gateway:processor:schema" -> "processor"
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
 * Create the GraphQL gateway, stitch the schemas, apply auth, and add endpoints.
 * @param app The Express webserver
 */
async function createGatewayAndServer(app: express.Express) {
    const services = await loadFederatedServices();

    // Cache the service URLs
    const serviceUrlMap: Record<string, string> = {};
    for (const svc of services) {
        serviceUrlMap[svc.name] = svc.url;
    }

    const compositionResult = composeServices(services);

    if (compositionResult.errors) {
        console.error('❌ Composition errors:', compositionResult.errors);
        throw new Error('Composition failed');
    }

    // Check for changes
    const newHash = computeHash(compositionResult.supergraphSdl);

    if (newHash === currentHash) {
        return; // No change
    }

    currentHash = newHash;

    console.log('🔁 Reloading schema...');

    const gateway = new ApolloGateway({
        supergraphSdl: async () => ({
            id: Buffer.from(Date.now().toString()).toString('base64'), // A temp unique ID to track schema refreshes
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
        plugins: [ApolloServerPluginLandingPageLocalDefault({ embed: true })],
    });

    await newServer.start();

    if (server) {
        await server.stop();
    }

    // Add GraphQL endpoint, check JWT token for roles
    app.use('/graphql', cors(), bodyParser.json(), expressMiddleware(newServer, {
        context: async ({ req }) => {
            const rawAuth = req.headers['authorization'];
            const auth = Array.isArray(rawAuth) ? rawAuth[0] : rawAuth || '';

            const token = auth.startsWith('Bearer ') ? auth.slice(7) : null;

            // Fallback to localStorage if running in browser and available.
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

            return { user };
        }
    }));

    server = newServer;
    console.log(`🚀 Gateway schema updated. Hash: ${currentHash}`);
}

/**
 * Start the GraphQL and Voyager servers.
 */
async function start() {
    const app = express();

    app.use(express.json());

    // Serve the login page
    app.use(express.static(path.join(__dirname, 'public')));

    // Login route (serves index.html from login)
    app.get('/', (_, res) => {
        res.sendFile(path.join(__dirname, 'public', 'index.html'));
    });

    app.use('/voyager', voyagerMiddleware({ endpointUrl: '/graphql' }));

    await createGatewayAndServer(app);

    app.listen(PORT, () => {
        console.log(`🚀 Gateway: http://localhost:${PORT}/graphql`);
        console.log(`🛰 Voyager: http://localhost:${PORT}/voyager`);
    });

    // Hot reload every 10 seconds
    setInterval(() => {
        createGatewayAndServer(app).catch(err => {
            console.error('Schema reload error:', err.message);
        });
    }, 10000);
}

start().catch(err => {
    console.error('Fatal startup error:', err.message);
});

/**
 * Helper function to create a hash.
 */
function computeHash(sdl: string): string {
    return crypto.createHash('sha256').update(sdl).digest('hex');
}
