# Fintech DevCon 2025 Workshop

Workshop project for the 2025 FinTech DevCon.

## Prerequisites

| Software             | Version Requirement             | Description                                                        |
|----------------------|---------------------------------|--------------------------------------------------------------------|
| Visual Studio Code   | ≥ 1.102                         | Preferred editor for development (or alternatives like Rider)      |
| Git                  | ≥ 2.49                          | Distributed version control system                                 |
| Node.js              | ≥ 22                            | JavaScript runtime for running and building frontend/backend tools |
| TypeScript           | ≥ 5.8.3                         | Superset of JavaScript for static typing and tooling               |
| .NET SDK & ASP.NET   | 9                               | SDK and runtime for building and running .NET apps                 |
| Container Manager    | Docker, Rancher, Podman, Colima | Used to build and run containerized applications                   |
| Python               | ≥ 3.13                          | General-purpose scripting language (with `pip`)                    |

## Installation

For this workshop, you'll be working from the `workshop_2025` branch, which is step-by-step. All working code is available to you in the `master_2025` branch.

## 1. Clone the Repo

```bash
git clone https://github.com/dreaminhex/fintech_devcon.git
git fetch origin
git checkout workshop_2025
```

## 1. Folder Structure

./fintech_devcon
│
├── docker-compose.yml
├── fintech_devcon.sln
├── README.md
├── LICENSE
│
├── /gateway # Node.js + TypeScript Apollo Gateway
│ └── Dockerfile
│
├── /infrastructure # Seed scripts for databases
│ ├── init-db.sql # PostgreSQL
│ └── mongo-init.js # MongoDB
│
├── /payments # .NET Apps (API + UI)
│ ├── /Payments.API
│ │ └── Dockerfile
│ ├── /Payments.UI
│ │ └── Dockerfile
│ └── /Payments.Domain # Shared class library
│
├── /processor # Python + Postgres API
│ └── Dockerfile

## 1. Cheatcode - Start Everything

If you just want to follow along with the demo, simply run (from the root):

```shell
docker compose up -d
```

## 1. Start the Redis Container

```shell
docker compose up -d redis
```

## 1. The Python Service

### 1. Start the Postgres Container

```shell
docker compose up -d postgres
```

### 2. Quickstart

If you've already done all of the installation steps, to quickstart, enter:

- Windows:

```shell
cd processor 
.\venv\Scripts\Activate.ps1
python -m app
```

Open [http://localhost:2024/graphql](http://localhost:2024/graphql) in your browser.

### 3. Configure Service

1. From `/processor` directory:
1. If you haven't done this yet, create a virtual env: `python -m venv venv`
1. Activate it
    - Windows Powershell: `.\venv\Scripts\Activate.ps1`
    - Windows Command Prompt: `venv\Scripts\activate`
    - MacOS (zsh): TODO
    - Linux: TODO
1. Install required packages: `pip install -r requirements.txt`
1. Select the virtual environment interpreter:
    - In VS Code
        - 🖼️ Windows `Ctrl`+`Shift`+`P`
        - 🍎 Mac: TODO
        - 🐧 Linux: TODO
    - Enter `Python: Select Interpreter`
    - Browse to `venv\Scripts`
    - Choose `python.exe`
1. From a terminal, tell Python to treat `/app` as a package: `python -m app.main`
1. Run the service: `python -m app`
1. Test the service:

- **cURL**

```bash
curl -X POST http://localhost:2024/graphql \
    -H "Content-Type: application/json" \
    -d '{"query": "{ payments { id } }"}'
```

- **PowerShell**

```powershell
Invoke-RestMethod -Uri http://localhost:2024/graphql `
    -Method POST `
    -Headers @{ "Content-Type" = "application/json" } `
    -Body '{ "query": "{ payments { id } }" }'
```

1. Open a browser to: [http://127.0.0.1:2024/graphql](http://127.0.0.1:2024/graphql)

### 4. Python Libraries Used

- Flask
- psycopg2 (Postgres adapter)
- GraphiQL (UI browser)
- SQLAlchemy
- Ariadne (for Apollo federation)

## 1. The .NET Service

### 1. Start the Mongo Container

```shell
docker compose up -d mongo
```

### 3. Quickstart

Press `Ctrl`+`Shift`+`P` → "Tasks: Run Task" → Run Both.

Open [http://localhost:2022/graphiq](http://localhost:2022/graphiql) in your browser.
Open [http://localhost:2023](http://localhost:2023) in your browser.

### 2. Configure Service

dotnet restore
dotnet build

### .NET Libraries Used

- GraphQL.NET with GraphiQL
- Microsoft.AspNetCore.Components.WebAssembly (Blazor)
- MongoDB
- Microsoft.AspNetCore.Mvc
- StackExchange.Redis

## 1. Create the Node.js Gateway

1. From the `/gateway` directory:

```bash
npm init -y
npm install typescript ts-node ts-node-dev @types/node --save-dev
npx tsc --init
```

1. Install dependencies:

`npm install @apollo/server@^4 @apollo/gateway express cors body-parser graphql graphql-voyager ioredis @apollo/composition`

1. Create `index.ts`
    - Connect to Redis
    - Load federated SDLs
    - Register them with Apollo Gateway
    - Launch the server

1. Update `package.json`

```json
"scripts": {
  "dev": "ts-node-dev --respawn --transpile-only src/index.ts"
}
```

1. Launch the Gateway: `npm run dev`

1. Access the Playground or Voyager:
    - 🚀 Gateway: [http://localhost:2025/graphql](http://localhost:2025/graphql)
    - 🛰 Voyager: [http://localhost:2025/voyager]([http://localhost:2025/voyager)
