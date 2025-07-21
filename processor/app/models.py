from .db import db
from datetime import datetime
from sqlalchemy.dialects.postgresql import BIGINT, NUMERIC

class Account(db.Model):
    __tablename__ = 'accounts'

    accountid = db.Column(BIGINT, primary_key=True)
    accountnumber = db.Column(db.String, nullable=False, unique=True)
    accountname = db.Column(db.String, nullable=False)
    balance = db.Column(db.Numeric(12, 2), nullable=False, default=0.00)

class Payment(db.Model):
    __tablename__ = 'payments'

    paymentid = db.Column(db.Integer, primary_key=True)
    userid = db.Column(db.String, nullable=False)
    amount = db.Column(db.Float, nullable=False)
    accountnumber = db.Column(db.String, nullable=False)
    paymentdate = db.Column(db.DateTime, default=datetime.utcnow)
