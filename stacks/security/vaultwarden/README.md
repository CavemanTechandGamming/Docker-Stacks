# Vaultwarden

[Vaultwarden](https://github.com/dani-garcia/vaultwarden) is a lightweight, unofficial [Bitwarden](https://bitwarden.com/) compatible server. You keep passwords on your own hardware and use the standard Bitwarden clients.

This stack is **separate** from backup tooling: it holds **secrets**; backup jobs need their **own** credentials and schedules.

## Quick start

1. Copy the environment file and set secrets:

   ```bash
   cp .env.example .env
   ```

2. Set **`VAULTWARDEN_DOMAIN`** to the exact URL you use in the browser (including `https://` when TLS is in front).

3. Set **`VAULTWARDEN_ADMIN_TOKEN`** to a long random value (example: `openssl rand -base64 48`).

4. Start:

   ```bash
   docker compose up -d
   ```

5. Open your `VAULTWARDEN_DOMAIN`, create an account, then set **`SIGNUPS_ALLOWED=false`** in `.env` and run `docker compose up -d` again to lock open registration.

6. Admin UI: `https://your-domain/admin` (use `ADMIN_TOKEN` when prompted).

## Data

- All state lives in the Docker volume **`vaultwarden-data`** (mounted at `/data` in the container).
- Back up that volume (or the host path if you switch to a bind mount) as part of your **backup strategy** — losing it means losing the vault.

## Reverse proxy (Caddy)

Put Vaultwarden behind [`stacks/networking/caddy/`](../../networking/caddy/) (or another proxy). Set `VAULTWARDEN_DOMAIN` to the **public** HTTPS URL. Enable WebSockets on the proxy for the vault path (Caddy usually handles this for `reverse_proxy`).

You can attach this service to the shared edge network:

```yaml
networks:
  default:
  edge:
    external: true
    name: homelab_edge
```

Then proxy to `vaultwarden:80` inside that network.

## Security

- Do not expose Vaultwarden directly to the internet without TLS and network controls.
- Treat **`VAULTWARDEN_ADMIN_TOKEN`** like a root password.

## Official references

- [Vaultwarden (GitHub)](https://github.com/dani-garcia/vaultwarden)
- [Vaultwarden wiki](https://github.com/dani-garcia/vaultwarden/wiki)
- [vaultwarden/server (Docker Hub)](https://hub.docker.com/r/vaultwarden/server)
- [Bitwarden clients](https://bitwarden.com/download/)
