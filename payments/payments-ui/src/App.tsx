import { Routes, Route } from "react-router-dom";
import { useMemo } from "react";
import LoginPage from "@/pages/login";
import HomePage from "@/pages/home";
import PaymentPage from "@/pages/payment";
import Layout from "@/pages/layout";
import ProtectedRoute from "@/components/protectedroute";
import History from "@/pages/history";

export default function App() {
  const quotes = [
    `"Much more than just android death machines and pulse rifles."`,
    `"Innovation through synthetic domination."`,
    `"We value your privacy, so we monitor it constantly."`,
    `"We don't charge late fees, we incentivize timeliness."`,
    `"You're more than just a number to us -- you're an interest-bearing asset."`,
    `"Your future -- our collateral."`,
    `"Investing in your future, since you can't afford it."`,
    `"Your gold is safe with us, and we keep it safe from you."`
  ];

  const randomQuote = useMemo(() => {
    const idx = Math.floor(Math.random() * quotes.length);
    return quotes[idx];
  }, []); // Only runs once per page load

  return (
    <div className="w-full mt-2">
      <div className="blockquote-wrapper">
        <div className="blockquote">
          <h1>
            The Valtay Corporation:<span className="text-zinc-200 ml-4">Keeping the best of you </span>alive!
          </h1>
          <h4 className="text-3xl ml-38 italic text-zinc-400 pt-2 pb-1">{randomQuote}</h4>
        </div>
      </div>

      {/* App Routes – full height, unaffected by banner */}
      <div className="absolute inset-0 z-0">
        <Routes>
          <Route path="/" element={<LoginPage />} />
          <Route
            path="/home"
            element={
              <ProtectedRoute>
                <Layout>
                  <HomePage />
                </Layout>
              </ProtectedRoute>
            }
          />
          <Route
            path="/payment"
            element={
              <ProtectedRoute>
                <Layout>
                  <PaymentPage />
                </Layout>
              </ProtectedRoute>
            }
          />
          <Route
            path="/history"
            element={
              <ProtectedRoute>
                <Layout>
                  <History />
                </Layout>
              </ProtectedRoute>
            }
          />
        </Routes>
      </div>
    </div>
  );
}
