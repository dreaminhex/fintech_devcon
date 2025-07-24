FROM mcr.microsoft.com/dotnet/sdk:9.0 AS build
WORKDIR /src

COPY ./Payments.Domain ./Payments.Domain
COPY ./Payments.API ./Payments.API
RUN dotnet restore ./Payments.API/Payments.API.csproj

RUN dotnet publish ./Payments.API/Payments.API.csproj -c Release -o /app/publish

FROM mcr.microsoft.com/dotnet/aspnet:9.0 AS runtime
WORKDIR /app
COPY --from=build /app/publish .

ENTRYPOINT ["dotnet", "Payments.API.dll"]
