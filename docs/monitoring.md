# Monitoring & Troubleshooting Guide

How to observe the container's health, watch its resource usage, and diagnose common
problems for the Dockerized web server.

## 1. Is the container healthy?

The image ships with a `HEALTHCHECK`, so Docker tracks health automatically.

```bash
# Quick verdict: starting | healthy | unhealthy
docker inspect --format '{{.State.Health.Status}}' codealpha-webserver

# Full health history (last probes, exit codes, output)
docker inspect --format '{{json .State.Health}}' codealpha-webserver
```

In `docker ps`, a healthy container shows `(healthy)` next to its status:

```
CONTAINER ID   IMAGE                   STATUS                   PORTS
xxxxxxxxxxxx   codealpha-webserver     Up 2 minutes (healthy)   0.0.0.0:8080->80/tcp
```

## 2. Live resource usage

```bash
# Streaming CPU %, memory, network and block I/O
docker stats codealpha-webserver

# One-shot snapshot (no streaming)
docker stats --no-stream codealpha-webserver
```

## 3. Logs

```bash
# Tail the access/error logs
docker logs codealpha-webserver

# Follow live
docker logs -f codealpha-webserver
```

## 4. Probe the server directly

```bash
# Health endpoint returns "ok"
curl http://localhost:8080/healthz

# Home page
curl -I http://localhost:8080/
```

## 5. Common problems & fixes

| Symptom | Likely cause | Fix |
|---|---|---|
| `port is already allocated` | Host port 8080 in use | Change the host port: `-p 8081:80` (or edit compose) |
| Status stuck `unhealthy` | nginx not serving `/healthz` | `docker logs` the container; confirm `nginx/default.conf` was copied |
| `Cannot connect to the Docker daemon` | Docker engine not running | Start Docker Desktop / `dockerd` and retry |
| Edits not showing | Browser/nginx cache, or image not rebuilt | Rebuild: `docker compose up -d --build`, then hard-refresh |
| Container exits immediately | Bad config syntax | `docker logs` shows the nginx config error line |

## 6. Clean up

```bash
docker compose down            # stop + remove the stack
docker rmi codealpha-webserver:latest   # remove the image
docker system prune            # reclaim dangling build cache (optional)
```
