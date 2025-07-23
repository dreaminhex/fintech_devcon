# Fintech DevCon 2025 Workshop

Workshop project for the 2025 FinTech DevCon.

## Prerequisites

- Docker Desktop (ensure running)
- Python 3.13 (incl. pip)

## Installation

For this workshop, you'll be working from the `workshop_2025` branch, which is step-by-step. All working code is available to you in the `master_2025` branch.

## 1. Clone the Repo

```bash
git clone https://github.com/dreaminhex/fintech_devcon.git
git fetch origin
git checkout workshop_2025
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

Open [http://localhost:2023](http://localhost:2023) in your browser.

### 2. Configure Service

dotnet restore
dotnet build

### .NET Libraries Used

- GraphQL.NET
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
