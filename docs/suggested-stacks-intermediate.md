# Suggested intermediate stack — modern mini PC or repurposed desktop

This document is a **standalone blueprint** for a broader homelab on **stronger hardware**: a **recent mini PC** (Intel N100-class and up, AMD 5000-series mini systems), a **retired office desktop**, or an **older gaming PC** with more headroom for media, sync, and optional local AI. Every **stack named in the tables** has a Compose project in this repository; **LAN SMB file sharing** is configured on the **host OS** (see §2). You do **not** need to complete the [beginner guide](suggested-stacks-beginner.md) first—this path includes the full network and tooling baseline.

---

## 1. What you need (hardware)

| Requirement | Minimum | Recommended |
|-------------|---------|-------------|
| **RAM** | 16 GB (comfortable multi-service + light AI) | 32 GB (Immich, Jellyfin transcode, larger Ollama models) |
| **CPU** | 64-bit **x86_64**, 4 physical cores or 8 threads | 6+ cores; Quick Sync or similar helps **Jellyfin** / **Plex** hardware transcoding |
| **GPU** | Optional | Useful for **Immich** machine learning and some **Ollama** workloads; not required for the rest |
| **Storage** | **NVMe SSD** for OS and container data | **Bulk disk**: internal SATA/NVMe data drive or **USB 3 external HDD/SSD** for media, dumps, and backup targets—almost any desktop or mini PC can host one |
| **Network** | Gigabit Ethernet | Static IP or DHCP reservation; port forwarding only if you intentionally expose services |

**Host OS:** **Linux** on bare metal is assumed for **WireGuard**, **Pi-hole + Unbound**, and typical GPU passthrough. If the machine is Windows-only, use a **Linux VM** with adequate RAM or run a subset of stacks that do not require a Linux host network stack (see each stack’s README).

---

## 2. Suggested software stack and rationale

The goal is a **complete personal platform**: controlled DNS, secure remote access, TLS at the edge, files and passwords, **LAN-accessible bulk storage** (think NAS-style offload from any PC), media and photos, Git, reading and search, monitoring, **backups**, optional home automation, and optional local LLM chat—without relying on a “do the small stack first” prerequisite.

**Backup and UPS framing:** Same stance as the **[beginner](suggested-stacks-beginner.md)** and **[production](suggested-stacks-production.md)** guides—**encrypted** schedules, **restore-tests**, and a **second copy** (**off-site** or another machine) for irreplaceable data. Here **Duplicati** covers paths this host mounts; **[Restic REST server](../stacks/backup/restic-rest-server/)** backs PCs and other hosts running **restic**. **UPS** on USB implies **[`nut-master`](../stacks/power/nut-master/)** (see **Monitoring, backups, and power resilience** below): **[instantlinux/nut-upsd](https://hub.docker.com/r/instantlinux/nut-upsd)** runs **`upsmon`** with **`upsd`**—configure **`local/upsmon.conf`** / **`pid: host`** per **[README](../stacks/power/nut-master/README.md)** so power loss ends in **graceful shutdown** of the **host**. Other hosts on the **same** UPS use **[`nut-slave`](../stacks/power/nut-slave/)**. Multiple machines—see **[split-host](suggested-stacks-split-host.md)** after **[production](suggested-stacks-production.md)** for Pi-style **NUT** masters and **per-UPS** discipline.

### Network, access, and operations

| Service | Repository path | Role |
|---------|-----------------|------|
| **Pi-hole + Unbound** | [`stacks/networking/pihole-unbound/`](../stacks/networking/pihole-unbound/) | LAN DNS, filtering, and **recursive resolution** via Unbound. |
| **WireGuard** | [`stacks/networking/wireguard/`](../stacks/networking/wireguard/) | Remote access to the lab; **Linux host** expected for this Compose pattern. |
| **Caddy** | [`stacks/networking/caddy/`](../stacks/networking/caddy/) | Reverse proxy and **HTTPS** for browser services (Nextcloud, Forgejo, etc.). |
| **Portainer** | [`stacks/networking/portainer/`](../stacks/networking/portainer/) | Container and Compose management UI. |
| **Homepage** | [`stacks/networking/homepage/`](../stacks/networking/homepage/) | Single dashboard linking to all internal services. |

### Security and personal cloud

| Service | Repository path | Role |
|---------|-----------------|------|
| **Vaultwarden** | [`stacks/security/vaultwarden/`](../stacks/security/vaultwarden/) | Self-hosted **Bitwarden-compatible** password vault. |
| **Nextcloud** | [`stacks/productivity/nextcloud/`](../stacks/productivity/nextcloud/) | Files, sync, calendar, and contacts; point its **data directory** at your bulk disk for a sync-oriented “drop zone” from laptops and phones. |

### Bulk storage and NAS-style offload (no extra Compose stack required)

Most homelab hosts can hold an **external USB drive** (or a second internal disk). Treat that volume as your **shared library root**: one place to offload ISOs, camera dumps, media rips, and backup targets. This repository does **not** ship a Samba container; use one of these patterns (often combined):

| Approach | What to do |
|----------|------------|
| **SMB share on the host** | On **Linux**, mount the disk (for example under `/mnt/homelab`), then install and configure **Samba** from your distribution so Windows and macOS can map a drive letter or mount `//your-server/share`. Keep shares **LAN-only** and use strong credentials. |
| **Same path for Docker** | In each stack’s `.env`, **bind-mount** subfolders of that path into **Plex or Jellyfin**, **Open Audio**, **Immich**, **Audiobookshelf**, **Duplicati**, and **Nextcloud** data so containers read the files you copied over SMB. |
| **Nextcloud only** | If you prefer not to run Samba, Nextcloud’s clients still let you **upload and sync** large trees to the bulk disk—higher overhead than raw SMB for huge one-off copies, but simpler permissions. |

### Media and libraries

**Video libraries:** deploy **either** **Plex** **or** **Jellyfin**, not both by default. They fill the same role (library + streaming); running both doubles maintenance and disk indexing unless you have a deliberate reason (e.g. comparing clients or separate libraries).

| Service | Repository path | Role |
|---------|-----------------|------|
| **Plex** | [`stacks/media/plex/`](../stacks/media/plex/) | **Option A** — video library; broad client support; optional Plex account and paid features for some clients. |
| **Jellyfin** | [`stacks/media/jellyfin/`](../stacks/media/jellyfin/) | **Option B** — fully open video library; no vendor account; pick **Plex or Jellyfin** for one home-theater stack. |
| **Open Audio (Navidrome)** | [`stacks/media/open-audio/`](../stacks/media/open-audio/) | **Music streaming** from your own audio files (Subsonic-compatible API); complements video and audiobooks. |
| **Immich** | [`stacks/media/immich/`](../stacks/media/immich/) | Self-hosted photo library (Google Photos–style workflow). |
| **Audiobookshelf** | [`stacks/media/audiobookshelf/`](../stacks/media/audiobookshelf/) | Audiobooks and podcasts with streaming and progress sync. |

### Development, reading, and search

| Service | Repository path | Role |
|---------|-----------------|------|
| **Forgejo** | [`stacks/development/forgejo/`](../stacks/development/forgejo/) | Git hosting (issues, merge requests) for personal or small-team code. |
| **FreshRSS** | [`stacks/productivity/freshrss/`](../stacks/productivity/freshrss/) | Self-hosted RSS reader. |
| **SearXNG** | [`stacks/search/searxng/`](../stacks/search/searxng/) | Meta-search with less tracking than a single commercial engine. |

### Home automation

| Service | Repository path | Role |
|---------|-----------------|------|
| **Home Assistant** | [`stacks/home/home-assistant/`](../stacks/home/home-assistant/) | Local-first automation and device integrations; **bridge networking** on Linux may be required for some hardware (see stack README). |

### Monitoring, backups, and power resilience

| Service | Repository path | Role |
|---------|-----------------|------|
| **Uptime Kuma** | [`stacks/monitoring/uptime-kuma/`](../stacks/monitoring/uptime-kuma/) | Uptime and simple health checks. |
| **Prometheus + Grafana + Loki + Promtail** | [`stacks/monitoring/prometheus-grafana/`](../stacks/monitoring/prometheus-grafana/) | Metrics, dashboards, and **container log** aggregation (heavier than Uptime Kuma alone). |
| **Duplicati** | [`stacks/backup/duplicati/`](../stacks/backup/duplicati/) | Scheduled **encrypted** backups with a web UI. Include **app data, databases**, and bind-mounted libraries—not only raw media. **Restore-test** periodically; keep a **second copy** off-site or on another machine when practical. |
| **Restic REST server** | [`stacks/backup/restic-rest-server/`](../stacks/backup/restic-rest-server/) | Encrypted, deduplicated backup **target** for **restic** CLI clients on PCs and other hosts—pairs with Duplicati for different failure modes. |
| **NUT master (`nut-master`)** | [`stacks/power/nut-master/`](../stacks/power/nut-master/) | **UPS USB** here: **[instantlinux/nut-upsd](https://hub.docker.com/r/instantlinux/nut-upsd)** runs **USB driver**, **`upsd`** (**3493**), **`upsmon`**. **`./local/upsmon.conf`** / **`pid: host`** per **[README](../stacks/power/nut-master/README.md)** (**[`upsmon.local.example`](../stacks/power/nut-master/upsmon.local.example)**). |
| **NUT slave (`nut-slave`)** | [`stacks/power/nut-slave/`](../stacks/power/nut-slave/) | Same UPS strip, **no** USB: **`docker compose build`**, **`local/upsmon.conf`** from **[`upsmon.slave.example`](../stacks/power/nut-slave/upsmon.slave.example)** (**`slave`** role). |

### Local AI (optional by capacity)

| Service | Repository path | Role |
|---------|-----------------|------|
| **Ollama + Open WebUI** | [`stacks/ai/ollama-open-webui/`](../stacks/ai/ollama-open-webui/) | Local LLM runtime and chat UI; **RAM and disk** scale with model size—deploy after core services are stable. |

---

## 3. How to set it up

Follow these steps on the **homelab host**. Adjust host paths, domains, and secrets for your environment; never commit real `.env` files or keys to Git.

### 3.1 Prerequisites

1. Install **Docker Engine** and **Compose V2**. Verify with `docker version` and `docker compose version`. Use **[docker-install.md](docker-install.md)** for your platform.
2. **Clone this repository** on the server (or copy the `stacks/` tree you need).
3. Plan **disk layout**: **NVMe** (or SSD) for OS and Docker; **bulk disk** (internal or **USB**) mounted on the host—for example `/mnt/homelab`—with subfolders you will share over **SMB** and bind-mount into stacks. Each stack README describes typical volume layout.
4. Assign a **fixed LAN IP** (or DHCP reservation) to this machine.
5. **Bulk disk (NAS-style):** Mount your **external or secondary** drive on the host, create predictable subfolders (for example `video/`, `music/`, `photos/`, `backups/`), set ownership so your user and Docker can read them, and—if you want drag-and-drop from Windows or macOS—install **Samba** and define a **read/write share** for the LAN only.

6. **UPS *(optional)*:** **USB here** ⇒ plan **[`nut-master`](../stacks/power/nut-master/)** early (**`upsd`** + **`upsmon`** in-container; **`local/upsmon.conf`**; **`pid: host`**). **Same UPS, no USB** ⇒ **[`nut-slave`](../stacks/power/nut-slave/)** (**`docker compose build`**).

### 3.2 Deploy each stack (standard pattern)

For **every Compose stack** in §2 (the service tables), the workflow is the same unless the stack README says otherwise. **Samba** is not a stack here—follow your distro’s documentation after the bulk disk is mounted.

1. `cd` into the stack directory (paths are relative to the repo root), for example:
   - `stacks/networking/pihole-unbound/`
2. Copy the environment template: `cp .env.example .env` (Linux/macOS) or equivalent on Windows.
3. Edit **`.env`** for ports, time zone, image tags, host paths, and secrets.
4. Start: `docker compose up -d`.
5. Open the stack’s **README.md** for first-run setup (admin passwords, volume permissions, GPU flags, etc.).

### 3.3 Recommended deployment order

Deploy in **phases** so DNS and management exist before heavy consumers, and so you are not debugging fifteen services at once.

| Phase | Deploy (in any order within the phase) | Notes |
|-------|----------------------------------------|--------|
| **1** | **Pi-hole + Unbound** | Set router or client DNS to this host’s IP; confirm resolution before blocking aggressively. |
| **2** | **Portainer**, **WireGuard** (if using) | Portainer for visibility; WireGuard README for **Linux** and UDP port forwarding if remote access. |
| **3** | **Vaultwarden**, **Uptime Kuma**, **Homepage** | Light services; add links in Homepage as you bring stacks up. |
| **4** | **Nextcloud**, **Forgejo**, **FreshRSS**, **SearXNG** | Web apps; note default **HTTP ports** in each README for later Caddy routing. |
| **5** | **Plex or Jellyfin**, **Open Audio (Navidrome)**, **Immich**, **Audiobookshelf** | **Large bind mounts** from your bulk path; one video server only unless intentional; music via Navidrome; plan transcoding (CPU/GPU) per README. |
| **6** | **Home Assistant** | May need **8123** published or host networking on Linux for some integrations. |
| **7** | **Duplicati**, **Restic REST server**, **NUT master (`nut-master`)** *(USB UPS on this host)*, **NUT slave (`nut-slave`)** *(same UPS on other hosts)* | Back up Vaultwarden, Nextcloud, Forgejo, Immich, Home Assistant, and media metadata—not only raw files. **NUT:** master **`upsmon`** in **[instantlinux/nut-upsd](https://hub.docker.com/r/instantlinux/nut-upsd)**; slaves **`docker compose build`** per **[`nut-slave`](../stacks/power/nut-slave/README.md)**. |
| **8** | **Prometheus + Grafana + Loki + Promtail** | Expect several containers; confirm **RAM** headroom; scrape and log volume grow over time. |
| **9** | **Ollama + Open WebUI** | Uncomment **GPU** lines in Compose if applicable; pull models after the stack is up. |
| **10** | **Caddy** | Configure **site blocks** and TLS to proxy hostnames to the internal ports of Nextcloud, Forgejo, Immich, etc. Use real DNS or internal names consistent with Pi-hole **local DNS** records. |

### 3.4 DNS, TLS, and security

1. **Internal names:** Use Pi-hole **Local DNS** (or your LAN DNS) so names like `nextcloud.lan` resolve to the homelab IP **or** to Caddy if you terminate TLS on one IP.
2. **Caddy** obtains certificates when you use public hostnames and valid **ACME** challenges; for **pure LAN** names, use **internal CA** or **DNS challenge** patterns described in Caddy’s documentation and your stack README.
3. Keep **Portainer**, **Grafana**, **Prometheus**, and **Restic** endpoints on **trusted networks** or behind **WireGuard**. Do not expose management ports broadly to the internet without **TLS**, **strong authentication**, and a threat model you accept.
4. **Back up** Vaultwarden, Nextcloud, Forgejo, Immich, and Home Assistant data directories on a schedule (**Duplicati** and/or **restic**). Prefer **multiple destinations** (local + off-site or second machine) for anything irreplaceable; **restore-test** on a cadence you will keep. If you use **Samba**, snapshot or back up the shared tree as well—user data often lands there before containers index it.

5. **UPS:** **USB on this machine** ⇒ **[`nut-master`](../stacks/power/nut-master/)** (**`local/upsmon.conf`** / **`pid: host`**); **same UPS elsewhere** ⇒ **[`nut-slave`](../stacks/power/nut-slave/)**. **Rehearse shutdown** once—the same **NUT** pattern as the beginner and production guides.

### 3.5 After deployment

- Maintain a personal inventory (for example **[my-active-stacks.md](my-active-stacks.md)**) with what you actually run and any host-specific paths.
- **Pin image tags** in `.env` when you want predictable upgrades; read upstream release notes before major jumps.
- For the full catalog beyond this blueprint, see **[`stacks/README.md`](../stacks/README.md)**.

---

*This guide is scoped to intermediate hardware and a **single-machine** Compose layout. Splitting roles across several PCs or servers (always-on vs GPU boxes, **NUT** on a Pi, etc.) is covered in **[suggested-stacks-split-host.md](suggested-stacks-split-host.md)** (after **[production](suggested-stacks-production.md)** alphabetically); Kubernetes-style HA is still out of scope here.*
