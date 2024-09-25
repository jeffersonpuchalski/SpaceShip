FROM --platform=amd64 mcr.microsoft.com/dotnet/sdk:8.0 AS build

WORKDIR /app

COPY . .

RUN dotnet publish -c Release -o out

FROM --platform=amd64 build

WORKDIR /app

COPY --from=build /app/out .

ENTRYPOINT ["dotnet", "SpaceEnginners.dll"]

