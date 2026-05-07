# Suggested production stack — workstation-grade host or dedicated server

This document is a **standalone blueprint** for a **mature homelab**: hardware where you can run **many** Compose stacks at once—think **desktop replacement**, **tower server**, **thread-heavy workstation**, or a machine whose primary job is “everything self-hosted.” It assumes **fast disk**, **substantial RAM**, and often a **GPU**, plus the **backup and UPS discipline** spelled out below (same trilogy stance as the beginner and intermediate guides—scaled up, not reinvented).

Every **Compose stack named in the tables** exists in this repository (paths under **`stacks/`**). **SMB** for NAS-style offload remains **host OS** configuration unless you add your own Compose wrapper. You do **not** need the [beginner](suggested-stacks-beginner.md) or [intermediate](suggested-stacks-intermediate.md) guides first; this path repeats the full baseline and **extends** it.

**Naming note:** The filename **`suggested-stacks-production.md`** sorts **after** **`suggested-stacks-intermediate.md`** in alphabetical listings. Words like “advanced” or “expert” were avoided in the filename because they sort **before** “beginner,” which breaks a natural folder order. **[suggested-stacks-split-host.md](suggested-stacks-split-host.md)** sorts **after** this file when listing **`docs/suggested-stacks-*.md`**.

---

## 1. What you need (hardware)

| Requirement | Minimum | Recommended |
|-------------|---------|-------------|
| **RAM** | 32 GB | **64 GB+** (heavy observability + Immich + multiple AI services) |
| **CPU** | 64-bit **x86_64**, **8+** threads | **12+** cores / threads; headroom for transcoding, indexing, and metrics |
| **GPU** | Optional but typical | **NVIDIA** or strong **iGPU** for **Immich** ML, **ComfyUI** / **A1111**, and large **Ollama** models—plan thermals and PSU |
| **Storage** | **NVMe** for OS + Docker layers + databases | **Several NVMe or SATA SSDs** for tiered data (hot metadata vs bulk libraries); **HDD** acceptable for cold archives and backup targets |
| **Network** | **1 GbE** NIC *(wired)* | **2.5 / 10 GbE** where switches and cables match—throughput still bounded by disks and CPU |
| **Power** | Surge protection | **UPS** + **NUT** + tested **graceful shutdown** on every host that must survive unclean power |

**Host OS:** **Linux on bare metal** is the best fit for **Pi-hole + Unbound**, **WireGuard**, **OpenConnect**, **GPU** workflows, and **NUT** integration. Windows-only admins often split roles (e.g. media on Linux, AI on a separate GPU box)—still valid if each stack’s README constraints are met.

---

## 2. Suggested software stack and rationale

The goal is a **reliable personal datacenter**: full network and TLS baseline, rich media and knowledge tooling, **full-stack observability**, **two complementary backup paths**, **UPS coordination**, and **multiple AI surfaces** (chat, diffusion, agents)—without pretending Compose alone replaces Kubernetes or off-site DR.

**Backup and UPS framing:** Same trilogy stance as **[beginner](suggested-stacks-beginner.md)** and **[intermediate](suggested-stacks-intermediate.md)**—**Duplicati** for scheduled **encrypted** backups of everything stateful on each host, **restic** clients where appropriate, **restore-tests** on a real calendar, and **second copies** off-site or on another machine. **UPS** ⇒ **NUT**: **[`nut-master`](../stacks/power/nut-master/)** on the host with the **USB** cable (**`upsd`** + **`upsmon`** via **[instantlinux/nut-upsd](https://hub.docker.com/r/instantlinux/nut-upsd)**), **`local/upsmon.conf`** / **`pid: host`**; **[`nut-slave`](../stacks/power/nut-slave/)** on **other** machines sharing that UPS—**rehearse shutdown** after any wiring change.

**Operations mindset:** Document hostnames, bind-mount roots, backup schedules, and restore checks (see **[my-active-stacks.md](my-active-stacks.md)** as a lightweight inventory template).

### Network, access, and operations

| Service | Repository path | Role |
|---------|-----------------|------|
| **Pi-hole + Unbound** | [`stacks/networking/pihole-unbound/`](../stacks/networking/pihole-unbound/) | LAN DNS, filtering, **recursive** resolution via Unbound. |
| **WireGuard** | [`stacks/networking/wireguard/`](../stacks/networking/wireguard/) | Modern UDP VPN for remote access; **Linux host** typical for this pattern. |
| **OpenConnect** | [`stacks/networking/openconnect/`](../stacks/networking/openconnect/) | **SSL VPN** option when you need Cisco-compatible clients or different firewall traversal than WireGuard—deploy **only if** you understand overlapping VPN topology with WireGuard. |
| **Caddy** | [`stacks/networking/caddy/`](../stacks/networking/caddy/) | Reverse proxy and **HTTPS** at the edge of your browser-facing apps. |
| **Portainer** | [`stacks/networking/portainer/`](../stacks/networking/portainer/) | Operational UI over Compose and containers. |
| **Homepage** | [`stacks/networking/homepage/`](../stacks/networking/homepage/) | Single dashboard URL for the whole lab. |

### Security and personal cloud

| Service | Repository path | Role |
|---------|-----------------|------|
| **Vaultwarden** | [`stacks/security/vaultwarden/`](../stacks/security/vaultwarden/) | Bitwarden-compatible vault—critical before you accumulate dozens of local credentials. |
| **Nextcloud** | [`stacks/productivity/nextcloud/`](../stacks/productivity/nextcloud/) | Files, sync, calendar—aim its **data directory** at durable, backed-up storage. |

### Bulk storage and NAS-style offload (host OS)

Same pattern as the **[intermediate](suggested-stacks-intermediate.md)** guide: mount bulk disks (for example **`/mnt/homelab`**), configure **Samba on the Linux host** for **LAN-only** SMB shares, and bind-mount consistent subtrees into Plex/Jellyfin, Immich, Duplicati, Nextcloud, etc.

### Media and libraries

**Video:** Prefer **one** primary library (**Plex** *or* **Jellyfin**) unless you **intentionally** maintain two (e.g. licensing experiments)—each doubles scans and metadata work.

| Service | Repository path | Role |
|---------|-----------------|------|
| **Plex** | [`stacks/media/plex/`](../stacks/media/plex/) | Polished clients and ecosystem. |
| **Jellyfin** | [`stacks/media/jellyfin/`](../stacks/media/jellyfin/) | Fully open video stack—pair with **Plex** only when you mean to. |
| **Open Audio (Navidrome)** | [`stacks/media/open-audio/`](../stacks/media/open-audio/) | Self-hosted music streaming (Subsonic-compatible API). |
| **Immich** | [`stacks/media/immich/`](../stacks/media/immich/) | Photo library with ML features—plan **RAM**, **GPU**, and **backup** of both originals and DB. |
| **Audiobookshelf** | [`stacks/media/audiobookshelf/`](../stacks/media/audiobookshelf/) | Audiobooks and podcasts. |
| **Kavita** | [`stacks/media/kavita/`](../stacks/media/kavita/) | **Ebooks, comics, manga** reader stack—complements streaming media. |
| **Open Ebooks** | [`stacks/media/open-ebooks/`](../stacks/media/open-ebooks/) | OpenBooks IRC discovery workflow—see stack README for scope vs similar names. |

### Development, reading, search, and knowledge

| Service | Repository path | Role |
|---------|-----------------|------|
| **Forgejo** | [`stacks/development/forgejo/`](../stacks/development/forgejo/) | Git forge for personal or team projects—**back up repos and DB**. |
| **FreshRSS** | [`stacks/productivity/freshrss/`](../stacks/productivity/freshrss/) | RSS aggregation. |
| **SearXNG** | [`stacks/search/searxng/`](../stacks/search/searxng/) | Meta-search for fewer tracker-heavy defaults. |
| **Project Nomad** | [`stacks/knowledge/project-nomad/`](../stacks/knowledge/project-nomad/) | Local-first knowledge / research stack (see category README and upstream docs). |

### Home automation

| Service | Repository path | Role |
|---------|-----------------|------|
| **Home Assistant** | [`stacks/home/home-assistant/`](../stacks/home/home-assistant/) | Automation hub—back up **`configuration.yaml`** and the whole `.storage` story per upstream guidance. |

### Monitoring, backups, and power *(baseline for this tier)*

| Service | Repository path | Role |
|---------|-----------------|------|
| **Uptime Kuma** | [`stacks/monitoring/uptime-kuma/`](../stacks/monitoring/uptime-kuma/) | Synthetic checks and status pages for critical URLs. |
| **Prometheus + Grafana + Loki + Promtail** | [`stacks/monitoring/prometheus-grafana/`](../stacks/monitoring/prometheus-grafana/) | **Standard observability** here—metrics, dashboards, and centralized container logs; budget **disk** for retention. |
| **Duplicati** | [`stacks/backup/duplicati/`](../stacks/backup/duplicati/) | Scheduled **encrypted** backups with a web UI. Include **app data, databases**, and bind-mounted paths—not only raw media. **Restore-test** periodically; keep a **second copy** off-site or on another machine when practical. |
| **Restic REST server** | [`stacks/backup/restic-rest-server/`](../stacks/backup/restic-rest-server/) | Encrypted, deduplicated backup **target** for **restic** CLI clients on PCs and other hosts—pairs with Duplicati for different failure modes. |
| **NUT master (`nut-master`)** | [`stacks/power/nut-master/`](../stacks/power/nut-master/) | **UPS USB** here: **[instantlinux/nut-upsd](https://hub.docker.com/r/instantlinux/nut-upsd)** runs **driver**, **`upsd`** (**3493**), **`upsmon`**. **`local/upsmon.conf`** / **`pid: host`** (**[`upsmon.local.example`](../stacks/power/nut-master/upsmon.local.example)**), **[README](../stacks/power/nut-master/README.md)**. |
| **NUT slave (`nut-slave`)** | [`stacks/power/nut-slave/`](../stacks/power/nut-slave/) | Same UPS; **`docker compose build`**, **`local/upsmon.conf`** from **[`upsmon.slave.example`](../stacks/power/nut-slave/upsmon.slave.example)**. |

### Local AI *(deploy what you will actually use; GPU memory is the limit)*

| Service | Repository path | Role |
|---------|-----------------|------|
| **Ollama + Open WebUI** | [`stacks/ai/ollama-open-webui/`](../stacks/ai/ollama-open-webui/) | Chat-first local LLMs. |
| **ComfyUI** | [`stacks/ai/comfyui/`](../stacks/ai/comfyui/) | Node-based diffusion workflows—GPU-heavy. |
| **AUTOMATIC1111 WebUI** | [`stacks/ai/automatic1111-webui/`](../stacks/ai/automatic1111-webui/) | Alternative Stable Diffusion UI—often redundant with ComfyUI unless you prefer both. |
| **OpenClaw** | [`stacks/ai/openclaw/`](../stacks/ai/openclaw/) | Gateway-style AI control plane with channels and providers—read README before mixing with other gateways. |
| **Paperclip** | [`stacks/ai/paperclip/`](../stacks/ai/paperclip/) | Agent orchestration / UI—evaluate overlap with OpenClaw before running both at production load. |

---

## 3. How to set it up

### 3.1 Prerequisites

1. Install **Docker Engine** and **Compose V2**; confirm **`docker version`** and **`docker compose version`** (**[docker-install.md](docker-install.md)**).
2. **Clone** this repo on the server(s); decide whether **one monster host** or **split roles** (see **[suggested-stacks-split-host.md](suggested-stacks-split-host.md)** for **NUT**, UPS, and low- vs high-power placement)—Compose stacks still deploy **per directory**.
3. Plan **storage tiers**: fast NVMe for databases and container layers; wide disks for media; **separate backup destination** not on the same single disk as sole copy.
4. **UPS:** plug USB into the **`nut-master`** host (**[`stacks/power/nut-master/`](../stacks/power/nut-master/)**); **`local/upsmon.conf`** / **`pid: host`** per README; **[`nut-slave`](../stacks/power/nut-slave/)** on **other** boxes sharing that UPS; **rehearse shutdown**.
5. **Backup policy:** At minimum **Duplicati** on hosts that hold app data *and* a **restic** client story toward **[Restic REST server](../stacks/backup/restic-rest-server/)** where it fits—different failure modes; **restore-test** both paths; keep **off-site** or **second machine** copies.

### 3.2 Deploy pattern

Same as other guides: **`cd`** stack folder → **`.env`** from **`.env.example`** → **`docker compose up -d`** → read stack **README** (GPU flags, ports, volumes).

### 3.3 Recommended deployment order *(compressed phases)*

| Phase | Deploy | Notes |
|-------|--------|--------|
| **1** | **Pi-hole + Unbound**, **Portainer**, **Homepage**, **Uptime Kuma** | DNS first; visibility second. |
| **2** | **WireGuard** and/or **OpenConnect** | Avoid duplicate routing surprises—document which VPN owns which subnets. |
| **3** | **Vaultwarden**, **NUT master** *(USB UPS on this host)*, **NUT slave** *(same UPS elsewhere)* | Secrets + clean power before you pile on stateful apps. |
| **4** | **Nextcloud**, **Forgejo**, **FreshRSS**, **SearXNG**, **Kavita**, **Project Nomad** | Web and knowledge; capture ports for **Caddy**. |
| **5** | **Plex or Jellyfin**, **Open Audio**, **Immich**, **Audiobookshelf**, **Open Ebooks** *(if used)* | Large mounts; watch concurrent scans vs backups. |
| **6** | **Home Assistant** | Often needs network privileges—see README. |
| **7** | **Prometheus + Grafana + Loki + Promtail** | Expect sustained disk write load—tune retention. |
| **8** | **Duplicati**, **Restic REST server** | Automate jobs; **restore-test** DB-heavy apps (Nextcloud, Forgejo, Immich, Home Assistant, AI workspaces). |
| **9** | **Ollama + Open WebUI**, **ComfyUI**, **A1111**, **OpenClaw**, **Paperclip** *(subset)* | Start with one diffusion UI unless you need both; stagger model downloads. |
| **10** | **Caddy** | Terminate TLS and proxy to internal services last, once ports are stable. |

### 3.4 Security and resilience

1. Keep **admin UIs** (Portainer, Grafana, Duplicati, Restic, Vaultwarden admin) on **trusted LAN**, **VPN**, or **authenticated** proxies—never “wide open” without a deliberate threat model.
2. **Backups:** Multiple destinations; **encrypt**; **restore-test** Nextcloud, Forgejo, Immich, Home Assistant, and any AI workspaces with user data—the same backup discipline as the beginner and intermediate guides, scaled up.
3. **UPS:** **Rehearse shutdown** after changes; deploy **[`nut-slave`](../stacks/power/nut-slave/)** on co-fed hosts—the **NUT** pattern matches the other suggested-stack guides.
4. **Updates:** pin images where stability matters; read upstream breaking changes before blind **`pull && up`**.

### 3.5 After deployment

- Maintain an inventory (**[my-active-stacks.md](my-active-stacks.md)** or internal wiki): hosts, hostnames, mounts, backup jobs, VPN topology.
- **Split-host layouts** are normal at this tier—see **[suggested-stacks-split-host.md](suggested-stacks-split-host.md)** (filename sorts **after** this guide alphabetically): **NUT** placement (Pi / low-power masters), **one UPS ⇒ one clear NUT ownership**, low- vs high-power roles, DNS and backups across PCs.

---

*This guide is ambitious by design; not every row must run on one PC. For multi-machine placement detail, see **[suggested-stacks-split-host.md](suggested-stacks-split-host.md)**; for the stack catalog, **[`stacks/README.md`](../stacks/README.md)**.*
