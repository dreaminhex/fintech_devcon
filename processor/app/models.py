from sqlalchemy import DateTime, BigInteger, Numeric, SmallInteger, String
from .db import db
from datetime import datetime

class Account(db.Model):
    __tablename__ = 'accounts'

    accountid = db.Column(BigInteger, primary_key=True)
    accountnumber = db.Column(String, nullable=False, unique=True)
    accountname = db.Column(String, nullable=False)
    accounttype = db.Column(SmallInteger, nullable=False)
    balance = db.Column(Numeric(12, 2), nullable=False, default=0.00)

class Payment(db.Model):
    __tablename__ = 'payments'

    paymentid = db.Column(BigInteger, primary_key=True)
    userid = db.Column(String, nullable=False)
    amount = db.Column(Numeric, nullable=False)
    paytoaccount = db.Column(String, nullable=False)
    payfromaccount = db.Column(String, nullable=False)
    paymentdate = db.Column(DateTime, default=datetime)
