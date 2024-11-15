# !/bin/bash
set -euo pipefail

echo '📥 Pull latest images'
docker compose pull

echo '🛑 Stop containers to ensure changed configuration is picked up'
docker compose stop

echo '🚀 Create and (re-)start containers'
docker compose up --detach --remove-orphans

echo '⏳ Wait for containers to start'
sleep 5s

echo '👪 Configure keycloak'
docker run --rm \
  --env-file ./keycloak/config/.env \
  --volume ./keycloak/config:/config \
  quay.io/adorsys/keycloak-config-cli:latest-25
