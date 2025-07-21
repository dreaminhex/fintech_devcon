from flask import Flask
from flask_cors import CORS
from ariadne import load_schema_from_path, make_executable_schema
from .resolvers import resolvers
from .db import init_db
from .routes import register_routes
import os

type_defs = load_schema_from_path(os.path.join(os.path.dirname(__file__), "schema.graphql"))
schema = make_executable_schema(type_defs, *resolvers)

def create_app():
    app = Flask(__name__)
    app.static_folder = "static"

    from dotenv import load_dotenv
    load_dotenv()

    CORS(app)

    app.config['SQLALCHEMY_DATABASE_URI'] = os.getenv("DATABASE_URI")
    app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = False

    init_db(app)
    register_routes(app)

    return app

