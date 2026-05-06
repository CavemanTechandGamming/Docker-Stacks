# Paperclip

[Paperclip](https://github.com/paperclipai/paperclip) is an open-source platform for orchestrating AI agents (web UI, scheduling, governance). This stack follows the upstream **Compose quickstart** pattern: one container, **embedded PostgreSQL** and app state under a single Docker volume (`/paperclip`).

## Quick start

1. Copy env and set **at least** `BETTER_AUTH_SECRET` (long random string) and `PAPERCLIP_PUBLIC_URL` (how you open the app in a browser).

   ```bash
   cp .env.example .env
   ```

2. Start:

   ```bash
   docker compose up -d
   ```

3. Open `PAPERCLIP_PUBLIC_URL` (default [http://localhost:3100](http://localhost:3100)).

## Configuration

- **`OPENAI_API_KEY` / `ANTHROPIC_API_KEY`**: optional; upstream pre-installs CLI adapters inside the image — keys enable those integrations.
- **`PAPERCLIP_DEPLOYMENT_MODE` / `PAPERCLIP_DEPLOYMENT_EXPOSURE`**: defaults match upstream quickstart (`authenticated`, `private`). Adjust only if you understand [Paperclip deployment docs](https://paperclip.inc/docs/deploy/docker).

## Data

Everything persists in the **`paperclip-data`** volume (database, uploads, workspace). Back it up with your usual tool (e.g. [Duplicati](../../backup/duplicati/)).

## OpenClaw adapter

If you use Paperclip’s OpenClaw integration, run an OpenClaw gateway (see [openclaw](../openclaw/) in this repo) and follow [Paperclip’s OpenClaw Docker guide](https://paperclip.inc/docs/guides/openclaw-docker-setup).

## Reverse proxy

Terminate TLS at [Caddy](../../networking/caddy/) and set `PAPERCLIP_PUBLIC_URL` to your public HTTPS URL.

## Official references

- [Paperclip (GitHub)](https://github.com/paperclipai/paperclip)
- [Docker deployment](https://paperclip.inc/docs/deploy/docker)
- [Container package (GHCR)](https://github.com/paperclipai/paperclip/pkgs/container/paperclip)
