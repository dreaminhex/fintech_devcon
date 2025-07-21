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

`docker compose up -d redis`

## 1. Start the Postgres Container

`docker compose up -d postgres`

## 1. Start the Python Service (processor)

1. From `/processor` directory:
1. If you haven't done this yet, create a virtual env: `python -m venv venv`
1. Activate it
    - Windows Powershell: `.\venv\Scripts\Activate.ps1`
    - Windows Command Prompt: `venv\Scripts\activate`
    - MacOS (zsh):
    - Linux:
1. Install required packages: `pip install -r requirements.txt`
1. Select the proper interpreter:
    - In VS Code, `Ctrl`+`Shift`+`P`
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

Libs used:

- Flash
- psycopg2 (Postgres adapter)
- GraphiQL (UI browser)
- SQLAlchemy
- Ariadne (for Apollo federation)
