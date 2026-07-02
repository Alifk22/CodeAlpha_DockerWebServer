# Web Server using Docker - CodeAlpha DevOps Task 4
# A minimal, reproducible nginx image serving a static site.

# Pin to a small, stable base image.
FROM nginx:1.27-alpine

# Metadata
LABEL project="CodeAlpha_DockerWebServer" \
      description="Static web server running on nginx in a container"

# Replace the default nginx site config with ours.
COPY nginx/default.conf /etc/nginx/conf.d/default.conf

# Copy the static site into the directory nginx serves.
COPY site/ /usr/share/nginx/html/

# Document the port the container listens on.
EXPOSE 80

# Container-level health check: fail if the server stops answering.
# wget is bundled in the alpine image.
HEALTHCHECK --interval=30s --timeout=3s --start-period=5s --retries=3 \
  CMD wget --quiet --tries=1 --spider http://127.0.0.1:80/ || exit 1

# nginx runs in the foreground so it stays PID 1 (the default CMD already does this).
