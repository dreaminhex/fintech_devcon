# app/__main__.py
from .main import app

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=2024)
