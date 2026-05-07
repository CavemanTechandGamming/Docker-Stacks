# Joplin Server

**[Joplin Server](https://joplinapp.org/)** is the **self-hosted sync target** for **[Joplin](https://joplinapp.org/)** desktop and mobile apps: end-to-end encrypted notes stay under your control while you get multi-device sync. Matches your research triage (**Joplin Server**, row **#245**).

This stack runs **PostgreSQL** alongside the server (recommended for production). Upstream also supports SQLite for quick tests; this Compose path follows the **two-service** layout from **[Joplin’s sample compose](https://github.com/laurent22/joplin/blob/dev/docker-compose.server.yml)** without the optional **Transcribe** profile.

## Before you start

1. `cp .env.example .env`

2. Set **`JOPLIN_POSTGRES_PASSWORD`** and **`JOPLIN_BASE_URL`** to values that **match how you will open the server**:
   - Wrong **`JOPLIN_BASE_URL`** breaks the admin UI, redirects, and client sync in subtle ways.
   - Use your LAN IP or hostname and port, e.g. **`http://nas.lan:22300`**, or the public URL if you terminate TLS at **[Caddy](../../networking/caddy/)**.

3. `docker compose up -d`

4. Admin UI: **`JOPLIN_BASE_URL`** (e.g. **`http://127.0.0.1:22300`** from the host).

5. **Change defaults:** log in as **`admin@localhost`** / **`admin`**, open **Profile**, set a new admin password. Create a **non-admin user** under **Users** for day-to-day sync (recommended).

## Client configuration

In Joplin: **Configuration → Synchronization → Joplin Server** (or **Joplin Server (Beta)** depending on client version). Use:

- **Server URL:** same as **`JOPLIN_BASE_URL`** (no trailing slash unless your reverse proxy uses a path prefix).
- **Email / password:** the **sync user** you created (not necessarily the admin).

See **[Synchronization](https://joplinapp.org/help/apps/sync/)** and the upstream **[server README](https://github.com/laurent22/joplin/blob/dev/packages/server/README.md#installing)** for reverse proxy and path-prefix setups.

## Backup

Persist the **`joplin-server-pgdata`** volume. **[Duplicati](../../backup/duplicati/)** or **[restic](../../backup/restic-rest-server/)** on the host can back up that volume (and any future **`STORAGE_DRIVER`** filesystem path if you enable file storage upstream).

## Security

- Do **not** expose **22300** to the internet without **TLS** and a **trusted** reverse proxy.
- Prefer **VPN** or **LAN-only** until hardening is complete.

## Official references

- [Joplin](https://joplinapp.org/)
- [Synchronization (clients)](https://joplinapp.org/help/apps/sync/)
- [Server README (Docker env)](https://github.com/laurent22/joplin/blob/dev/packages/server/README.md)
- [Docker Hub — joplin/server](https://hub.docker.com/r/joplin/server)
