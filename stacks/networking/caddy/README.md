# Caddy (reverse proxy)

[Apache Caddy](https://caddyserver.com/) as a **standalone** reverse proxy with automatic HTTPS when you use public hostnames and open ports 80/443.

## Why this is not bundled with Pi-hole + Unbound

DNS (Pi-hole + Unbound) and the HTTP reverse proxy are **different roles**:

- **DNS** should stay small, stable, and always on; a broken `Caddyfile` or certificate renewal should not take down resolution for your LAN.
- **Caddy** often shares **80/443** with other edge concerns and is updated on a different cadence than blocklists.
- You may run DNS on one machine (e.g. always-on Pi) and the proxy on another.

Keep using [`stacks/networking/pihole-unbound/`](../pihole-unbound/) as-is; point **LAN DNS records** (or Pi-hole *Local DNS Records*) at the host that runs Caddy when you add named vhosts.

## Quick start

1. Copy the environment file:

   ```bash
   cp .env.example .env
   ```

2. Edit **`Caddyfile`** — replace the default `:80` placeholder with your real site blocks (see comments in the file).

3. Start:

   ```bash
   docker compose up -d
   ```

4. Check:

   ```bash
   docker compose ps
   curl -sS http://127.0.0.1/
   ```

## Shared Docker network (`homelab_edge`)

This stack creates a user-defined bridge **`homelab_edge`** (override with `EDGE_NETWORK_NAME` in `.env`).

To put an app **behind** Caddy by **service name**, attach that app’s compose project to the same network:

```yaml
services:
  jellyfin:
    # ...
    networks:
      - edge

networks:
  edge:
    external: true
    name: homelab_edge
```

Then in `Caddyfile`:

```caddyfile
jellyfin.lan {
	reverse_proxy jellyfin:8096
}
```

Start **Caddy after** the network exists (`docker compose up` in this folder creates it once).

## Pi-hole and local names

Use **Pi-hole → Local DNS Records** (or conditional forwarding) so names like `jellyfin.lan` resolve to the **IP of the host running Caddy** (not always the same host as Pi-hole).

## Official references

- [Caddy](https://caddyserver.com/)
- [caddyserver/caddy (GitHub)](https://github.com/caddyserver/caddy)
- [Caddyfile syntax](https://caddyserver.com/docs/caddyfile)
- [Docker Hub — caddy](https://hub.docker.com/_/caddy)
