# Project N.O.M.A.D.

[Project N.O.M.A.D.](https://www.projectnomad.us) (Node for Offline Media, Archives, and Data) is an offline-first knowledge server. The **Command Center** runs in Docker and orchestrates additional tools (Kiwix, Kolibri, maps, CyberChef, optional Ollama/Qdrant, etc.) via the host Docker socket.

This folder mirrors the upstream **management** stack from [`install/management_compose.yaml`](https://github.com/Crosstalk-Solutions/project-nomad/blob/main/install/management_compose.yaml), adapted for a portable layout: secrets and URLs come from `.env`, and data defaults to subfolders under this stack.

## Requirements

- **Docker** with **Compose v2**
- **Linux host** (or WSL2 with Docker) is strongly recommended: the **disk-collector** service mounts the host root filesystem read-only (`/:/host:ro,rslave`), which is not meaningful on typical Docker Desktop for Windows setups.
- The **admin**, **updater**, and **Dozzle** services mount **`/var/run/docker.sock`** so the Command Center can start/stop other containers on the **same Docker host**. Treat this as high privilege; do not expose the UI to untrusted networks ([upstream security notes](https://github.com/Crosstalk-Solutions/project-nomad/blob/main/README.md)).

## Quick start

1. From this directory:

   ```bash
   cp .env.example .env
   ```

2. Edit `.env`:

   - Set `NOMAD_URL` to the URL you will open in a browser (e.g. `http://YOUR_LAN_IP:8080`).
   - Set `NOMAD_APP_KEY` to a random string **at least 16 characters**.
   - Set `NOMAD_DB_PASSWORD` and `MYSQL_ROOT_PASSWORD` to strong values.

3. Start:

   ```bash
   docker compose -f compose.yml up -d
   ```

4. Open the Command Center at the host/port you mapped (default **8080**). Complete the setup wizard in the UI to pull optional apps and content.

**Compose file name:** This stack uses **`compose.yml`** (not `compose.yaml`) so the **updater** sidecar matches the [official install layout](https://github.com/Crosstalk-Solutions/project-nomad/blob/main/install/install_nomad.sh) (`/opt/project-nomad/compose.yml`).

## Ports (defaults)

| Service | Host port | Purpose |
|--------|-----------|--------|
| Command Center | `8080` | Main dashboard |
| Dozzle | `9999` | Optional log viewer |

## Data layout

| Path / variable | Contents |
|-----------------|----------|
| `NOMAD_STORAGE_DIR` (default `./storage`) | Application storage (mounted to `/app/storage` in admin and `/storage` in disk-collector) |
| `NOMAD_MYSQL_DIR` (default `./mysql`) | MySQL data |
| `NOMAD_REDIS_DIR` (default `./redis`) | Redis persistence |

Add these directories to your backups once you care about the data inside.

## Official installer vs this repo

The [quick install script](https://github.com/Crosstalk-Solutions/project-nomad/blob/main/README.md) targets `/opt/project-nomad` on Debian/Ubuntu. This stack is equivalent for the **management** layer but keeps files next to your other Docker Stacks. For full parity with auto-updates, keep `NOMAD_INSTALL_DIR=.` (default) so the **updater** volume maps this folder to `/opt/project-nomad`.

## Official references

- [projectnomad.us](https://www.projectnomad.us)
- [Crosstalk-Solutions/project-nomad (GitHub)](https://github.com/Crosstalk-Solutions/project-nomad) — [README](https://github.com/Crosstalk-Solutions/project-nomad/blob/main/README.md) — [FAQ](https://github.com/Crosstalk-Solutions/project-nomad/blob/main/FAQ.md)
- Management compose upstream: [`install/management_compose.yaml`](https://github.com/Crosstalk-Solutions/project-nomad/blob/main/install/management_compose.yaml)

### Third-party overview

- [Run Wikipedia, Maps, and AI Offline with Project Nomad — TechHut](https://techhut.tv/project-nomad-offline-knowledge-server)

### Bundled tools (official upstreams)

- [Dozzle](https://github.com/amir20/dozzle) (log viewer)
- [MySQL](https://github.com/mysql/mysql-server) — container: [mysql/mysql-server / Docker Hub `mysql`](https://hub.docker.com/_/mysql)
- [Redis](https://github.com/redis/redis) — container: [Docker Hub `redis`](https://hub.docker.com/_/redis)
