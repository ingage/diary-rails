FROM node:16-buster-slim AS node
FROM ruby:3.0.1-slim-buster

# node
COPY --from=node /usr/local/bin/ /usr/local/bin/
COPY --from=node /usr/local/lib/node_modules /usr/local/lib/node_modules

RUN apt-get update && apt-get install --no-install-recommends -y \
    build-essential \
    libjemalloc-dev \
    libjemalloc2 \
    libxml2-dev \
    libxslt-dev \
    tzdata \
    ca-certificates \
    libidn11 \
    libpq-dev \
    imagemagick \
    libmagickwand-dev \
    git \
    vim \
    bash \
    less \
    curl

ENV LD_PRELOAD=/usr/lib/x86_64-linux-gnu/libjemalloc.so.2

ENV LANG=C.UTF-8 \
    TZ=Asia/Tokyo \
    APP_ROOT=/journally \
    YARN_VERSION=1.22.5 \
    BUNDLER_VERSION=2.2.16 \
    PATH="/root/.yarn/bin:/root/.config/yarn/global/node_modules/.bin:$PATH"

RUN curl -o- -L https://yarnpkg.com/install.sh | bash -s -- --version $YARN_VERSION && \
    mkdir -p $APP_ROOT

RUN echo $APP_ROOT
COPY Gemfile* $APP_ROOT/
COPY frontend/ $APP_ROOT/frontend/

WORKDIR $APP_ROOT

RUN bundle install --jobs=4 && cd frontend/ && yarn install --pure-lockfile

# HEALTHCHECK CMD curl -fs http://localhost:${NODE_PORT:-3000} || exit 1

EXPOSE 3000
