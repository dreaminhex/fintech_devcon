import { useEffect, useMemo, useState } from "react";
import { Input } from "@/components/ui/input";
import { Button } from "@/components/ui/button";
import {
    Select,
    SelectContent,
    SelectItem,
    SelectTrigger,
    SelectValue,
} from "@/components/ui/select";
import type { Account, Loan } from "@/lib/types";
import { useSearchParams, useNavigate } from "react-router-dom";

export default function PaymentForm() {
    const [params] = useSearchParams();
    const navigate = useNavigate();

    const initialLoanId = params.get("loanid") || "";
    const [loanId, setLoanId] = useState<string>(initialLoanId);
    const [accounts, setAccounts] = useState<Account[]>([]);
    const [loans, setLoans] = useState<Loan[]>([]);
    const [accountId, setAccountId] = useState<string>("");
    const [amount, setAmount] = useState<string>("");
    const [submitting, setSubmitting] = useState(false);

    const user = useMemo(() => {
        return JSON.parse(localStorage.getItem("user") || "{}");
    }, []);

    useEffect(() => {
        const fetchAccounts = async () => {
            try {
                const res = await fetch("http://localhost:2024/graphql", {
                    method: "POST",
                    headers: { "Content-Type": "application/json" },
                    body: JSON.stringify({
                        query: `
                            query {
                                accounts {
                                accountid
                                accounttoken
                                accountname
                                accountlast4
                                balance
                                }
                            }
                            `,
                    }),
                });
                const json = await res.json();

                const filtered = json.data.accounts.filter((a: Account) =>
                    user.paymentAccounts?.includes(a.accounttoken)
                );
                setAccounts(filtered);
            } catch (err) {
                console.error("Failed to fetch accounts", err);
            }
        };

        const fetchLoans = async () => {
            try {
                const res = await fetch("http://localhost:2024/graphql", {
                    method: "POST",
                    headers: { "Content-Type": "application/json" },
                    body: JSON.stringify({
                        query: `
                            query {
                                loans {
                                loanid
                                loannumber
                                loanname
                                balance
                                }
                            }
                            `,
                    }),
                });
                const json = await res.json();

                const filtered = json.data.loans.filter((l: Loan) =>
                    user.loanAccounts?.includes(l.loannumber)
                );
                setLoans(filtered);
            } catch (err) {
                console.error("Failed to fetch loans", err);
            }
        };

        fetchAccounts();
        fetchLoans();
    }, [user.loanAccounts, user.paymentAccounts]);

    const handleSubmit = async () => {
        if (!accountId || !loanId || !amount) return;
        setSubmitting(true);

        const selectedAccount = accounts.find((a) => a.accountid === accountId);
        if (!selectedAccount) return;

        try {
            const res = await fetch("http://localhost:2024/payment", {
                method: "POST",
                headers: { "Content-Type": "application/json" },
                body: JSON.stringify({
                    userid: user.user_id,
                    amount: parseFloat(amount),
                    loanid: loanId,
                    accounttoken: selectedAccount.accounttoken,
                }),
            });

            const json = await res.json();
            console.log("Payment submitted:", json);
            setAmount("");
        } catch (err) {
            console.error("Payment submission failed", err);
        } finally {
            setSubmitting(false);
        }
    };

    return (
        <div style={{ borderColor: "#7f0c9c" }} className="w-[85%] mx-auto mt-3 border-3 rounded-lg p-4 text-zinc-500 text-2xl">
            <h1 className="title text-2xl text-white">Make a Payment</h1>
            <div>
                <label className="text-zinc-500 text-sm">Pay From Account</label>
                <div className="relative">
                    <Select onValueChange={setAccountId}>
                        <SelectTrigger className="w-full bg-gray-800 text-white">
                            <SelectValue placeholder="Select Account" />
                        </SelectTrigger>
                        <SelectContent>
                            {accounts.map((a) => (
                                <SelectItem key={a.accountid} value={a.accountid}>
                                    {a.accountname} ••••{a.accountlast4}
                                </SelectItem>
                            ))}
                        </SelectContent>
                    </Select>
                </div>
            </div>

            <div>
                <label className="text-zinc-500 text-sm">To Loan Account</label>
                <div>
                    <Select onValueChange={setLoanId}>
                        <SelectTrigger className="w-full bg-gray-800 text-white">
                            <SelectValue placeholder="Select Loan" />
                        </SelectTrigger>
                        <SelectContent>
                            {loans.map((l) => (
                                <SelectItem key={l.loanid} value={l.loanid}>
                                    {l.loanname} — ${l.balance.toLocaleString(undefined, { minimumFractionDigits: 2 })}
                                </SelectItem>
                            ))}
                        </SelectContent>
                    </Select>
                </div>
            </div>
            <div>
                <label className="text-zinc-500 text-sm">Amount</label>
                <Input
                    type="number"
                    min="0"
                    placeholder="0.00"
                    className="w-full bg-gray-800 mt-1 mb-1 text-white"
                    value={amount}
                    onChange={(e) => setAmount(e.target.value)}
                />
            </div>
            <div style={{ borderColor: "#7f0c9c" }} className="flex justify-end gap-4 border-t-2 p-4 mt-4">
                <Button
                    className="bg-red-500 hover:bg-red-600 text-lg font-semibold mt-2 text-white w-1/3"
                    type="button"
                    onClick={() => navigate("/home")}
                >
                    Cancel
                </Button>
                <Button
                    className="w-2/3 mt-2 bg-emerald-500 hover:bg-emerald-600 text-black text-lg font-semibold"
                    disabled={submitting}
                    onClick={handleSubmit}
                >
                    {submitting ? "Submitting..." : "Pay Now"}
                </Button>
            </div>
        </div>
    );
}
