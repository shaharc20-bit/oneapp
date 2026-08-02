# oneapp - Containerized Flask Service

Personal submission for the DevOps container assignment. The service exposes a greeting route plus a JSON /health endpoint used for container health checks, and ships with a CI pipeline that builds and smoke-tests the image on every push.

## What's inside

- app.py - Flask service (greeting + health endpoints)
- requirements.txt - pinned Python dependencies
- Dockerfile - runs as a non-root user, includes a HEALTHCHECK
- .github/workflows/docker-build.yml - CI: builds the image and hits both endpoints
- .dockerignore / .gitignore - keep the image and the repo clean

## Running without Docker

    python3 -m venv .venv
    source .venv/bin/activate
    pip install -r requirements.txt
    python app.py

Visit http://localhost:5050

## Running with Docker

    docker build . -t shaharc20
    docker run --rm -p 5050:5050 shaharc20

Override the port if 5050 is taken on your machine:

    docker run --rm -e PORT=8080 -p 8080:8080 shaharc20

## Health check

http://localhost:5050/health returns a small JSON payload (status, time) so orchestrators can confirm the container is alive, not just that it started.

## Continuous Integration

Every push to main triggers a GitHub Actions job that builds the Docker image, starts a container from it, and curls both / and /health to confirm the service actually responds - not just that it built successfully.
