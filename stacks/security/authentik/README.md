# Authentik

[Authentik](https://goauthentik.io/) is an open-source **identity provider**: OIDC/SAML apps, SSO flows, optional MFA policies, delegated user directories, outposts—the full “bring your own IdP” experience compared to narrower gates like **[`oauth2-proxy/`](oauth2-proxy/)**.

This Compose mirrors the **official PostgreSQL-backed layout** published at **[`docker-compose.yml` (2025.10)](https://goauthentik.io/version/2025.10/docker-compose.yml)** with this repo’s naming (`compose.yaml`), explicit network, pinned tag default, **disabled error reporting**, and bind mounts expected by upstream (`media/`, `certs/`, `custom-templates/`).

## Requirements

- **~4 GB RAM** practical minimum for Postgres + dual Authentik processes on a modest lab host.
- **Linux or WSL2 with Docker**: the **`worker`** service mounts **`/var/run/docker.sock`** root-owned for integration features upstream expects—avoid treating this lightly on hostile networks.

## Quick start

1. `mkdir -p media certs custom-templates` beside **`compose.yaml`**.
2. `cp .env.example .env` — set **`PG_PASS`** and **`AUTHENTIK_SECRET_KEY`**. For the secret, **`openssl rand -hex 32`** (or similar hex) keeps **`.env`** parsing safe; unquoted base64 often contains **`/`**, which **Docker Compose rejects** in variable values—quote the whole value or use hex.
3. `docker compose up -d` — Postgres must pass **`healthcheck`** before **`server`** / **`worker`** start.
4. Browse **`http://localhost:9000/if/flow/initial-setup/`** ([bootstrap flow](https://docs.goauthentik.io/install-config/install/docker-compose/)).

## Operational notes

- Terminate HTTPS at **[`networking/caddy/`](../../networking/caddy/)** (or comparable) once past bootstrap; **`9443`** is for convenience/testing.
- **Back up** the **`authentik-database`** volume alongside **`media/`** uploads when you onboard users.
- For alternative deployment shapes (Compose without Docker socket features, systemd, Helm), defer to **[Authentik documentation](https://docs.goauthentik.io/install-config/install/docker-compose/)**.

## Official references

- [Authentik](https://goauthentik.io/)
- [Docker Compose installation](https://docs.goauthentik.io/install-config/install/docker-compose/)
- [Configuration](https://docs.goauthentik.io/install-config/configuration/)
