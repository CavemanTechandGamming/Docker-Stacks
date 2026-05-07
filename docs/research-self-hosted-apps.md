# Self-hosted apps research — working notes

This file is **tracked in Git**. It explains how the **research export** relates to this repository: triage, provenance, and a **single index of stacks that already exist** under **`stacks/`**.

For **category definitions** and conventions, see **[`stacks/README.md`](../stacks/README.md)** and **[`standards.md`](standards.md)**. For **contribution workflow**, see **[`CONTRIBUTING.md`](../CONTRIBUTING.md)**.

- **Private roadmap (optional):** **`homelab-roadmap.md`** — typically **gitignored** (see **`.gitignore`**); your own phased plan.
- **Private research archive:** **`research-self-hosted-apps.local.md`** — **gitignored**; large verbatim export (e.g. Manus AI) while you triage. Regenerate or replace after a fresh clone if you use it.

**Treat the research dump as unvetted.** Image names, links, licensing, and privacy claims were not verified against this repo. Prefer **official upstream docs** and this repo’s **`stacks/<category>/<stack>/README.md`** before you deploy.

## How to use this document

1. Open **`research-self-hosted-apps.local.md`** for the **full row-level table** (when present on your machine).
2. Use the **category triage** table below with **Yes** / **Maybe** / **No** / **Already in repo** (or annotate the `.local.md` directly).
3. Before adding a stack, check **[Stacks in this repository](#stacks-in-this-repository)** to avoid duplicates.
4. When something graduates to implementation: add **`stacks/<category>/<stack-name>/`**, list it in that category’s **`README.md`**, update this index if the role is new, and record personal plans in **`homelab-roadmap.md`** if you maintain one.
5. Delete or shrink **`.local.md`** when you no longer need the raw export.

## Stacks in this repository

Compose projects live at **`stacks/<category>/<stack-name>/`**. Most use **`compose.yaml`**; rare upstream exceptions use **`compose.yml`** (see **`standards.md`**). Details are in each stack’s **`README.md`**.

| Category | Paths (under `stacks/`) |
|----------|-------------------------|
| **Scaffolding** | `_template/` |
| **AI** | `ai/automatic1111-webui/`, `ai/comfyui/`, `ai/ollama-open-webui/`, `ai/openclaw/`, `ai/paperclip/` |
| **Backup** | `backup/duplicati/`, `backup/minio/`, `backup/restic-rest-server/` |
| **Development** | `development/forgejo/` |
| **Home** | `home/frigate/`, `home/home-assistant/`, `home/mosquitto/`, `home/zigbee2mqtt/` |
| **Knowledge** | `knowledge/project-nomad/`, `knowledge/wiki-js/` |
| **Media** | `media/audiobookshelf/`, `media/immich/`, `media/jellyfin/`, `media/kavita/`, `media/open-audio/`, `media/open-ebooks/`, `media/plex/` |
| **Monitoring** | `monitoring/prometheus-grafana/`, `monitoring/uptime-kuma/` |
| **Networking** | `networking/caddy/`, `networking/filebrowser/`, `networking/homepage/`, `networking/openconnect/`, `networking/pihole-unbound/`, `networking/portainer/`, `networking/sftpgo/`, `networking/wireguard/` |
| **Power** | `power/nut-master/`, `power/nut-slave/` |
| **Productivity** | `productivity/freshrss/`, `productivity/joplin-server/`, `productivity/nextcloud/`, `productivity/paperless-ngx/`, `productivity/syncthing/` |
| **Search** | `search/searxng/` |
| **Security** | `security/vaultwarden/` |

**Name collisions in research exports** (same role, different branding): Pi-hole, Jellyfin, Plex, Nextcloud, WireGuard, Vaultwarden, Caddy, SearXNG, FreshRSS; **Gitea** ↔ this repo’s **Forgejo**, etc.

## Category triage (fill in)

Use when you do not want row-by-row noise in **`.local.md`** yet:

| Category | Interest (Yes / Maybe / No) | Notes |
|----------|-----------------------------|-------|
| AI & Machine Learning | | |
| Cloud Storage & File Management | | |
| Communication & Collaboration | | |
| Development & IT | | |
| Home Automation & IoT | | |
| Infrastructure & Networking | | |
| Media & Entertainment | | |
| Productivity & Office | | |
| Security & Privacy | | |
| Social Media & Content | | |

## Docker Compose snippets from the research export

*Illustrative only.* Images, ports, and layouts **do not** match every stack in this repo verbatim. **Shipped stacks** in **`stacks/`** are the source of truth (this repo uses **Pi-hole + Unbound** together, not standalone Pi-hole, etc.). Validate any snippet against current upstream docs before use.

### 1. Pi-hole (standalone example)

```yaml
services:
  pihole:
    container_name: pihole
    image: pihole/pihole:latest
    ports:
      - "53:53/tcp"
      - "53:53/udp"
      - "80:80/tcp"
    environment:
      TZ: 'America/Chicago'
      WEBPASSWORD: 'yourpassword'
    volumes:
      - './etc-pihole:/etc/pihole'
      - './etc-dnsmasq.d:/etc/dnsmasq.d'
    restart: unless-stopped
```

### 2. Plex Media Server (LinuxServer-style example)

```yaml
services:
  plex:
    image: lscr.io/linuxserver/plex:latest
    container_name: plex
    network_mode: host
    environment:
      - PUID=1000
      - PGID=1000
      - VERSION=docker
      - PLEX_CLAIM= #optional
    volumes:
      - /path/to/library:/config
      - /path/to/tvseries:/tv
      - /path/to/movies:/movies
    restart: unless-stopped
```

---

*Research export provenance (attribution in source): **339** applications listed — Manus AI.*
