# Start from SDK base image
FROM mcr.microsoft.com/dotnet/sdk:9.0 AS build
WORKDIR /src

# Copy projects using paths relative to root (context: .)
COPY payments/Payments.Domain/ ./Payments.Domain/
COPY payments/Payments.API/ ./Payments.API/

# Restore and build
RUN dotnet restore ./Payments.API/Payments.API.csproj
RUN dotnet publish ./Payments.API/Payments.API.csproj -c Release -o /app/publish

# Final runtime image
FROM mcr.microsoft.com/dotnet/aspnet:9.0 AS runtime
WORKDIR /app
COPY --from=build /app/publish .

ENTRYPOINT ["dotnet", "Payments.API.dll"]
