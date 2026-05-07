# NetBird

NetBird is a WireGuard®-based overlay network platform. Self-hosted deployments run a **combined management / signal / relay / STUN** server plus a **web dashboard**.

Official references:

- [Self-Hosted Quickstart](https://docs.netbird.io/selfhosted/selfhosted-quickstart) (recommended path: **`getting-started.sh`**)
- [Configuration files overview](https://docs.netbird.io/selfhosted/configuration-files)
- Combined server template: [`combined/config.yaml.example`](https://github.com/netbirdio/netbird/blob/main/combined/config.yaml.example)

## What this repo provides

This is a **minimal Compose layout** aligned with NetBird’s “external reverse proxy” port strategy (expose **TCP 80** from `netbird-server` on the host, then terminate TLS in front):

| Path | Purpose |
|------|---------|
| `compose.yaml` | `netbird-server` + `dashboard` with pinned upstream image tags |
| `config/config.yaml` | Reduced template; **must be edited** (hostname, secrets, redirects) |
| `dashboard.env` | Dashboard-facing variables; **must match** your public URLs |

Default host port mapping (override via `.env` from `.env.example`):

- **8091** → management / OAuth / relay / websocket API (HTTPS after your proxy)
- **8092** → dashboard UI (often an `app.` hostname in production)
- **3478/udp** → STUN (**must remain reachable**, not proxied over HTTP)

## Before you rely on this in production

NetBird expects **HTTPS on a stable public hostname**, correct **OAuth redirect URLs**, and careful **reverse-proxy rules** for REST plus **gRPC HTTP/2 (often h2c to the upstream)** traffic. Typical failures are login loops or peers staying offline.

Unless you intend to maintain those proxy routes yourself, run the official **`getting-started.sh`** once, inspect the generated `docker-compose.yml` and configs, then fold that into your lab.

## Editing config

1. Copy **`.env.example`** → **`.env`**.
2. Set **`server.authSecret`** in `config/config.yaml` (use a long random value, for example **`openssl rand -hex 32`**).
3. Keep **hostnames aligned** everywhere:
   - `config.yaml` → `server.exposedAddress`
   - `config.yaml` → `server.auth.issuer`
   - `config.yaml` → `server.auth.dashboardRedirectURIs` (usually your **dashboard** host)
   - `dashboard.env` → **`NETBIRD_MGMT_API_ENDPOINT`**, **`NETBIRD_MGMT_GRPC_API_ENDPOINT`**, **`AUTH_AUTHORITY`**

This template uses **`netbird.example.com`** for the API and **`app.netbird.example.com`** for dashboard redirects exactly as illustrated in upstream documentation.

Consider uncommenting **`server.auth.owner`** in `config/config.yaml` temporarily to bootstrap the first admin password, then remove it afterward.

## Run

```
docker compose up -d
```

The combined server exposes **`/health`** on **`server.healthcheckAddress`** (inside the container, default `:9000` here). Publish that port yourself if your orchestrator needs an external probe.
