# syntax=docker/dockerfile:1

# === Builder Stage ===
FROM node:18-alpine AS builder
WORKDIR /build

RUN apk add --no-cache make gcc g++ python3

RUN npm install -g pnpm

COPY package.json pnpm-lock.yaml ./

COPY --link scripts/ ./scripts/
RUN chmod +x ./scripts/*.sh

RUN CI=true pnpm install --prod --frozen-lockfile

COPY --link . .

# === Runner Stage ===
FROM node:18-alpine AS runner

RUN apk --no-cache add curl

WORKDIR /app

ENV NODE_ENV=production \
    HTTP_HOST=0.0.0.0 \
    DOCKER=true

COPY --from=builder /build /app

RUN chmod +x /app/scripts/start.sh

ENTRYPOINT ["/app/scripts/start.sh"]

HEALTHCHECK --interval=15s --timeout=5s --start-period=60s \
    CMD curl -f http://localhost:${HTTP_PORT}/status || exit 1

LABEL org.opencontainers.image.source="https://github.com/discord-tickets/bot" \
      org.opencontainers.image.description="The most popular open-source ticket bot for Discord." \
      org.opencontainers.image.licenses="GPL-3.0-or-later"
