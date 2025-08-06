import { useState } from "react";
import { useNavigate } from "react-router-dom";
import { setToken } from "@/utils/auth";

export default function LoginPage() {
    const [email, setEmail] = useState("");
    const [password, setPassword] = useState("");
    const navigate = useNavigate();

    const handleSubmit = async (e: React.FormEvent) => {
        e.preventDefault();

        try {
            const res = await fetch("http://localhost:2022/login", {
                method: "POST",
                headers: { "Content-Type": "application/json" },
                body: JSON.stringify({ emailAddress: email, password }),
            });

            if (!res.ok) {
                alert("Invalid email or password");
                return;
            }

            const data = await res.json();
            const token = data.token;
            setToken(token);
            localStorage.setItem("user", JSON.stringify(data.user));
            navigate("/home");
        } catch (err) {
            console.error("Login error:", err);
            alert("Login failed.");
        }
    };

    return (
        <div className="mt-45 flex items-center justify-center bg-zinc-950 text-white">
            <form
                onSubmit={handleSubmit} style={{ borderColor: "#7f0c9c" }}
                className="w-[81%] bg-zinc-900 p-8 rounded-xl shadow-lg border-3"
            >
                <h2 className="text-3xl font-bold text-center mb-3 bg-gradient-to-r from-indigo-400 via-violet-500 via-blue-500 to-emerald-400 bg-clip-text text-transparent">
                    LOGIN TO VALTAY FINANCIAL CORPORATION
                </h2>
                <label className="block mb-2 text-sm font-medium text-zinc-300">
                    Email Address
                </label>
                <input
                    type="email"
                    className="w-full mb-4 p-2 rounded bg-zinc-800 text-white border border-zinc-600 focus:outline-none focus:ring-2 focus:ring-violet-500"
                    placeholder="you@domain"
                    value={email}
                    onChange={(e) => setEmail(e.target.value)}
                    required
                />

                <label className="block mb-2 text-sm font-medium text-zinc-300">
                    Password
                </label>
                <input
                    type="password"
                    className="w-full mb-6 p-2 rounded bg-zinc-800 text-white border border-zinc-600 focus:outline-none focus:ring-2 focus:ring-violet-500"
                    placeholder=""
                    value={password}
                    onChange={(e) => setPassword(e.target.value)}
                    required
                />

                <button
                    type="submit"
                    className="w-full py-2 rounded bg-gradient-to-r from-indigo-500 via-blue-500 to-emerald-400 hover:opacity-90 text-black font-semibold shadow-md transition"
                >
                    Sign In
                </button>
            </form>
        </div>
    );
}
