import { SidebarProvider } from "@/components/ui/sidebar"

export default function Layout({ children }: Readonly<{ children: React.ReactNode }>) {
    return (
        <SidebarProvider>
            <div className="mt-38 p-4 w-full h-full overflow-auto">
                {children}
            </div>
        </SidebarProvider>
    );
}