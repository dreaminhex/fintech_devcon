from ariadne import QueryType, ScalarType
from .models import Payment, Account, Loan
from .db import db
from datetime import datetime

query = QueryType()
datetime_scalar = ScalarType("DateTime")

@datetime_scalar.serializer
def serialize_datetime(value: datetime):
    return value.isoformat()

@datetime_scalar.value_parser
def parse_datetime_value(value: str):
    return datetime.fromisoformat(value)

@query.field("_service")
def resolve_service(_, info):
    with open("app/schema.graphql", "r") as f:
        return {"sdl": f.read()}

@query.field("payments")
def resolve_payments(_, info):
    return db.session.query(Payment).all()

@query.field("accounts")
def resolve_accounts(_, info):
    return db.session.query(Account).all()

@query.field("loans")
def resolve_loans(_, info):
    return db.session.query(Loan).all()

resolvers = [query, datetime_scalar]
