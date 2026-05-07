# Stacks by category

Each immediate subfolder of **`stacks/`** is a **category** (what the workloads are for). Compose projects live one level deeper: **`stacks/<category>/<stack-name>/`**.

Most stacks ship **`compose.yaml`**. A few upstream projects require **`compose.yml`** instead—see **[`docs/standards.md`](../docs/standards.md)**.

Each category has its own **`README.md`** that describes the group and **lists every stack folder** in that category. In file listings, stack folders often appear **above** the category **`README.md`**; that sort order is normal.

| Category | What belongs here |
|----------|-------------------|
| [`ai/`](ai/) | Local LLMs, chat UIs, agent gateways (e.g. OpenClaw, Paperclip), image generation UIs |
| [`backup/`](backup/) | Backup UIs, **restic** REST targets, **S3**-compatible storage (MinIO) for backup and app use |
| [`development/`](development/) | Git forge and related developer infrastructure (e.g. Forgejo) |
| [`home/`](home/) | Home automation, IoT, MQTT/Zigbee bridges, **CCTV/NVR** (e.g. Home Assistant, Frigate) |
| [`knowledge/`](knowledge/) | Wikis, reference libraries, research “command center” stacks (not personal note sync—see **productivity**) |
| [`media/`](media/) | Video, music, photos, audiobooks, ebooks — libraries, streaming, and optional **file/transcode automation** (e.g. FileFlows) |
| [`monitoring/`](monitoring/) | Uptime checks, metrics, logs, dashboards |
| [`networking/`](networking/) | DNS, reverse proxy, VPN/mesh control (e.g. WireGuard, Headscale, NetBird), homelab dashboard (Homepage), Docker UI (Portainer), edge file access (SFTPGo, File Browser) |
| [`power/`](power/) | UPS, power-fail, and NUT master/slave patterns |
| [`productivity/`](productivity/) | Files, sync, feeds, calendars, document archives (Paperless), note sync (e.g. Joplin Server) |
| [`search/`](search/) | Meta‑search, proxied search UIs, and self‑hosted indexers |
| [`security/`](security/) | Password vault (**Vaultwarden**), forward-auth (**Authelia**), OAuth gateways (**oauth2-proxy**), IdP (**Authentik**), IPS signals (**CrowdSec**) |

**Scaffolding:** [`_template/`](_template/) — copy when adding a stack; place it under the best-fitting category, list it in that category’s **`README.md`**, and follow **[`docs/standards.md`](../docs/standards.md)** and **[`CONTRIBUTING.md`](../CONTRIBUTING.md)** (including **`docker compose config --no-interpolate`** before you commit).

**Run a stack:** from its directory (e.g. **`stacks/media/plex/`**): copy **`.env.example`** → **`.env`**, then **`docker compose up -d`**.
