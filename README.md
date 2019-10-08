# MiniDump

Docker compose example:

```yaml
version: "3.7"

services:
  minidump:
    networks:
      - mongo
    image: "arthurkarganyan/minidump:latest"
    environment:
      - MONGO_HOST=mongo
      - RCLONE_CONFIG=/run/secrets/rclone.sh
    command: sh -c "while true; do rake dump_all; sleep 86400; done" # every 24 hours
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


