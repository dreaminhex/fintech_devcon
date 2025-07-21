import { ApolloServer } from '@apollo/server';
import { ApolloGateway } from '@apollo/gateway';
import { expressMiddleware } from '@apollo/server/express4';
import { ApolloServerPluginLandingPageLocalDefault } from '@apollo/server/plugin/landingPage/default';

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
    const keys = await redis.keys('federation:schema:*');
    const services = [];

    for (const key of keys) {
        const sdl = await redis.get(key);
        if (!sdl) continue;

        const serviceName = key.replace('federation:schema:', '');
        const envVarName = `${serviceName.toUpperCase()}_PORT`;
        const port = process.env[envVarName] ?? '2024';
        services.push({
            name: serviceName,
            url: `http://localhost:${port}/graphql`,
            sdl,
        });

    }

    return services;
}

function computeHash(sdl: string): string {
    return crypto.createHash('sha256').update(sdl).digest('hex');
}

async function createGatewayAndServer(app: express.Express) {
    const services = await loadFederatedServices();
    const supergraphSdl = services.map(s => s.sdl).join('\n\n');
    const newHash = computeHash(supergraphSdl);

    if (newHash === currentHash) {
        return; // No change
    }

    currentHash = newHash;

    console.log('🔁 Reloading federated schema...');

    const gateway = new ApolloGateway({
        supergraphSdl: async () => ({
            id: currentHash,
            supergraphSdl,
        }),
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
