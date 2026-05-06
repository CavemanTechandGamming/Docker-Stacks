# OpenClaw

[OpenClaw](https://github.com/openclaw/openclaw) is an open-source personal AI assistant framework: gateway, Control UI, channels (Telegram, Discord, WhatsApp, etc.), and pluggable model providers. This stack runs the **gateway** container from the published **GHCR** image (no local clone required).

## Requirements

- Docker Compose v2
- Roughly **2 GB+ RAM** for the image; more if you add heavy providers or sandboxing
- For **Ollama / LM Studio on the host**, use `http://host.docker.internal:11434` (or your LM Studio port) in provider settings — this compose file maps `host.docker.internal` via Docker’s host gateway

## Quick start

1. Copy env and edit:

   ```bash
   cp .env.example .env
   ```

2. **First-time onboarding** (writes config into the named volumes). From this directory:

   ```bash
   docker compose run --rm --no-deps --entrypoint node openclaw-gateway dist/index.js onboard --mode local --no-install-daemon
   ```

   Follow the prompts (API keys, gateway token, etc.). Alternatively, use the upstream `scripts/docker/setup.sh` from a full [OpenClaw](https://github.com/openclaw/openclaw) clone if you prefer their scripted flow.

3. Start the gateway:

   ```bash
   docker compose up -d
   ```

4. Open the **Control UI**: [http://127.0.0.1:18789/](http://127.0.0.1:18789/) (or your host IP and `OPENCLAW_GATEWAY_PORT`). Use the gateway token from onboarding / `.env` as documented upstream.

## CLI (channels, dashboard, config)

Upstream uses a second `openclaw-cli` service in their repo compose. You can run one-off CLI commands with the **same image** and volumes, for example:

```bash
docker compose run --rm --no-deps --entrypoint node openclaw-gateway dist/index.js --help
```

See [Docker install](https://docs.openclaw.ai/install/docker) for `channels`, `dashboard`, and device pairing examples.

## Data

- **`openclaw-config`**: `openclaw.json`, auth profiles, gateway secrets  
- **`openclaw-workspace`**: agent workspace files  

Back up these volumes with your usual method (e.g. [Duplicati](../../backup/duplicati/)).

## Reverse proxy

Put [Caddy](../../networking/caddy/) or another proxy in front for HTTPS; follow [OpenClaw gateway security](https://docs.openclaw.ai/gateway/security) before exposing to the internet.

## Official references

- [OpenClaw (GitHub)](https://github.com/openclaw/openclaw)
- [Docker install](https://docs.openclaw.ai/install/docker)
- [Container package (GHCR)](https://github.com/openclaw/openclaw/pkgs/container/openclaw)
