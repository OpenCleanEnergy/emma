# !/bin/bash
set -euo pipefail

echo '📥 Pull latest images'
docker compose pull

echo '🚀 Create and start containers'
docker compose up --detach --remove-orphans

echo '⏳ Wait for containers to start'
sleep 5s

echo '♻ Reload caddy configuration'
# https://caddyserver.com/docs/running#usage
CADDY_ID=$(docker container ps --quiet --filter 'name=proxy')
docker exec --workdir /etc/caddy/ ${CADDY_ID} caddy reload

echo '👪 Configure keycloak'
docker run --rm \
  --env-file ./keycloak/config/.env \
  --volume ./keycloak/config:/config \
  quay.io/adorsys/keycloak-config-cli:latest-24.0.1
