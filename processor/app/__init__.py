from flask import Flask
from flask_cors import CORS
from ariadne import load_schema_from_path
from ariadne.contrib.federation import make_federated_schema
from .resolvers import resolvers
from .db import init_db
from .routes import register_routes
import redis
from graphql.utilities import print_schema
import os

type_defs = load_schema_from_path(os.path.join(os.path.dirname(__file__), "schema.graphql"))
schema = make_federated_schema(type_defs, *resolvers)

# When the app starts, publish/update the schema in Redis
def publish_schema_to_redis(schema):
    redis_host = os.getenv("REDIS_HOST", "localhost")
    redis_port = int(os.getenv("REDIS_PORT", 6379))
    service_name = os.getenv("SERVICE_NAME", "processor")
    service_port = os.getenv("PORT", "2024")
    schema_key = f"gateway:{service_name}:schema"
    url_key = f"gateway:{service_name}:url"
    service_url = f"http://python-processor-api:{service_port}/graphql"

    try:
        r = redis.Redis(host=redis_host, port=redis_port, decode_responses=True)
        sdl = print_schema(schema)
        r.set(schema_key, sdl)
        r.set(url_key, service_url)
        print(f"✅ Published federated SDL to Redis: {schema_key}")
        print(f"✅ Published service URL to Redis: {url_key}")
    except Exception as e:
        print(f"❌ Failed to publish to Redis: {e}")

publish_schema_to_redis(schema)

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

