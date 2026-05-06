# Homepage

[Homepage](https://gethomepage.dev/) is a fast, privacy-oriented **application dashboard**: links, widgets, and integrations for your homelab. It does **not** ship its own authentication layer; run it on a trusted network and/or behind [Caddy](../caddy/) (or another reverse proxy) with **TLS and auth** if it is reachable beyond your LAN.

## Quick start

1. Create the config directory and copy env:

   ```bash
   mkdir -p config
   cp .env.example .env
   ```

2. Edit **`.env`**:
   - Set **`HOMEPAGE_ALLOWED_HOSTS`** to every host/port you use in the browser (comma-separated, no spaces), e.g. `192.168.1.50:3000` or `dash.home.lan`. `localhost` and `127.0.0.1` are always allowed for the published port.
   - To run as non-root (Linux), add **`PUID`** and **`PGID`** to the `environment` block in `compose.yaml` per [Docker install](https://gethomepage.dev/installation/docker/#running-as-non-root) and fix ownership of `./config`.

3. Start:

   ```bash
   docker compose up -d
   ```

4. Open **http://localhost:3000** (or your host and `HOMEPAGE_PORT`), then add **`config/settings.yaml`**, **`config/services.yaml`**, **`config/widgets.yaml`**, etc. per [configuration](https://gethomepage.dev/configs/).

## Docker socket (optional)

To use Homepage’s **Docker** discovery/widgets, mount the host socket read-only (primarily **Linux**). Example addition under `homepage` in `compose.yaml`:

```yaml
volumes:
  - /var/run/docker.sock:/var/run/docker.sock:ro
```

On Docker Desktop (Windows/macOS), paths differ; prefer [Kubernetes](https://gethomepage.dev/configs/docker/#kubernetes) or [Proxmox](https://gethomepage.dev/configs/proxmox/) style integrations if socket mounting is awkward. See [Docker integration](https://gethomepage.dev/configs/docker/).

## Secrets in config

Use **`HOMEPAGE_VAR_*`** / **`HOMEPAGE_FILE_*`** environment variables for sensitive values referenced in YAML (see [installation](https://gethomepage.dev/installation/docker/#using-environment-secrets)).

## Official references

- [Homepage](https://gethomepage.dev/)
- [GitHub — gethomepage/homepage](https://github.com/gethomepage/homepage)
- [Docker installation](https://gethomepage.dev/installation/docker/)
- [Container (GHCR)](https://github.com/gethomepage/homepage/pkgs/container/homepage)
