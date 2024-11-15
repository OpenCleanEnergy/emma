FROM quay.io/keycloak/keycloak:25.0

# User Id: 1000
# see https://github.com/keycloak/keycloak/blob/main/quarkus/container/Dockerfile
COPY --chown=1000:0 entrypoint.sh .
COPY --chown=1000:0 themes /opt/keycloak/themes
RUN chmod +x entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
