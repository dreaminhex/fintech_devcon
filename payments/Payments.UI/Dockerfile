# Start from SDK base image
FROM mcr.microsoft.com/dotnet/sdk:9.0 AS build
WORKDIR /src

# Copy projects using paths relative to root (context: .)
COPY payments/Payments.Domain/ ./Payments.Domain/
COPY payments/Payments.UI/ ./Payments.UI/

# Restore and build
RUN dotnet restore ./Payments.UI/Payments.UI.csproj
RUN dotnet publish ./Payments.UI/Payments.UI.csproj -c Release -o /app/publish

# Final runtime image
FROM mcr.microsoft.com/dotnet/aspnet:9.0 AS runtime
WORKDIR /app
COPY --from=build /app/publish .

ENTRYPOINT ["dotnet", "Payments.UI.dll"]