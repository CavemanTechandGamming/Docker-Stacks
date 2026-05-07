# OAuth2 Proxy

[OAuth2 Proxy](https://github.com/oauth2-proxy/oauth2-proxy) is a small **authentication gateway**: users sign in via an OAuth or OIDC provider, receive an encrypted cookie, and proxied requests reach your **`OAUTH2_PROXY_UPSTREAMS`** origin.

Put it **after** **[`networking/caddy/`](../../networking/caddy/)** terminate-TLS hops or directly on **`localhost`** for testing. It solves **browser login** problems; it is **not** a full identity lifecycle platform like **[Authentik](https://goauthentik.io/)**.

## Quick start

1. Create an OAuth **application** (GitHub “OAuth App”, Google client, **[`authentik/`](../authentik/)** provider entry, etc.) whose **Authorized callback URL** matches **`OAUTH2_PROXY_REDIRECT_URL`** verbatim.
2. `cp .env.example .env` — set **`OAUTH2_PROXY_COOKIE_SECRET`** ([generation](https://oauth2-proxy.github.io/oauth2-proxy/configuration/overview)), **`OAUTH2_PROXY_EMAIL_DOMAIN`** (or **`OAUTH2_PROXY_AUTHENTICATED_EMAILS_FILE`**), **client IDs/secrets**, **redirect URL**, and **upstream** target.
3. `docker compose up -d`
4. Open **`http://<host>:4180`** (or your **`OAUTH2_PROXY_PORT`**) — you should be redirected to your IdP then back through the proxy.

## Environment configuration

Nearly every **`--flag`** maps to **`OAUTH2_PROXY_FLAG_NAME`** ([overview](https://oauth2-proxy.github.io/oauth2-proxy/configuration/overview)). **Exception (v7.7.x):** `--email-domain` is wired into **`compose.yaml` as argv** (`--email-domain=${OAUTH2_PROXY_EMAIL_DOMAIN:-*}`); set **`OAUTH2_PROXY_EMAIL_DOMAIN`** in **`.env`** so Compose can pass it through—an env-only form is unreliable for wildcard `*`. For complex setups prefer an **`oauth2-proxy.cfg`** bind mount plus **`command:`** **`--config=...`**.

## Operational notes

- Treat cookies and client secrets like vault material — **`backup/`** volumes if you codify configs, **`security/vaultwarden/`** rotation discipline for humans.
- Behind **HTTPS** reverse proxies ensure **`cookie-secure`** (or equivalent headers) aligns with upstream TLS semantics.

## Official references

- [OAuth2 Proxy](https://github.com/oauth2-proxy/oauth2-proxy)
- [Configuration overview](https://oauth2-proxy.github.io/oauth2-proxy/configuration/overview)
