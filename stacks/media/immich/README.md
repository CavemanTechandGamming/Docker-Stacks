# Immich

[Immich](https://immich.app/) is a self-hosted photo and video backup stack, similar in spirit to Google Photos.

This compose file follows the [official Docker Compose layout](https://docs.immich.app/install/docker-compose): **immich-server**, **immich-machine-learning**, **Valkey** (Redis-compatible), and **Postgres** with the vector extension image Immich publishes.

## Quick start

1. Copy the environment file and set a strong alphanumeric database password:

   ```bash
   cp .env.example .env
   ```

2. Start the stack:

   ```bash
   docker compose up -d
   ```

3. Open `http://localhost:2283` and create the admin account.

## Data layout

- **Photos/videos**: Docker volume `immich-library` → `/data` in the server container.
- **Postgres**: volume `immich-postgres`.
- **ML models**: volume `immich-model-cache`.

To store the library on a host path instead, replace the `immich-library` volume in `compose.yaml` with a bind mount, for example:

```yaml
volumes:
  - /path/to/photos:/data
```

Keep the database on fast local storage (not a network share).

## Version pinning

Set `IMMICH_VERSION` in `.env` to a specific release tag (for example `v2.x.x`) so upgrades are deliberate. See [Immich releases](https://github.com/immich-app/immich/releases).

## Hardware acceleration

For GPU-assisted machine learning or transcoding, see:

- [ML hardware acceleration](https://docs.immich.app/features/ml-hardware-acceleration)
- [Transcoding](https://docs.immich.app/administration/hardware-transcoding)

## If you meant another “Google Photos” app

The usual alternatives are **PhotoPrism** or **LibrePhotos**. If you want one of those instead, say which and we can add a matching stack.

## Official references

- [Immich](https://immich.app/)
- [immich-app/immich (GitHub)](https://github.com/immich-app/immich)
- [Docker Compose install (docs)](https://docs.immich.app/install/docker-compose)
