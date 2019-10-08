# MiniDump

```yaml
version: "3.7"

services:
  minidump:
    networks:
      - mongo
    image: "${REGISTRY_DOMAIN}/minidump:latest"
    command: sh -c "while true; do rake dump_all; sleep 7200; done" # every 2 hours
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
```


