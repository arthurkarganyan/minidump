FROM ruby:2.6.5-alpine

WORKDIR /app

RUN apk add --no-cache ca-certificates wget postgresql && \
    cd /tmp && \
    wget -qO ./rclone.zip https://downloads.rclone.org/rclone-current-linux-amd64.zip && \
    unzip ./rclone.zip && \
    mv ./rclone-*/rclone /usr/bin && \
    rm -rf "/tmp/"* 2>/dev/null || true && \
    gem install bundler:2.0.2

COPY Gemfile Gemfile.lock ./

RUN bundle config --global frozen 1 && \
    bundle install --without test

COPY . .

CMD ["rake", "dump"]
