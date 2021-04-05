# Dockerfile
FROM elixir:1.10.3-alpine as build

# prepare build dir
RUN mkdir /app
WORKDIR /app

# install hex + rebar
RUN mix local.hex --force && \
    mix local.rebar --force

# set build ENV
ENV MIX_ENV=prod

# Don't put these here for production usecases
ENV DATABASE_URL=ecto://postgres:postgres@postgres:5432/api_server_prod
ENV SECRET_KEY_BASE=secret

# install mix dependencies
COPY mix.exs mix.lock ./
COPY config ./
COPY deps ./
RUN mix deps.compile

# build release
COPY . .

RUN mix release

# prepare release image
FROM elixir:1.10.3-alpine
WORKDIR /app

COPY --from=build /app/_build/prod/rel/api_server ./

# ENV REPLACE_OS_VARS=true
# ENV HTTP_PORT=4000 BEAM_PORT=14000 ERL_EPMD_PORT=24000
# EXPOSE $HTTP_PORT $BEAM_PORT $ERL_EPMD_PORT

ENTRYPOINT ["/app/bin/api_server"]