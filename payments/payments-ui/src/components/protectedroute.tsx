import { Navigate } from 'react-router-dom';
import { isAuthenticated } from '@/utils/auth';
import type { JSX } from 'react';

export default function ProtectedRoute({ children }: { children: JSX.Element }) {
    return isAuthenticated() ? children : <Navigate to="/" replace />;
}
