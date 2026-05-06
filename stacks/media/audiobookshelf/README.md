# Audiobookshelf

[Audiobookshelf](https://www.audiobookshelf.org/) is a self-hosted server for audiobooks and podcasts (streaming, progress sync, metadata). This layout follows the [official Docker example](https://github.com/advplyr/audiobookshelf/blob/master/docker-compose.yml): bind mounts for libraries, config, and metadata.

## Quick start

1. Copy the environment file and adjust paths if your media lives outside this folder:

   ```bash
   cp .env.example .env
   ```

2. Create the data directories (if you use the defaults under this stack):

   ```bash
   mkdir -p audiobooks podcasts metadata config
   ```

3. Start:

   ```bash
   docker compose up -d
   ```

4. Open **http://localhost:13378** (or your host IP and `ABS_HTTP_PORT`) and complete the web wizard.

## Paths

| Mount | Purpose |
|-------|---------|
| `/audiobooks` | Audiobook library root(s) — point `ABS_AUDIOBOOKS_DIR` at your files |
| `/podcasts` | Podcast library root(s) |
| `/metadata` | Cache, covers, streams, logs, backups |
| `/config` | Database and server settings — keep on the same machine as the container |

On **Linux**, if you see permission errors on the bind mounts, add `user: "1000:1000"` (or your `uid:gid`) under `audiobookshelf` in `compose.yaml`, matching [upstream](https://github.com/advplyr/audiobookshelf/blob/master/docker-compose.yml).

## Reverse proxy

Put [Caddy](../../networking/caddy/) (or another proxy) in front for HTTPS. Set Audiobookshelf’s **public URL** in the app settings to match what clients use.

## Official references

- [Audiobookshelf](https://www.audiobookshelf.org/)
- [GitHub — advplyr/audiobookshelf](https://github.com/advplyr/audiobookshelf)
- [Container (GHCR)](https://github.com/advplyr/audiobookshelf/pkgs/container/audiobookshelf)
- [Docker / Compose install](https://www.audiobookshelf.org/docs/install/docker-compose-install)
