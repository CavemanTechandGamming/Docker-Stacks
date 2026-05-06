# Portainer Community Edition

[Portainer CE](https://www.portainer.io/) is a web UI for managing Docker (containers, images, volumes, Compose stacks). This stack mounts the host Docker socket so Portainer can control the **local** engine.

## Quick start

1. Copy the environment file:

   ```bash
   cp .env.example .env
   ```

2. Start:

   ```bash
   docker compose up -d
   ```

3. Open **https://localhost:9443** (or your host IP and `PORTAINER_HTTPS_PORT`). Your browser may warn about the default TLS certificate until you terminate TLS at a reverse proxy.

4. Complete the first-run wizard and set an **admin** password.

## Docker socket path

- **Linux** and **Docker Desktop (WSL2 backend):** `/var/run/docker.sock` (default) is usually correct.
- **Docker Desktop on Windows (Hyper-V / different contexts):** if the container cannot reach the daemon, set `DOCKER_SOCK` in `.env` per [Portainer’s Docker documentation](https://docs.portainer.io/start/install/server/docker) for your platform.

## Security

Portainer is powerful: anyone who can reach the UI can effectively control your host’s containers. Do **not** expose it to the internet without strong authentication, TLS, and network controls. Prefer access over VPN or your internal LAN only.

## Official references

- [Portainer](https://www.portainer.io/)
- [Install Portainer with Docker](https://docs.portainer.io/start/install/server/docker)
- [portainer/portainer-ce (Docker Hub)](https://hub.docker.com/r/portainer/portainer-ce)
