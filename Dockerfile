FROM ruby:2.5.3-alpine

RUN apk add --no-cache ca-certificates wget && \
    cd /tmp && \
    wget -qO ./rclone.zip https://downloads.rclone.org/rclone-current-linux-amd64.zip && \
    unzip ./rclone.zip && \
    mv ./rclone-*/rclone /usr/bin && \
    rm -rf "/tmp/"* 2>/dev/null || true


WORKDIR /app

COPY Gemfile Gemfile.lock ./

RUN bundle config --global frozen 1 && \
    gem update bundler && \
    apk add --no-cache build-base && \
    apk add --no-cache git g++ musl-dev make libstdc++ && \
    bundle install --without test && \
    apk del --purge git g++ musl-dev make && \
    apk del --purge build-base

COPY . .

CMD ["rake", "dump_all"]
