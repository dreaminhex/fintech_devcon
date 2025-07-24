# Build the Blazor WebAssembly app
FROM mcr.microsoft.com/dotnet/sdk:9.0 AS build
WORKDIR /src

# Copy projects
COPY payments/Payments.Domain/ ./Payments.Domain/
COPY payments/Payments.UI/ ./Payments.UI/

# Publish the WASM app (build static assets into wwwroot)
RUN dotnet publish ./Payments.UI/Payments.UI.csproj -c Release -o /app/build

# Use Nginx to serve the static files
FROM nginx:alpine AS final
COPY --from=build /app/build/wwwroot /usr/share/nginx/html

EXPOSE 80