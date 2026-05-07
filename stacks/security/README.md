# Security

Stacks that **authenticate users**, **enforce access**, **issue identity**, or **block abusive traffic** surrounding your Compose estate—distinct from **`networking/`** transport (VPNs/DNS/TLS fronts) unless the component *is* the protection layer itself.

Operate these like **tier-zero infrastructure**: strict firewall scopes, audited backups (**[`backup/`](../backup/)**), and **no plaintext secrets** in Git.

## Stacks

Stacks are listed **alphabetically** by directory name.

The **type** column is a coarse label—you often **layer** stacks (**CrowdSec** → reverse-proxy bouncer, **oauth2-proxy** → **Authentik** issuer, etc.).

| Stack | Type | Description |
|-------|------|-------------|
| [authelia](authelia/) | Forward auth & MFA | **Authelia** pairs with **[`networking/caddy/`](../networking/caddy/)**-style proxies for **forward authentication**, granular **ACLs**, and **TOTP/WebAuthn**; ships **Redis**, **SQLite** storage, templated **`configuration.yml`** + filesystem notifications for bootstrap without SMTP immediately. |
| [authentik](authentik/) | Identity provider | **Official-style** **PostgreSQL** + **`server`** / **`worker`** deployment from **[Authentik 2025.10 compose](https://goauthentik.io/version/2025.10/docker-compose.yml)** with Docker-socket-mounted workers for integrations—full OIDC/SAML lifecycle vs narrowly scoped **[`oauth2-proxy/`](oauth2-proxy/)**. |
| [crowdsec](crowdsec/) | IPS / abuse signals | **CrowdSec security engine** prefetching **`COLLECTIONS`** (default **`crowdsecurity/linux`**) exposing **Local API** on **`8980`** by default—add **proxy/firewall bouncers** downstream per upstream docs (**[Caddy bouncer](https://docs.crowdsec.net/u/bouncers/caddy)**). |
| [oauth2-proxy](oauth2-proxy/) | OAuth / OIDC gate | Lightweight **oauth2-proxy** container turning Google/GitHub/Authentik logins into **session cookies**, proxying **`OAUTH2_PROXY_UPSTREAMS`** origins—minimal moving parts when a full **IdP** is unnecessary. |
| [vaultwarden](vaultwarden/) | Password vault | **Vaultwarden** implements the **Bitwarden-compatible** API for official clients while keeping vault SQLite/volumes local—coordinate backup jobs (**[`backup/duplicati/`](../backup/duplicati/)** et al.). |

If you add a stack here, extend the table alphabetically by folder name and follow **[docs/standards.md](../../docs/standards.md)** and **[CONTRIBUTING.md](../../CONTRIBUTING.md)**.
