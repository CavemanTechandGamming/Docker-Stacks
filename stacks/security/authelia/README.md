# Authelia

[Authelia](https://www.authelia.com/) provides **forward authentication**, **TOTP/WebAuthn MFA**, and **access-control rules** in front of apps that do not implement their own SSO. It complements **[`networking/caddy/`](../../networking/caddy/)** (TLS and routing) without duplicating that role.

This layout is a **trimmed** variant of upstream [**`examples/compose/lite`**](https://github.com/authelia/authelia/tree/master/examples/compose/lite): **Authelia + Redis**, **SQLite** metadata store, **file-based users**, and a **filesystem** notifier (`config/notification.txt`) so you are not forced to configure SMTP on day one.

## Before `docker compose up`

1. Copy **`.env.example`** → **`.env`** (Compose substitutes **`AUTHELIA_HTTP_PORT`** / **`TZ`** from it; neither service receives the raw file, so Compose-only keys are not leaked into containers).
2. Edit **`config/configuration.yml`**:
   - Replace every **`replace_with_...`** secret with values from **`openssl rand -hex 32`** (or stronger per [Authelia secrets](https://www.authelia.com/integration/configuration/methods/secrets/)).
   - Replace **`example.com`** / **`authelia.example.com`** / **`public.example.com`** domains with hosts you actually protect.
   - Align **`access_control.rules`** with your apps and MFA policy (**`bypass`**, **`one_factor`**, **`two_factor`**).
3. Review **`config/users_database.yml`** — default login **`authelia` / `authelia`**; **change immediately** ([password hashing guide](https://www.authelia.com/integration/reference/guides/passwords/)).
4. **`docker compose up -d`** — watch logs for SQLite init and Redis connectivity.

## Caddy reverse proxy

Point **forward-auth** at `http://<authelia-host>:9091/api/authz/forward-auth` and pass `Remote-User` / `Remote-Email` headers per [Authelia integration docs](https://www.authelia.com/integration/prologue/get-started/). This repo’s Caddy stack is separate on purpose (**[`networking/caddy/`](../../networking/caddy/)**).

## Operational notes

- **Back up** `./config/` (SQLite DB, YAML, notifications) alongside other security state (**[`backup/`](../../backup/)**).
- Production deployments often migrate **storage** from SQLite to PostgreSQL — see upstream configuration reference.
- For full Traefik-labelled demos including **whoami** test hosts, clone Authelia’s **`examples/compose/lite`** directly.

## Official references

- [Authelia](https://www.authelia.com/)
- [Docker deployment](https://www.authelia.com/integration/deployment/docker/)
- [Lite bundle (GitHub)](https://github.com/authelia/authelia/tree/master/examples/compose/lite)
