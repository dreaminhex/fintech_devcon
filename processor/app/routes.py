from ariadne import graphql_sync
from flask import request, jsonify, send_from_directory

def register_routes(app):
    # REST payment route
    @app.route("/payment", methods=["POST"])
    def create_payment():
        from .models import Payment
        data = request.json
        payment = Payment(
            user_id=data["user_id"],
            email_address=data.get("email_address"),
            amount=data["amount"],
            account_number=data["account_number"]
        )
        from .db import db
        db.session.add(payment)
        db.session.commit()
        return jsonify({"status": "ok", "id": payment.id})

    # GraphQL Playground
    @app.route("/graphql", methods=["GET"])
    def graphql_playground():
        return send_from_directory("static", "playground.html")

    # GraphQL POST handler
    @app.route("/graphql", methods=["POST"])
    def graphql_server():
        from . import schema
        data = request.get_json()
        _, result = graphql_sync(
            schema,
            data,
            context_value={"request": request},
            debug=app.debug,
        )
        return jsonify(result)
    
    @app.route("/sdl", methods=["GET"])
    def sdl():
        from graphql.utilities import print_schema
        from . import schema
        return print_schema(schema), 200, {"Content-Type": "text/plain"}

