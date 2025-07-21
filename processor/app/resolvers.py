from ariadne import QueryType
from .models import Payment, Account
from .db import db

query = QueryType()

@query.field("payments")
def resolve_payments(_, info):
    return db.session.query(Payment).all()

@query.field("accounts")
def resolve_accounts(_, info):
    return db.session.query(Account).all()

resolvers = [query]
