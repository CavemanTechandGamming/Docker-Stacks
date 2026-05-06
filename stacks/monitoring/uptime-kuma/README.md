# Uptime Kuma

[Uptime Kuma](https://github.com/louislam/uptime-kuma) is a self-hosted **uptime** and **monitoring** dashboard (HTTP(s), TCP, ping, Docker host, notifications, status pages).

## Quick start

1. Copy the environment file:

   ```bash
   cp .env.example .env
   ```

2. Start:

   ```bash
   docker compose up -d
   ```

3. Open `http://localhost:3001` (or your `UPTIME_KUMA_HTTP_PORT`), create the admin account, then add monitors.

## Data

All state is in the **`uptime-kuma-data`** volume (`/app/data`).

## Tips

- Monitor **internal** services by hostname on Docker networks (e.g. attach this stack to `homelab_edge` — see [Caddy](../../networking/caddy/) README) or use the host gateway IP.
- Do not expose the UI to the internet without TLS and access control.

## Official references

- [Uptime Kuma (GitHub)](https://github.com/louislam/uptime-kuma)
- [louislam/uptime-kuma (Docker Hub)](https://hub.docker.com/r/louislam/uptime-kuma)
