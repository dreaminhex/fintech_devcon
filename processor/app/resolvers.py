from ariadne import QueryType, ScalarType, ObjectType
from .models import Payment, Account, Loan
from .db import db
from datetime import datetime
from sqlalchemy import desc, asc

query = QueryType()
datetime_scalar = ScalarType("DateTime")

@datetime_scalar.serializer
def serialize_datetime(value: datetime):
    return value.isoformat()

@datetime_scalar.value_parser
def parse_datetime_value(value: str):
    return datetime.fromisoformat(value)

def apply_account_filters(query, where):
    """Apply filtering to account query"""
    if not where:
        return query

    if where.get("accounttoken"):
        query = query.filter(Account.accounttoken.ilike(f"%{where['accounttoken']}%"))
    if where.get("accountname"):
        query = query.filter(Account.accountname.ilike(f"%{where['accountname']}%"))
    if where.get("accounttype") is not None:
        query = query.filter(Account.accounttype == where["accounttype"])
    if where.get("minBalance") is not None:
        query = query.filter(Account.balance >= where["minBalance"])
    if where.get("maxBalance") is not None:
        query = query.filter(Account.balance <= where["maxBalance"])

    return query

def apply_account_sorting(query, order):
    """Apply sorting to account query"""
    if not order:
        return query.order_by(Account.accountid)

    for field, direction in order.items():
        column = getattr(Account, field, None)
        if column is not None:
            query = query.order_by(desc(column) if direction == "DESC" else asc(column))

    return query

def apply_payment_filters(query, where):
    """Apply filtering to payment query"""
    if not where:
        return query

    if where.get("userid"):
        query = query.filter(Payment.userid.ilike(f"%{where['userid']}%"))
    if where.get("loannumber"):
        query = query.filter(Payment.loannumber.ilike(f"%{where['loannumber']}%"))
    if where.get("accounttoken"):
        query = query.filter(Payment.accounttoken.ilike(f"%{where['accounttoken']}%"))
    if where.get("minTotal") is not None:
        query = query.filter(Payment.total >= where["minTotal"])
    if where.get("maxTotal") is not None:
        query = query.filter(Payment.total <= where["maxTotal"])
    if where.get("startDate"):
        query = query.filter(Payment.paymentdate >= parse_datetime_value(where["startDate"]))
    if where.get("endDate"):
        query = query.filter(Payment.paymentdate <= parse_datetime_value(where["endDate"]))

    return query

def apply_payment_sorting(query, order):
    """Apply sorting to payment query"""
    if not order:
        return query.order_by(Payment.paymentid)

    for field, direction in order.items():
        column = getattr(Payment, field, None)
        if column is not None:
            query = query.order_by(desc(column) if direction == "DESC" else asc(column))

    return query

def apply_loan_filters(query, where):
    """Apply filtering to loan query"""
    if not where:
        return query

    if where.get("loannumber"):
        query = query.filter(Loan.loannumber.ilike(f"%{where['loannumber']}%"))
    if where.get("loanname"):
        query = query.filter(Loan.loanname.ilike(f"%{where['loanname']}%"))
    if where.get("minBalance") is not None:
        query = query.filter(Loan.balance >= where["minBalance"])
    if where.get("maxBalance") is not None:
        query = query.filter(Loan.balance <= where["maxBalance"])
    if where.get("minRate") is not None:
        query = query.filter(Loan.rate >= where["minRate"])
    if where.get("maxRate") is not None:
        query = query.filter(Loan.rate <= where["maxRate"])

    return query

def apply_loan_sorting(query, order):
    """Apply sorting to loan query"""
    if not order:
        return query.order_by(Loan.loanid)

    for field, direction in order.items():
        column = getattr(Loan, field, None)
        if column is not None:
            query = query.order_by(desc(column) if direction == "DESC" else asc(column))

    return query

@query.field("_service")
def resolve_service(_, info):
    with open("app/schema.graphql", "r") as f:
        return {"sdl": f.read()}

@query.field("accounts")
def resolve_accounts(_, info, skip=0, take=10, where=None, order=None):
    # Build base query
    base_query = db.session.query(Account)

    # Apply filters
    filtered_query = apply_account_filters(base_query, where)

    # Get total count
    total_count = filtered_query.count()

    # Apply sorting
    sorted_query = apply_account_sorting(filtered_query, order)

    # Apply pagination
    items = sorted_query.offset(skip).limit(take).all()

    # Calculate page info
    has_next_page = (skip + take) < total_count
    has_previous_page = skip > 0

    return {
        "items": items,
        "pageInfo": {
            "hasNextPage": has_next_page,
            "hasPreviousPage": has_previous_page
        },
        "totalCount": total_count
    }

@query.field("payments")
def resolve_payments(_, info, skip=0, take=10, where=None, order=None):
    # Build base query
    base_query = db.session.query(Payment)

    # Apply filters
    filtered_query = apply_payment_filters(base_query, where)

    # Get total count
    total_count = filtered_query.count()

    # Apply sorting
    sorted_query = apply_payment_sorting(filtered_query, order)

    # Apply pagination
    items = sorted_query.offset(skip).limit(take).all()

    # Calculate page info
    has_next_page = (skip + take) < total_count
    has_previous_page = skip > 0

    return {
        "items": items,
        "pageInfo": {
            "hasNextPage": has_next_page,
            "hasPreviousPage": has_previous_page
        },
        "totalCount": total_count
    }

@query.field("loans")
def resolve_loans(_, info, skip=0, take=10, where=None, order=None):
    # Build base query
    base_query = db.session.query(Loan)

    # Apply filters
    filtered_query = apply_loan_filters(base_query, where)

    # Get total count
    total_count = filtered_query.count()

    # Apply sorting
    sorted_query = apply_loan_sorting(filtered_query, order)

    # Apply pagination
    items = sorted_query.offset(skip).limit(take).all()

    # Calculate page info
    has_next_page = (skip + take) < total_count
    has_previous_page = skip > 0

    return {
        "items": items,
        "pageInfo": {
            "hasNextPage": has_next_page,
            "hasPreviousPage": has_previous_page
        },
        "totalCount": total_count
    }

resolvers = [query, datetime_scalar]
