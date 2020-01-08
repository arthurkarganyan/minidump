FROM ruby:2.6.5-alpine

WORKDIR /app

RUN apk add --no-cache ca-certificates wget postgresql && \
    cd /tmp && \
    wget -qO ./rclone.zip https://downloads.rclone.org/rclone-current-linux-amd64.zip && \
    unzip ./rclone.zip && \
    mv ./rclone-*/rclone /usr/bin && \
    rm -rf "/tmp/"* 2>/dev/null || true

COPY . .

CMD ["rake", "dump"]
