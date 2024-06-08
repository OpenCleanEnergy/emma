#!/bin/bash

FILE=/run/secrets/.env
if [ ! -f "${FILE}" ]; then
  echo "ERROR: ${FILE} not found."
  exit 1
fi

# automatically export all variables
set -a
# set variables from docker secrets
source ${FILE}
# disables automatic export of variables
set +a

# https://github.com/keycloak/keycloak/blob/main/quarkus/container/Dockerfile
# Pass all command parameters
exec /opt/keycloak/bin/kc.sh "$@"
