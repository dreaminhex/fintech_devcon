from ariadne import graphql_sync
from flask import request, jsonify, send_from_directory
from datetime import datetime, timezone

def register_routes(app):

    # Post a payment to a loan
    @app.route("/payment", methods=["POST"])
    def create_payment():
        from .models import Payment
        data = request.json
        payment = Payment(
            userid=data["userid"],
            amount=data["amount"],
            loanid=data["loanid"],
            accounttoken=data["accounttoken"],
            paymentdate=datetime.now(timezone.utc)
        )
        from .db import db
        db.session.add(payment)
        db.session.commit()
        return jsonify({"status": "ok", "id": payment.id})

    # Get an account by account id
    @app.route("/account", methods=["GET"])
    def account_by_id():
        accountid = request.args.get("accountid")
        if not accountid:
            return jsonify({"error": "Missing accountid parameter"}), 400
        
        from .db import db
        from .models import Account
        account = db.session.query(Account).filter_by(accountid=accountid).first()
        if not account:
            return jsonify({"error": "Account not found"}), 404

        return jsonify({
            "accountid": account.accountid,
            "accounttoken": account.accounttoken,
            "accountname": account.accountname,
            "accountlast4": account.accountlast4,
            "accountexpmonth": account.accountexpmonth,
            "accountexpyear": account.accountexpyear,
            "accounttype": account.accounttype,
            "balance": account.balance
        })

    @app.route("/account", methods=["POST"])
    def accounts_by_accountids():
        data = request.get_json()
        
        if not data or "accountids" not in data:
            return jsonify({"error": "Missing accountids in request body"}), 400

        accountids = data["accountids"]

        if not isinstance(accountids, list) or not all(isinstance(a, str) for a in accountids):
            return jsonify({"error": "accountids must be a list of strings"}), 400

        from .db import db
        from .models import Account
        accounts = (
            db.session.query(Account)
            .filter(Account.accountid.in_(accountids))
            .all()
        )

        return jsonify([
            {
                "accountid": account.accountid,
                "accounttoken": account.accounttoken,
                "accountname": account.accountname,
                "accountlast4": account.accountlast4,
                "accountexpmonth": account.accountexpmonth,
                "accountexpyear": account.accountexpyear,
                "accounttype": account.accounttype,
                "balance": account.balance
            }
            for account in accounts
        ])
    
    @app.route("/loan", methods=["GET"])
    def loan_by_loanid():
        loanid = request.args.get("loanid")
        if not loanid:
            return jsonify({"error": "Missing loanid parameter"}), 400
        
        from .db import db
        from .models import Loan
        loan = db.session.query(Loan).filter_by(loanid=loanid).first()
        if not loan:
            return jsonify({"error": "Loan not found"}), 404

        return jsonify(
            {
                "loanid": loan.loanid,
                "loannumber": loan.loannumber,
                "loanname": loan.loanname,
                "balance": loan.balance,
                "lastpaymentdate": loan.lastpaymentdate,
                "nextpaymentdate": loan.nextpaymentdate,
                "lastpaymentamount": loan.lastpaymentamount,
                "rate": loan.rate,
                "term": loan.term,
            }
        )
    
    @app.route("/payments", methods=["GET"])
    def payments_by_loannumber():
        loannumber = request.args.get("loannumber")
        if not loannumber:
            return jsonify({"error": "Missing loannumber parameter"}), 400
        
        from .db import db
        from .models import Loan
        loan = db.session.query(Loan).filter_by(loannumber=loannumber).first()
        if not loan:
            return jsonify({"error": "Loan not found"}), 404

        from .models import Payment
        payments = (
            db.session.query(Payment)
            .filter_by(loannumber=loannumber)
            .order_by(Payment.paymentdate.desc())
            .all()
        )

        return jsonify([
            {
                "paymentid": payment.paymentid,
                "userid": payment.userid,
                "loannumber": payment.loannumber,
                "principal": payment.principal,
                "interest": payment.interest,
                "total": payment.total,
                "accounttoken": payment.accounttoken,
                "paymentdate": payment.paymentdate
            }
            for payment in payments
        ])

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

