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

const redis = new Redis();
const PORT = 2025;

let server: ApolloServer;
let currentHash = '';

async function loadFederatedServices() {
    const keys = await redis.keys('gateway:*:schema');
    const services = [];

    for (const key of keys) {
        const name = key.split(':')[1]; // "gateway:processor:schema" -> "processor"
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

function computeHash(sdl: string): string {
    return crypto.createHash('sha256').update(sdl).digest('hex');
}

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
            id: Buffer.from(Date.now().toString()).toString('base64'), // Temp unique ID to track refresh
            supergraphSdl: compositionResult.supergraphSdl,
        }),
        buildService({ name }) {
            const url = serviceUrlMap[name];
            if (!url) {
                throw new Error(`Missing service URL for "${name}"`);
            }
            return new RemoteGraphQLDataSource({ url });
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

    app.use('/graphql', cors(), bodyParser.json(), expressMiddleware(newServer));

    server = newServer;
    console.log(`🚀 Gateway schema updated. Hash: ${currentHash}`);
}

async function start() {
    const app = express();
    
    app.use(express.json());

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
