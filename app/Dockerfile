FROM caddy:2

RUN mkdir -p /var/www/html/app
COPY build/web /var/www/html/app
COPY Caddyfile /etc/caddy/Caddyfile
