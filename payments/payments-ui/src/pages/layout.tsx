import { SidebarProvider } from "@/components/ui/sidebar"
import { AppSidebar } from "@/components/app-sidebar"

export default function Layout({ children }: Readonly<{ children: React.ReactNode }>) {
    return (
        <SidebarProvider>
            <AppSidebar />
            <main className="p-6 mt-16">                    
                {children}
            </main>
        </SidebarProvider>
    );
}