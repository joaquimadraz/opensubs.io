# Alias this container as builder:
FROM bitwalker/alpine-elixir-phoenix as builder

ARG PHOENIX_SECRET_KEY_BASE
ARG SESSION_COOKIE_NAME
ARG SESSION_COOKIE_SIGNING_SALT
ARG SESSION_COOKIE_ENCRYPTION_SALT
ARG DATABASE_URL

ENV MIX_ENV=prod \
    PHOENIX_SECRET_KEY_BASE=$PHOENIX_SECRET_KEY_BASE \
    SESSION_COOKIE_NAME=$SESSION_COOKIE_NAME \
    SESSION_COOKIE_SIGNING_SALT=$SESSION_COOKIE_SIGNING_SALT \
    SESSION_COOKIE_ENCRYPTION_SALT=$SESSION_COOKIE_ENCRYPTION_SALT \
    DATABASE_URL=$DATABASE_URL

WORKDIR /subs

# Umbrella
COPY mix.exs mix.lock ./
COPY config config

# Apps
COPY apps apps
RUN mix do deps.get, deps.compile

WORKDIR /subs
COPY rel rel

RUN mix release --env=prod --verbose

### Release

FROM alpine:3.6

# We need bash and openssl for Phoenix
RUN apk upgrade --no-cache && \
    apk add --no-cache bash openssl

ENV MIX_ENV=prod \
    SHELL=/bin/bash

WORKDIR /subs

COPY --from=builder /subs/_build/prod/rel/subs/releases/0.0.1/subs.tar.gz .

RUN tar zxf subs.tar.gz && rm subs.tar.gz

CMD ["/subs/bin/subs", "foreground"]