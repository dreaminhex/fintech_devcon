export const setToken = (token: string) => localStorage.setItem("jwt", token);
export const getToken = () => localStorage.getItem("jwt");
export const clearToken = () => {
    localStorage.removeItem("jwt");
    localStorage.removeItem("user");
};
export const isAuthenticated = () => !!getToken();
