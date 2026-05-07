# CrowdSec

[CrowdSec](https://www.crowdsec.net/) is a **crowd-informed intrusion prevention** runtime: parsers + scenarios analyze signals (journald, syslog, container logs via acquisitions, Traefik logs, etc.) and the **Local API** issues remediation decisions consumed by **bouncers** (Caddy/Nginx/firewall integrations).

This stack ships the **`crowdsecurity/crowdsec`** engine with persistent **`/etc/crowdsec`** and **`data`** volumes. **Bouncer containers are not bundled** — install the add-on matching your reverse proxy (**[Caddy bouncer docs](https://docs.crowdsec.net/u/bouncers/caddy)**) once the Local API exposes a credential.

## Quick start

1. Copy **`.env.example`** → **`.env`** and choose **`COLLECTIONS`** (default **`crowdsecurity/linux`** aligns with SSH/syslog parsers on bare-metal/Linux hosts watching **`/var/log`** — extend per **[hub](https://app.crowdsec.net/)** guidance).
2. `docker compose up -d`.
3. On first boot, register with **`cscli console enroll …`** optional; generate **bouncer API keys** (`cscli bouncers add …`) referencing **`http://<host>:<CROWDSEC_LAPI_PORT>/`** (**`8080`** inside the container).
4. Attach **additional log sources** by extending **`/etc/crowdsec`** through `docker compose exec crowdsec bash` editing or bind-mount overlays from follow-up Compose overrides.

## Platform notes

- **Windows Docker Desktop**: bind-mounting host **`/var/log`** is unrealistic—run CrowdSec on **Linux**/WSL for meaningful signal or feed **Docker**/**Traefik** log streams via acquisitions documented upstream.
- Exposed **`8980`** default maps **Local API**; **shield it** (`localhost`/VPN) unless you operate remote bouncers with mutual TLS/IP allow lists.

## Official references

- [CrowdSec](https://www.crowdsec.net/)
- [Docker deployment](https://docs.crowdsec.net/getting_started/install_crowdsec_docker/)
