FROM ruby:2.5.3-alpine

RUN apk add --no-cache ca-certificates wget postgresql && \
    cd /tmp && \
    wget -qO ./rclone.zip https://downloads.rclone.org/rclone-current-linux-amd64.zip && \
    unzip ./rclone.zip && \
    mv ./rclone-*/rclone /usr/bin && \
    rm -rf "/tmp/"* 2>/dev/null || true

WORKDIR /app

COPY . .

CMD ["rake", "dump"]
