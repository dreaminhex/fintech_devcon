import type { Config } from "tailwindcss"

const config: Config = {
    content: ["./index.html", "./src/**/*.{js,ts,jsx,tsx}"],
    darkMode: "class",
    theme: {
        extend: {
            fontFamily: {
                sans: ['"Mona Sans"', 'ui-sans-serif', 'system-ui'],
            }
        },
    },
    plugins: [],
}

export default config
