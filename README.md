# MiniDump

Docker compose example:

```yaml
version: "3.7"

services:
  minidump:
    networks:
      - postgres
    image: "arthurkarganyan/minidump:latest"
    environment:
      - DB_NAME=some_app_production
      - DB=postgress
      - DB_HOST=postgres_host
      - RCLONE_CONFIG=/run/secrets/rclone.sh
    command: sh -c "while true; do rake dump; sleep 86400; done" # every 24 hours
    deploy:
      replicas: 1
      restart_policy:
        condition: on-failure
      resources:
        reservations:
          cpus: '0.1'
          memory: 64M
        limits:
          memory: 64M

networks:
  mongo:
    external: true
 
secrets:
  rclone.sh:
    file: rclone.sh
```


