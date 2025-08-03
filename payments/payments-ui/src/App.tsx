import { Routes, Route } from "react-router-dom";
import LoginPage from "@/pages/login";
import HomePage from "@/pages/home";
import PaymentPage from "@/pages/payment";
import Layout from "@/pages/layout";
import ProtectedRoute from "@/components/protectedroute";

export default function App() {
  return (
    <div className="relative h-screen w-screen bg-zinc-950 text-white overflow-hidden">
      {/* Banner image (absolute, does not affect layout) */}
      <div className="absolute top-0 left-0 w-full h-16 z-10">
        <img
          src="/banner.png"
          alt="Banner"
          className="w-full h-full object-cover"
        />
        <div className="absolute inset-0 bg-black/30 flex items-center justify-center">
          <h1 className="text-3xl font-bold text-zinc-400 tracking-wider drop-shadow">
            FINTECH FINANCIAL SERVICES
          </h1>
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
        </Routes>
      </div>
    </div>
  );
}
