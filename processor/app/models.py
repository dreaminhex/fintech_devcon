from sqlalchemy import DateTime, BigInteger, Numeric, SmallInteger, String
from .db import db
from datetime import datetime

class Loan(db.Model):
    __tablename__ = 'loans'
    loanid = db.Column(BigInteger, primary_key=True)
    loannumber = db.Column(String, nullable=False, unique=True)
    loanname = db.Column(String, nullable=False)
    balance = db.Column(Numeric(12, 2), nullable=False, default=0.00)
    lastpaymentdate = db.Column(DateTime, default=datetime)
    nextpaymentdate = db.Column(DateTime, default=datetime)
    lastpaymentamount = db.Column(Numeric(12, 2), nullable=False, default=0.00)
    rate = db.Column(Numeric(8, 4), nullable=False, default=0.00)
    term = db.Column(Numeric(4, 0), nullable=False, default=0.00)

class Account(db.Model):
    __tablename__ = 'accounts'
    accountid = db.Column(BigInteger, primary_key=True)
    accounttoken = db.Column(String, nullable=False, unique=True)
    accountname = db.Column(String, nullable=False)
    accountlast4  = db.Column(SmallInteger, nullable=False)
    accountexpmonth = db.Column(SmallInteger, nullable=False)
    accountexpyear = db.Column(SmallInteger, nullable=False)
    accounttype = db.Column(SmallInteger, nullable=False)
    balance = db.Column(Numeric(12, 2), nullable=False, default=0.00)

class Payment(db.Model):
    __tablename__ = 'payments'
    paymentid = db.Column(BigInteger, primary_key=True)
    userid = db.Column(String, nullable=False)
    loannumber = db.Column(String, nullable=False)
    accounttoken = db.Column(String, nullable=False)
    principal = db.Column(Numeric(12, 2), nullable=False, default=0.00)
    interest = db.Column(Numeric(12, 2), nullable=False, default=0.00)
    total = db.Column(Numeric(12, 2), nullable=False, default=0.00)
    paymentdate = db.Column(DateTime, default=datetime)