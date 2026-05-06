# Prometheus + Grafana + Loki + Promtail

Observability stack for **metrics** (Prometheus), **dashboards** (Grafana), and **logs** (Loki + Promtail). Image names match your triage list: **Prometheus** (`prom/prometheus`), **Grafana** (`grafana/grafana`), **Loki** (`grafana/loki`).

## What this stack includes

| Service | Role |
|---------|------|
| **Prometheus** | Time-series metrics; default scrape targets include Prometheus itself, Grafana, and Loki. |
| **Grafana** | Web UI; provisioning wires **Prometheus** and **Loki** as datasources. |
| **Loki** | Log aggregation (filesystem storage in a Docker volume). |
| **Promtail** | Discovers Docker containers via the host socket and pushes logs to Loki. |

## Quick start

1. Copy the environment file and set a strong **`GRAFANA_ADMIN_PASSWORD`**:

   ```bash
   cp .env.example .env
   ```

2. Start:

   ```bash
   docker compose up -d
   ```

3. Open **Grafana:** `http://localhost:3000` (or `GRAFANA_PORT`) — login with `GRAFANA_ADMIN_USER` / `GRAFANA_ADMIN_PASSWORD`.

4. **Prometheus UI:** `http://localhost:9090` (or `PROMETHEUS_PORT`).

5. In Grafana → **Explore**, choose **Loki** to query logs (after Promtail has shipped some data).

## Configuration

- **More scrape targets:** edit [`prometheus/prometheus.yml`](prometheus/prometheus.yml) (reload Prometheus: `curl -X POST http://localhost:9090/-/reload` if `--web.enable-lifecycle` is enabled, or restart the container).
- **Loki retention / limits:** edit [`loki/config.yaml`](loki/config.yaml).
- **Which logs Promtail collects:** edit [`promtail/config.yml`](promtail/config.yml).

## Promtail and Docker socket

Promtail mounts **`/var/run/docker.sock`** so it can discover containers. That matches a typical **Linux** engine or **Docker Desktop (WSL2)** setup. If Promtail fails on your platform, set **`DOCKER_SOCK`** in `.env` or stop Promtail and use a different log pipeline (see Grafana Loki docs).

## Security

- Do not expose **Grafana**, **Prometheus**, or **Loki** ports to the internet without TLS, strong passwords, and network controls.
- Put [Caddy](../../networking/caddy/) (or another proxy) in front of Grafana for HTTPS; set **`GRAFANA_ROOT_URL`** to the public URL.

## Official references

- [Prometheus](https://prometheus.io/)
- [Grafana](https://grafana.com/docs/grafana/latest/)
- [Loki](https://grafana.com/docs/loki/latest/)
- [Promtail](https://grafana.com/docs/loki/latest/send-data/promtail/)
