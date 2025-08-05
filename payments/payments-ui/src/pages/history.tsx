import { useEffect, useState } from "react";
import { useNavigate, useSearchParams } from "react-router-dom";
import type { Payment } from "@/lib/types";

export default function HistoryPage() {
    const [params] = useSearchParams();
    const loanNumber = params.get("loannumber");
    const [payments, setPayments] = useState<Payment[]>([]);
    const [loading, setLoading] = useState(true);
    const navigate = useNavigate();

    useEffect(() => {
        if (!loanNumber) return;

        const fetchPayments = async () => {
            try {
                console.log("Loading payments")
                const res = await fetch(`http://localhost:2024/payments?loannumber=${loanNumber}`);
                const json = await res.json();
                setPayments(json);
            } catch (err) {
                console.error("Failed to load payment history", err);
            } finally {
                setLoading(false);
            }
        };

        fetchPayments();
    }, [loanNumber]);

    let content: React.ReactNode = null;

    if (loading) {
        content = <p>Loading...</p>;
    } else if (payments.length === 0) {
        content = <p className="text-gray-400">No payments found for this loan.</p>;
    } else {
        content = (
            <div className="space-y-4">
                {payments.map((p) => (
                    <div
                        key={p.paymentid}
                        className="bg-zinc-800 p-4 rounded shadow border border-zinc-700"
                    >
                        <div className="text-zinc-400 ">
                            🥮<span className="text-green-400 font-semibold">{Number(p.total).toLocaleString(undefined, { minimumFractionDigits: 2 })}</span> paid on{" "}
                            {new Date(p.paymentdate).toLocaleDateString()}
                            <span className="pl-5">
                                <span className="pl-5 font-normal text-zinc-500 italic pr-2">Principal</span> 🥮{Number(p.principal).toLocaleString(undefined, { minimumFractionDigits: 2 })}{" "}
                                <span className="pl-5 font-normal text-zinc-500 italic pr-2">Interest</span> 🥮{Number(p.interest).toLocaleString(undefined, { minimumFractionDigits: 2 })}
                            </span>
                        </div>
                    </div>
                ))}
            </div>
        );
    }

    return (
        <div
            style={{ borderColor: "#7f0c9c" }}
            className="w-[84%] mt-3 mx-auto bg-zinc-900 p-8 rounded-xl shadow-lg border-3 relative"
        >
            <button
                onClick={() => navigate("/home")}
                className="absolute top-8 right-8 bg-purple-700 hover:bg-purple-800 text-white text-sm font-semibold px-4 py-2 rounded"
            >
                Done
            </button>
            <h1 className="title text-3xl text-zinc-200 mb-4">
                Payment History for {loanNumber}
            </h1>
            {content}
        </div>
    );
}