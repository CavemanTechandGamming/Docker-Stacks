# Jellyfin

[Jellyfin](https://jellyfin.org/) media server with persistent config, cache, and a single media mount.

## Quick start

1. Copy the environment file:

   ```bash
   cp .env.example .env
   ```

2. (Recommended) Point media at your library:

   ```env
   JELLYFIN_MEDIA_DIR=/path/to/your/media
   ```

   Match `JELLYFIN_UID_GID` to the user that owns those files (default `1000:1000`).

3. Start:

   ```bash
   docker compose up -d
   ```

4. Open `http://localhost:8096` and complete the setup wizard.

## Reverse proxy

If Jellyfin sits behind HTTPS, set `JELLYFIN_PUBLISHED_SERVER_URL` in `.env` to your public URL so clients get correct links.

## Notes

- Add more volume lines in `compose.yaml` if you want separate mount points (e.g. `/movies`, `/tv`) instead of one `/media` tree.
- Hardware transcoding is host- and GPU-specific; see [Jellyfin hardware acceleration](https://jellyfin.org/docs/general/administration/hardware-acceleration.html) and extend this compose as needed.

## Official references

- [Jellyfin](https://jellyfin.org/)
- [jellyfin/jellyfin (GitHub)](https://github.com/jellyfin/jellyfin)
- [Install with Docker](https://jellyfin.org/docs/general/installation/container/) — [jellyfin/jellyfin (Docker Hub)](https://hub.docker.com/r/jellyfin/jellyfin)
