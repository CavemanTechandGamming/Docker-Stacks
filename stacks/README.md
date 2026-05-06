# Stacks by category

Each subfolder under `stacks/` is a **category** (what the workloads are for). The actual Compose projects live one level deeper: `stacks/<category>/<stack-name>/`.

Each category folder has a **`README.md`** that explains what belongs there and lists the stacks in that category. (Folders typically sort before files in file listings, so those stack folders appear above the category `README.md` — that’s normal.)

| Category | What belongs here |
|----------|-------------------|
| [`ai/`](ai/) | Local LLMs, chat UIs, agent gateways (e.g. OpenClaw, Paperclip), and related AI tooling |
| [`media/`](media/) | Video, music, photos, audiobooks, ebooks — libraries and streaming |
| [`home/`](home/) | Home automation and IoT (e.g. Home Assistant) |
| [`backup/`](backup/) | Backup UIs and backup-related tooling |
| [`networking/`](networking/) | DNS, reverse proxy, VPN (WireGuard, OpenConnect), homelab dashboard (Homepage), Docker UI (Portainer) — how traffic enters the lab |
| [`security/`](security/) | Identity-adjacent services (e.g. passwords, auth helpers) |
| [`productivity/`](productivity/) | Files, feeds, calendars — day-to-day collaboration |
| [`development/`](development/) | Git forge, CI-adjacent tools, developer infrastructure |
| [`monitoring/`](monitoring/) | Uptime, health checks, observability |
| [`search/`](search/) | Search and meta-search (privacy-oriented) |
| [`knowledge/`](knowledge/) | Offline or local-first knowledge / research stacks |
| [`power/`](power/) | UPS, power-fail, and related hardware bridges |

**Scaffolding:** [`_template/`](_template/) — copy when adding a stack; place the new folder under the category that fits best, then add a link in that category’s `README.md`.

**Run a stack:** from its directory, e.g. `stacks/media/plex/`, run `docker compose up -d` (after copying `.env.example` → `.env`).
