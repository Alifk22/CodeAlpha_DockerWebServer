# CodeAlpha_DockerWebServer

> **CodeAlpha DevOps Internship — Task 4: Web Server using Docker**

A reproducible, production-style **web server packaged in a Docker container**. A static
site is served by **nginx** from a small Alpine-based image, with a built-in container
**health check**, one-command orchestration via **Docker Compose**, and a monitoring guide.

---

## ✨ What this demonstrates
- Docker containerization fundamentals (image, layers, build context)
- Writing a clean, pinned **Dockerfile**
- The full **container lifecycle**: build → run → inspect → stop → remove
- **Health monitoring** with `HEALTHCHECK` and a dedicated `/healthz` endpoint
- One-command orchestration with **Docker Compose**
- Troubleshooting and resource monitoring (`docker stats`, `docker logs`, `docker inspect`)

## 🧱 Architecture

```
Browser ──HTTP:8080──▶ Docker host ──:80──▶ [ nginx container ]
                                              ├─ /usr/share/nginx/html  (static site)
                                              └─ HEALTHCHECK → GET /healthz
```

## 📂 Project structure

```
CodeAlpha_DockerWebServer/
├── Dockerfile              # builds the nginx image
├── docker-compose.yml      # one-command run with healthcheck + restart policy
├── .dockerignore           # keeps the build context small
├── nginx/
│   └── default.conf        # nginx server config + /healthz endpoint
├── site/
│   ├── index.html          # the served web page
│   └── styles.css
└── docs/
    ├── monitoring.md       # health, logs, stats, troubleshooting
    └── screenshots/        # demo screenshots
```

## 🚀 Quick start

**Prerequisite:** Docker installed and running.

### Option A — Docker Compose (recommended)
```bash
docker compose up -d --build
# open http://localhost:8080
docker compose down            # when finished
```

### Option B — Plain Docker
```bash
docker build -t codealpha-webserver .
docker run -d --name codealpha-webserver -p 8080:80 codealpha-webserver
# open http://localhost:8080
docker stop codealpha-webserver && docker rm codealpha-webserver
```

## ❤️ Health & monitoring

```bash
# Health verdict: healthy / unhealthy
docker inspect --format '{{.State.Health.Status}}' codealpha-webserver

# Live resource usage
docker stats codealpha-webserver

# Health endpoint
curl http://localhost:8080/healthz   # -> ok
```

See **[docs/monitoring.md](docs/monitoring.md)** for the full monitoring & troubleshooting guide.

## 🔧 Tech stack
`Docker` · `Docker Compose` · `nginx (Alpine)` · `HTML/CSS`

## 👤 Author
**Ali** — CodeAlpha DevOps Internship, 2026
