# Self-hosted apps research — working notes

This file is **tracked in Git**: it explains how to use the scratchpad and how it differs from your private roadmap.

- **Private roadmap (phased delivery):** `homelab-roadmap.md` — gitignored; what you actually plan to run.
- **Private research archive (big dump):** `research-self-hosted-apps.local.md` — gitignored; verbatim export from external research (e.g. Manus AI) while you triage. On your machine it can be regenerated from the Cursor chat transcript that contained the paste (search for `Top 200+ Self-Hosted`), or you can replace the file manually after a fresh clone.

**Treat the research dump as unvetted.** Image names, links, licensing, and “privacy” claims were not verified against this repo’s standards. Prefer official docs before adding a stack.

## How to use this (temporary)

1. Open **`research-self-hosted-apps.local.md`** for the **full 339-row tables** (gitignored; on this machine it was generated from your Cursor chat export).
2. Use the **category triage table** below (or annotate the `.local.md` directly) with **Yes** / **Maybe** / **No** / **Already in repo**.
3. When something graduates to real work, add it to **`homelab-roadmap.md`** and/or a new folder under **`stacks/<category>/`** (see [`stacks/README.md`](../stacks/README.md)).
4. Delete or shrink the `.local.md` archive when you no longer need the raw list.

## Stacks already in this repo (`stacks/<category>/…`)

Cross-check before duplicating effort:

| Area | Path |
|------|------|
| Template | `_template/` |
| DNS / ads | `networking/pihole-unbound/` |
| Reverse proxy | `networking/caddy/` |
| Homelab dashboard | `networking/homepage/` ([Homepage](https://gethomepage.dev/)) |
| Docker management UI | `networking/portainer/` |
| VPN | `networking/wireguard/`, `networking/openconnect/` |
| Passwords | `security/vaultwarden/` |
| Backups (UI) | `backup/duplicati/` |
| Backups (restic target) | `backup/restic-rest-server/` |
| Files / groupware | `productivity/nextcloud/` |
| RSS | `productivity/freshrss/` |
| Git hosting | `development/forgejo/` |
| Meta-search | `search/searxng/` |
| Uptime / metrics / logs | `monitoring/uptime-kuma/`, `monitoring/prometheus-grafana/` |
| Photos | `media/immich/` |
| Media | `media/plex/`, `media/jellyfin/`, `media/audiobookshelf/`, `media/kavita/`, `media/open-ebooks/`, `media/open-audio/` |
| Home automation | `home/home-assistant/` |
| Local AI | `ai/ollama-open-webui/`, `ai/openclaw/`, `ai/paperclip/`, `ai/automatic1111-webui/`, `ai/comfyui/` |
| Offline knowledge | `knowledge/project-nomad/` |
| UPS / NUT master | `power/nut-master/` |
| UPS / NUT slave | `power/nut-slave/` |

Research names that overlap (different branding, same role): Pi-hole, Jellyfin, Plex, Nextcloud, WireGuard, Vaultwarden, Caddy, SearXNG, FreshRSS, Gitea → Forgejo, etc.

## Category triage (fill in)

Use this when you do not want row-by-row noise yet:

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

## Essential Docker Compose Examples (from research export)

*Included here for quick reference; validate against current image docs before use.*

### 1. Pi-hole (Network-wide Ad Blocking)

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

### 2. Plex Media Server

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

*Research export footer (for provenance): Total Applications Listed: 339 — attributed in source to Manus AI.*
