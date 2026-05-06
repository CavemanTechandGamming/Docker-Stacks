# SearXNG

[SearXNG](https://github.com/searxng/searxng) is a privacy-respecting **metasearch** engine you run yourself — query many sources without one company owning your search history.

## Quick start

1. Copy the environment file. **`SEARXNG_BASE_URL`** must match how you open the instance (scheme, host, port).

   ```bash
   cp .env.example .env
   ```

2. Start:

   ```bash
   docker compose up -d
   ```

3. Open `SEARXNG_BASE_URL` (e.g. `http://localhost:8088`).

4. Tune engines and privacy options under `/etc/searxng` in the container (persisted in volume **`searxng-config`**). See [SearXNG settings](https://docs.searxng.org/admin/settings/settings.html).

## Advanced

- **Full Compose** (core + Valkey for limiter/bot features): follow [Installation (Docker)](https://docs.searxng.org/admin/installation-docker.html) and align with upstream `container/docker-compose.yml`.
- **Reverse proxy:** put [Caddy](../../networking/caddy/) in front; set `SEARXNG_BASE_URL` to your HTTPS URL.

## Official references

- [SearXNG](https://searxng.org/)
- [Documentation](https://docs.searxng.org/)
- [Installation — Docker](https://docs.searxng.org/admin/installation-docker.html)
- [searxng/searxng (Docker Hub)](https://hub.docker.com/r/searxng/searxng) — [GitHub](https://github.com/searxng/searxng)
