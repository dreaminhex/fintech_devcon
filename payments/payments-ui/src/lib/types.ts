type Account = {
    accountid: string;
    accounttoken: string;
    accountname: string;
    accountlast4: string;
    balance: number;
};

type Loan = {
    loanid: string;
    loannumber: string;
    loanname: string;
    balance: number;
    lastpaymentdate: Date;
    nextpaymentdate: Date;
    lastpaymentamount: number;
    rate: number;
    term: number;
}

type Payment = {
    paymentid: number;
    userid: string;
    loannumber: string;
    accounttoken: string;
    principal: number;
    interest: number;
    total: number;
    paymentdate: string;
};


export type {Account, Loan, Payment};