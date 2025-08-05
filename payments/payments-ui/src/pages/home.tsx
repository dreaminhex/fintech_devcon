import type { Loan } from "@/lib/types";
import { useEffect, useMemo, useState } from "react";
import { useNavigate } from "react-router-dom";

export default function Home() {

    const navigate = useNavigate();
    const [loans, setLoans] = useState<Loan[]>([]);
    const [loading, setLoading] = useState(true);
    const getUser = () => JSON.parse(localStorage.getItem("user") || "{}");
    const user = useMemo(getUser, []);

    useEffect(() => {
        const fetchLoans = async () => {
            try {
                // Query Python GraphQL API
                const gqlRes = await fetch("http://localhost:2024/graphql", {
                    method: "POST",
                    headers: {
                        "Content-Type": "application/json",
                    },
                    body: JSON.stringify({
                        query: `
                            query GetLoans {
                                loans {
                                    loanid
                                    loannumber
                                    loanname
                                    balance
                                    lastpaymentdate
                                    nextpaymentdate
                                    lastpaymentamount
                                    rate
                                    term
                                }
                            }
                            `,
                    }),
                });

                const gqlData = await gqlRes.json();

                // Filter loans to only those matching user's loanAccounts
                const matchingLoans = gqlData.data.loans.filter((loan: Loan) =>
                    user.loanAccounts.includes(loan.loannumber)
                );

                setLoans(matchingLoans);

            } catch (err) {
                console.error("Error fetching loans:", err);
            } finally {
                setLoading(false);
            }
        };

        fetchLoans();
    }, [user.loanAccounts]);

    return (
        <div className="w-full">
            <div
                style={{ borderColor: "#7f0c9c" }}
                className="bg-purple-900 flex items-center justify-between w-auto mb-0 ml-2 mt-3 border-t-3 border-l-3 border-r-3 rounded-t-lg px-4 py-2"
            >
                <h2 className="text-zinc-200 text-2xl">
                    Crawler #4,122 {user.userName}'s Active Loans
                </h2>
                <button
                    onClick={() => {
                        localStorage.removeItem("user");
                        navigate("/");
                    }}
                    className="ml-4 bg-pink-800 hover:bg-pink-500 text-white font-semibold px-4 py-1 rounded shadow text-sm"
                >
                    Sign Out
                </button>
            </div>


            {loading ? (
                <p>Loading your loans...</p>
            ) : (
                <div className="space-y-4 w-full">

                    {loans.map((loan) => (
                        <div
                            key={loan.loanid}
                            className="bg-zinc-800 p-6 mb-6 rounded shadow border-2 border-zinc-600 w-full"
                        >
                            {/* Header */}
                            <h1 className="title text-3xl text-zinc-200 mb-4">{loan.loanname}</h1>

                            {/* Loan Metadata */}
                            <div className="grid grid-cols-4 gap-4 text-lg text-zinc-300 mb-6">
                                <div>
                                    <span className="block border-b text-2xl text-zinc-400">Loan #</span>
                                    <span className="block font-semibold text-purple-500 text-xl">{loan.loannumber}</span>
                                </div>
                                <div>
                                    <span className="block border-b text-2xl text-zinc-400">Rate / Term</span>
                                    <span className="block font-semibold text-pink-400 text-xl">
                                        {loan.rate.toFixed(2)}% / {loan.term} mos
                                    </span>
                                </div>
                                <div>
                                    <span className="block border-b text-2xl text-zinc-400">Current Balance</span>
                                    <span className="block font-semibold text-red-500 text-xl">
                                        🥮{loan.balance.toLocaleString(undefined, { minimumFractionDigits: 2 })}
                                    </span>
                                </div>
                                <div>
                                    <span className="block border-b text-2xl text-zinc-400">Last Payment Date</span>
                                    <span className="block font-semibold text-blue-400 text-xl">
                                        {new Date(loan.lastpaymentdate).toLocaleDateString()}
                                    </span>
                                </div>
                                <div>
                                    <span className="block border-b text-2xl text-zinc-400">Next Payment Due</span>
                                    <span className="block font-semibold text-green-500 text-xl">
                                        {new Date(loan.nextpaymentdate).toLocaleDateString()}
                                    </span>
                                </div>
                                
                                <div>
                                    <span className="block border-b text-2xl text-zinc-400">Next Payment Amount</span>
                                    <span className="block font-semibold text-yellow-400 text-xl">
                                        🥮{loan.lastpaymentamount.toLocaleString(undefined, { minimumFractionDigits: 2 })}
                                    </span>
                                </div>
                                
                            </div>

                            {/* Actions */}
                            <div className="flex justify-end gap-4 p-4">
                                <button
                                    onClick={() => navigate(`/payment?loanid=${loan.loanid}`)}
                                    className="bg-emerald-700 hover:bg-emerald-500 text-white text-lg font-semibold px-5 py-2 rounded shadow transition"
                                >
                                    Make a Payment
                                </button>
                                <button
                                    onClick={() => navigate(`/history?loannumber=${loan.loannumber}`)}
                                    className="bg-indigo-700 hover:bg-indigo-500 text-white text-lg font-semibold px-5 py-2 rounded shadow transition"
                                >
                                    View Payment History
                                </button>
                            </div>
                        </div>
                    ))}
                </div>
            )}
        </div>
    );
}
