import { useEffect, useState } from "react";

interface Loan {
    loanid: string;
    loannumber: string;
    loanname: string;
    balance: number;
}

export default function Home() {

    const [loans, setLoans] = useState<Loan[]>([]);
    const [loading, setLoading] = useState(true);
    const user = JSON.parse(localStorage.getItem("user") || "{}");

    useEffect(() => {
        const fetchLoans = async () => {
            try {
                // Query Python GraphQL API
                const gqlRes = await fetch("http://127.0.0.1:2024/graphql", {
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
                        <div className="blockquote-wrapper">
                <div className="blockquote">
                    <h1>
                        The Valtay Corporation<span className="text-zinc-200 ml-4">Keeping the best of you alive since </span>3072!
                    </h1>
                    <h4 className="text-2xl font-bold mb-4 text-purple-500">Hi there, {user.userName}!</h4>
                </div>
            </div>

            <h2 className="pb-5 text-2xl">Here are your current loans</h2>
            
            {loading ? (
                <p>Loading your loans...</p>
            ) : (
                <div className="space-y-4 w-full">

                    {loans.map((loan) => (
                        <div
                            key={loan.loanid}
                            className="bg-zinc-800 p-4 mb-6 rounded shadow border border-zinc-700 w-full"
                        >
                            <h1 className="text-3xl pb-4 font-semibold text-white">{loan.loanname}</h1>
                            <p className="text-2xl text-zinc-400">Loan #: {loan.loannumber}</p>
                            <p className="text-xl mt-2 text-zinc-300 mb-4">
                                Balance: ${loan.balance.toFixed(2)}
                            </p>

                            <div className="flex justify-end">
                                <button className="bg-emerald-500 hover:bg-emerald-600 text-black text-2xl font-semibold px-4 py-2 rounded shadow transition">
                                    Make a Payment
                                </button>
                            </div>
                        </div>
                    ))}
                </div>

            )}
        </div>
    );
}
