# Headscale

[Headscale](https://github.com/juanfont/headscale) is an open-source, self-hosted **control server** for [Tailscale](https://tailscale.com/) clients. It implements the coordination layer so your nodes can register, exchange WireGuard keys, and receive routes and DNS policy—without using Tailscale’s hosted control plane.

## Layout

| Path | Purpose |
|------|---------|
| `compose.yaml` | Headscale service (`serve`), read-only rootfs, `tmpfs` for the CLI socket directory |
| `config/config.yaml` | Server config (derived from upstream `config-example.yaml` for **0.25.x**; listen addresses set for Docker) |
| `lib/` (default) | SQLite database, Noise key, optional DERP keys (created on first run) |

## Quick start

1. Copy **`.env.example`** to **`.env`** and adjust ports if needed.
2. Edit **`config/config.yaml`**, especially:
   - **`server_url`** — must be the URL **clients** use (often `https://headscale.example.com` behind a reverse proxy, or `http://host:8088` for a trusted LAN test).
   - **`dns.base_domain`** — MagicDNS base domain; must **not** match the hostname used in `server_url` (see comments in the file).
3. Create persistent state directory: `mkdir -p lib` (or set `HEADSCALE_LIB_DIR` in `.env`).
4. `docker compose up -d`

Check health: `docker compose exec headscale headscale health`.

## Clients

Use the **Tailscale** client on each machine, pointed at your Headscale instance. Common flows (preauth keys, OIDC, etc.) are documented upstream: [Headscale — Running headscale](https://headscale.net/).

## Notes

- **TLS:** For production, terminate HTTPS on a reverse proxy (for example **[`../caddy/`](../caddy/)**) and set `server_url` to that HTTPS URL.
- **Embedded DERP:** Enabling the built-in DERP server requires **`server_url` to use HTTPS** (see `derp.server` in `config/config.yaml`). Many deployments use Tailscale’s public DERP map (default in this config) instead.
- **Metrics:** Prometheus scrapes `http://<host>:<HEADSCALE_METRICS_PORT>/metrics` by default inside the container; keep that port off untrusted networks.

## Upgrades

Pin `HEADSCALE_IMAGE` to a specific tag, read the [release notes](https://github.com/juanfont/headscale/releases), and merge any new keys from upstream `config-example.yaml` into your `config/config.yaml`.
