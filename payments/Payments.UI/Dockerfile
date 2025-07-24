FROM mcr.microsoft.com/dotnet/sdk:9.0 AS build
WORKDIR /src

COPY ./Payments.Domain ./Payments.Domain
COPY ./Payments.UI ./Payments.UI
RUN dotnet restore ./Payments.UI/Payments.UI.csproj

RUN dotnet publish ./Payments.UI/Payments.UI.csproj -c Release -o /app/publish

FROM mcr.microsoft.com/dotnet/aspnet:9.0 AS runtime
WORKDIR /app
COPY --from=build /app/publish .

ENTRYPOINT ["dotnet", "Payments.UI.dll"]