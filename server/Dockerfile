# https://github.com/dotnet/dotnet-docker/blob/main/samples/aspnetapp/Dockerfile.alpine
FROM --platform=$BUILDPLATFORM mcr.microsoft.com/dotnet/sdk:8.0-alpine AS build
ARG TARGETARCH
WORKDIR /source

COPY .editorconfig .
COPY Directory.Build.props .
COPY *.sln .
COPY src/. .
RUN dotnet restore Emma.Server/Emma.Server.csproj \
    --arch $TARGETARCH

# Skip swagger generation in docker image.
ENV SKIP_SWAGGER_GEN=1
RUN dotnet publish Emma.Server/Emma.Server.csproj \
    --no-restore \
    --arch $TARGETARCH \
    --output /app

# final stage/image
FROM mcr.microsoft.com/dotnet/aspnet:8.0-alpine
ENV ASPNETCORE_HTTP_PORTS=5000
EXPOSE ${ASPNETCORE_HTTP_PORTS}
WORKDIR /app
COPY --from=build /app .
USER $APP_UID
ENTRYPOINT ["./Emma.Server"]

LABEL org.opencontainers.image.source="https://github.com/OpenCleanEnergy/emma"
LABEL org.opencontainers.image.licenses="AGPL-3.0"
LABEL org.opencontainers.image.description="EMMA server container image. \
    The server is listening on port ${ASPNETCORE_HTTP_PORTS}"
