# Fintech DevCon 2025 Workshop

This workshop demonstrates how to federate GraphQL services using Apollo Federation, Redis, and multiple service technologies (.NET, Python, Node.js). You'll walk through building and connecting a federated API Gateway with services written in Python (PostgreSQL), .NET (MongoDB), and TypeScript (Redis-powered Gateway).

⚠️ **NOTE** This branch, `main`, may be overwritten by future Fintech Devcon presentations at any time. This respository has specific branches for each year, which you can find as `master_{year}` when looking in branches. Pull requests to any of these branches will likely be ignored.

## Prerequisites

| Software | Version | Description |
|---|---|---|
| Visual Studio Code   | ≥ 1.102                         | Preferred editor for development (or alternatives like Rider)      |
| Git                  | ≥ 2.49                          | Distributed version control system                                 |
| Node Package Manager | ≥ 11                            | Package manager for Node.js applications.                          |
| Node.js              | ≥ 22                            | JavaScript runtime for running and building frontend/backend tools |
| TypeScript           | ≥ 5.8.3                         | Superset of JavaScript for static typing and tooling               |
| .NET SDK & ASP.NET   | ≥ 9                             | SDK and runtime for building and running .NET apps                 |
| Python               | ≥ 3.13                          | General-purpose scripting language (with `pip`)                    |
| Container Manager    | Docker, Rancher, Podman, Colima | Used to build and run containerized applications                   |

## Getting Started

For this workshop, all working code is available to you in the `master_2025` branch.

### Clone the Repo

```bash
git clone https://github.com/dreaminhex/fintech_devcon.git
git fetch origin
git checkout workshop_2025
```

### Folder Structure

Open the root folder where you cloned the repo (e.g. `workshop_2025`) in Visual Studio Code.

Your folder structure should look like the following:

- 📦 `docker-compose.yml` — Root Docker orchestration  
- 🧱 `fintech_devcon.sln` — .NET solution file  
- 📘 `README.md`  
- 📄 `LICENSE`
- 📂 `gateway/` — Node.js + TypeScript Apollo Gateway  
  - 🐳 `Dockerfile`
- 📂 `infrastructure/` — Seed scripts for databases  
  - 🐘 `init-db.sql` — PostgreSQL schema and seed  
  - 🍃 `mongo-init.js` — MongoDB schema and seed
- 📂 `payments/` — .NET 9 applications  
  - 📂 `Payments.API/` — ASP.NET Core Web API  
    - 🐳 `Dockerfile`
  - 📂 `Payments.UI/` — Blazor (Server or WASM) UI  
    - 🐳 `Dockerfile`
  - 📂 `Payments.Domain/` — Shared domain types and models
- 📂 `processor/` — Python + PostgreSQL Ariadne API  
  - 🐳 `Dockerfile`

## Option A: Cheatcode - Just Start Everything

If you just want to follow along with the demo, simply run (from the root):

```shell
docker compose build
docker compose up -d
```

This takes 1–3 minutes (depending on your internet connection and processor speed) to pull all of the required Docker images and startup all services.

Once done, browse to [http://localhost:2025/graphql](http://localhost:2025/graphql) and start running queries!

## Option B: Workshop - Step by Step

In this walkthrough, you’ll bring up each service one by one and see how it contributes to the federated architecture. We’ll start with Redis (our cache), then launch the Python service, followed by the .NET service, and finally the Apollo Gateway.

## Step 1: The Federated Cache

Redis is used as a schema registry cache for Apollo Gateway to read SDLs (Schema Definition Language) published by other services.

```shell
docker compose up -d redis
```

## Step 2: The Python Service

The Python service uses Flask, Ariadne, and PostgreSQL to expose a federated GraphQL service focused on processing and payment logic.

### Start the Postgres Container

PostgreSQL stores the backing data for the Python-based processor service.

```shell
docker compose up -d postgres
```

### Configure Service

This service uses a virtual environment and `pip` to install dependencies.

1. From `/processor` directory:
1. If you haven't done this yet, create a virtual env: `python -m venv venv`
1. Activate it
    - Windows Powershell: `.venv\Scripts\Activate.ps1`
    - Windows Command Prompt: `venv\Scripts\activate`
    - MacOS (zsh): `source venv/bin/activate`
    - Linux: `source venv/bin/activate`
1. Install required packages: `pip install -r requirements.txt`
1. Select the virtual environment interpreter:
    - In VS Code
        - 🖼️ Windows `Ctrl`+`Shift`+`P`
        - 🍎 Mac: `⌘`+`Shift`+`P`
        - 🐧 Linux: `Ctrl`+`Shift`+`P`
    - Enter `Python: Select Interpreter`
    - Browse to `venv/bin` or `venv\Scripts`
    - Choose the correct `python` binary
1. From a terminal, tell Python to treat `/app` as a package: `python -m app.main`
1. Run the service: `python -m app`
1. Test the service:

- 🖼️ Windows (Powershell)

```powershell
Invoke-RestMethod -Uri http://localhost:2024/graphql `
    -Method POST `
    -Headers @{ "Content-Type" = "application/json" } `
    -Body '{ "query": "{ payments { id } }" }'
```

- 🖼️ Windows, 🍎 Mac, 🐧 Linux (curl)

```bash
curl -X POST http://localhost:2024/graphql     -H "Content-Type: application/json"     -d '{"query": "{ payments { id } }"}'
```

### Python Service Quickstart

If you've already done all of the installation steps, to quickstart, enter:

- 🖼️ Windows:

```shell
cd processor 
.venv\Scripts\Activate.ps1
python -m app
```

- 🍎 Mac or 🐧 Linux:

```bash
cd processor
source venv/bin/activate
python -m app
```

Now you can browse to [http://localhost:2024/graphql](http://localhost:2024/graphql) in your browser.

### Python Libraries Used

- Flask
- psycopg2
- GraphiQL
- SQLAlchemy
- Ariadne

## Step 3: The .NET Service

This service represents a mock financial UI and API for managing user accounts and payments, using MongoDB as a backing store.

### Start the Mongo Container

MongoDB stores user, account, and payment data for the .NET services.

```shell
docker compose up -d mongo
```

### Configure .NET Service

From the `payments\` folder, run the following:

```shell
dotnet restore
dotnet build
```

### .NET Service Quickstart

1. From Visual Studio Code:
   1. 🖼️ Windows `Ctrl`+`Shift`+`P`
   1. 🍎 Mac: `⌘`+`Shift`+`P`
   1. 🐧 Linux: `Ctrl`+`Shift`+`P`
1. Type or choose → "Tasks: Run Task" → Run Both.
1. Open [http://localhost:2022/graphiq](http://localhost:2022/graphiql) in your browser.
1. Open [http://localhost:2023](http://localhost:2023) in your browser.

### .NET Libraries Used

- GraphQL.NET
- Blazor
- MongoDB.Driver
- Microsoft WebAPI
- StackExchange.Redis

## Step 4: The Node.js Gateway

This is the Apollo Gateway that reads GraphQL schemas published to Redis and stitches them into a unified federated GraphQL API.

### Configure the Node.js Service

From the `/gateway` directory:

```bash
npm init -y
npm install typescript ts-node ts-node-dev @types/node --save-dev
npx tsc --init
```

#### Install Dependencies

```bash
npm install @apollo/server@^4 @apollo/gateway express cors body-parser graphql graphql-voyager ioredis @apollo/composition
```

#### Create `index.ts`

This file:

1. Connects to Redis
2. Loads federated service SDLs
3. Registers them with Apollo Gateway
4. Launches the Express GraphQL server

#### Update `package.json`

```json
"scripts": {
  "dev": "ts-node-dev --respawn --transpile-only src/index.ts"
}
```

#### Launch the Gateway

```shell
npm run dev
```

### Nodejs Libraries Used

- @apollo/server@^4
- @apollo/gateway
- @apollo/composition
- express
- cors
- body-parser
- graphql
- graphql-voyager
- ioredis

## Demo URLS

### .NET Payments Service

- 📈 GraphQL UI: [http://localhost:2022/graphiq](http://localhost:2022/graphiql)
- 💸 Payments UI: [http://localhost:2023](http://localhost:2023)

### Python Processor Service

- 🐍 GraphQL UI: [http://localhost:2024/graphql](http://localhost:2024/graphql)

### Federated GraphQL Gateway

- 🚀 Gateway: [http://localhost:2025/graphql](http://localhost:2025/graphql)
- 🛰 Voyager: [http://localhost:2025/voyager](http://localhost:2025/voyager)
