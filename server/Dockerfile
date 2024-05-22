# Learn about building .NET container images:
# https://github.com/dotnet/dotnet-docker/blob/main/samples/README.md
FROM mcr.microsoft.com/dotnet/sdk:8.0-alpine AS build
WORKDIR /source

COPY .editorconfig .
COPY Directory.Build.props .
COPY *.sln .
COPY src/. .
RUN dotnet restore Emma.Server/Emma.Server.csproj
RUN dotnet publish Emma.Server/Emma.Server.csproj \
    --no-restore \
    --configuration Release \
    --output /app

# final stage/image
FROM mcr.microsoft.com/dotnet/aspnet:8.0-alpine

LABEL org.opencontainers.image.source = "https://github.com/OpenCleanEnergy/emma"
LABEL org.opencontainers.image.description = "EMMA server container image"
LABEL org.opencontainers.image.licenses = "AGPL-3.0"

EXPOSE 5000
ENV ASPNETCORE_HTTP_PORTS=5000
WORKDIR /app
COPY --from=build /app .
USER $APP_UID
ENTRYPOINT ["./Emma.Server"]
