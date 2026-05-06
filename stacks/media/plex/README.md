# Plex

Plex Media Server in Docker using the [LinuxServer.io](https://docs.linuxserver.io/images/docker-plex/) image.

## Quick start

1. Copy the environment file and edit paths or claim token as needed:

   ```bash
   cp .env.example .env
   ```

2. (Recommended) Set a real media path in `.env`:

   ```env
   PLEX_MEDIA_DIR=/path/to/your/movies-and-tv
   ```

   If you omit `PLEX_MEDIA_DIR`, a Docker named volume `plex-media` is used (handy for testing; less ideal for large libraries).

3. Start:

   ```bash
   docker compose up -d
   ```

4. Open `http://localhost:32400/web` (or your host IP on port `32400`).

## First-time claim

If the server is not linked to your Plex account, generate a claim at [plex.tv/claim](https://www.plex.tv/claim/), put it in `.env` as `PLEX_CLAIM=...`, then recreate the container:

```bash
docker compose up -d --force-recreate
```

## Notes

- Config persists in the `plex-config` volume under `/config` in the container.
- Add extra bind mounts in `compose.yaml` if you prefer separate folders for TV, movies, music, etc.
- For remote access and discovery, you may need host networking or extra published ports; see [Plex support](https://support.plex.tv/) for your network layout.

## Official references

- [Plex](https://www.plex.tv/)
- Container image used here: [LinuxServer.io Plex](https://docs.linuxserver.io/images/docker-plex/) — [linuxserver/docker-plex (GitHub)](https://github.com/linuxserver/docker-plex)
- Alternative official image: [plexinc/pms-docker (GitHub)](https://github.com/plexinc/pms-docker)
