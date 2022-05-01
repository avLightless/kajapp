FROM node:lts as build
COPY . /app
WORKDIR /app
RUN npm ci --no-audit --loglevel error --fund false --json true
RUN npm run generate

FROM caddy:2.5.0-alpine
COPY Caddyfile /etc/caddy/Caddyfile
COPY --from=build /app/.output/public /srv