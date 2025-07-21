import redis
from ariadne.asgi import GraphQL
from ariadne import gql, make_executable_schema, snake_case_fallback_resolvers
from app.resolvers import query
with open("app/schema.graphql", "r") as f:
    type_defs = f.read()

# Load the parsed SDL
schema = make_executable_schema(
    type_defs,
    query,
    snake_case_fallback_resolvers,
)

def publish_sdl_to_redis():
    r = redis.Redis(host="localhost", port=6379, decode_responses=True)
    sdl = schema.print_schema()
    r.set("federation:processor:schema", sdl)
    print("✅ Schema published to Redis.")

if __name__ == "__main__":
    publish_sdl_to_redis()
