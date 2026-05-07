# Suggested split-host layout — multiple machines in one homelab

This document is a **companion** to **[suggested-stacks-production.md](suggested-stacks-production.md)**. Read **[beginner](suggested-stacks-beginner.md)** or **[intermediate](suggested-stacks-intermediate.md)** first if you need a single-machine baseline; this guide assumes you already understand Compose-per-folder deployment and the **backup / UPS framing** shared across the trilogy.

**Filename ordering:** In alphabetical listings, **`suggested-stacks-split-host.md`** sorts **after** **`suggested-stacks-production.md`** (`split-host` follows `production`), consistent with the rest of the **`docs/suggested-stacks-*.md`** series.

**Networking stance for this guide:** Split-host layouts here assume **wired Ethernet** end-to-end (host ↔ switch ↔ router). **Wi‑Fi is intentionally omitted** as the primary LAN backbone—it adds jitter and dropouts that fight DNS, game panels, and bulk copies. Treat **1 Gigabit Ethernet** as the **minimum** NIC speed on every homelab host below; **10 Gigabit Ethernet** is **preferred** on links that routinely move large libraries or backup streams (often workstation ↔ media vault).

---

## 1. Why split hosts

One chassis does not have to run Pi-hole, GPU diffusion, game launchers, and observability at once. Splitting **roles** reduces contention—fewer midnight reboots taking DNS with them, separate **power** stories for “must stay up” vs “can sleep,” and room for **Windows** on a daily driver while Linux owns network edge services.

Every stack in this repository still deploys as **`cd` one folder → `docker compose up`** on **one Docker host** at a time; split-host only decides **which physical PC** owns which folders.

### Host OS baseline *(optional)*

Nothing in this split-host guide requires a specific vendor image: deploy **any Linux** that meets **each stack’s README**. When you want **one repeatable convention** across hardware generations, use the pairings below—each row follows the same pattern (**role → distribution → scope note**).

| Role | Distribution | Scope |
|------|--------------|--------|
| **General-purpose server** *(VM, bare-metal tower, or mini PC; **not** Raspberry Pi)* | **[Ubuntu Server](https://ubuntu.com/download/server)** or **[Debian](https://www.debian.org/distrib/)** netinst | Headless by default. Install a desktop stack only when that host has a fixed monitor and you operate it interactively at the console. |
| **Raspberry Pi, headless** | **[Raspberry Pi OS Lite](https://www.raspberrypi.com/software/)** (64-bit) | Flash with **[Raspberry Pi Imager](https://www.raspberrypi.com/software/)** — OS menu → **Raspberry Pi OS (other)** → **Raspberry Pi OS Lite**. |
| **Raspberry Pi, with local display** | **[Raspberry Pi OS](https://www.raspberrypi.com/software/)** (64-bit desktop image) | Flash with **[Raspberry Pi Imager](https://www.raspberrypi.com/software/)** — OS menu → **Raspberry Pi OS (64-bit)**. |
| **Workstation with local display** *(not Raspberry Pi)* | **[Debian](https://www.debian.org/distrib/)** + **[desktop environment](https://wiki.debian.org/DesktopEnvironment)** | Use the Debian installer’s desktop task, an official live image with a bundled desktop, or a derivative that tracks Debian stable—keep the stack README’s kernel and driver expectations in mind. |

**Precedence:** Per-stack README requirements override this table (GPU drivers, kernel modules, Docker networking mode, and similar).

**Scope note:** **QuietLatch** (**§2.1** **#2**, §6.3) is modeled **headless**: **[Raspberry Pi OS Lite](https://www.raspberrypi.com/software/)** on Raspberry Pi hardware, **[Ubuntu Server](https://ubuntu.com/download/server)** on **N100-class** mini PCs—same split as the §6.3 **OS** row.

---

## 2. NUT, UPS, and where **`nut-master`** should live

### 2.1 Split the “utility Pi” into three jobs *(recommended)*

Treat **NUT**, **DNS/dashboard/automation**, and **backup + bulk storage** as **three different machines** when you can—it keeps failure domains clean and sizing honest.

**1 — NUT-only Raspberry Pi (minimal)**  
Run **[`nut-master`](../stacks/power/nut-master/)** **only** on a tiny always-on **Raspberry Pi** with **Gigabit Ethernet (1 GbE)** (typical **Pi 4** or **Pi 5**—not a wireless-only board as the primary UPS anchor). **That is all this Pi needs:** this **Compose** stack (**USB driver**, **`upsd`**, **`upsmon`** via **[instantlinux/nut-upsd](https://hub.docker.com/r/instantlinux/nut-upsd)**—see **[README](../stacks/power/nut-master/README.md)**); add **`./local/upsmon.conf`** and usually **`pid: host`** so **`upsmon`** can halt the **machine**. **1 GB RAM is enough** for NUT-only duty *(Pi 4 1 GB tier)*; larger SKUs are harmless overkill. A **32 GB microSD** card is **enough** capacity for Raspberry Pi OS Lite, Docker, and the NUT containers—do **not** pile Pi-hole, Restic, or media indexing onto this box. **OS:** **[Raspberry Pi OS Lite](https://www.raspberrypi.com/software/)** (64-bit, headless).

**2 — Second low-power host (Pi-hole and friends)**  
Run **Pi-hole + Unbound**, **WireGuard**, **Uptime Kuma**, **Homepage**, and **[Home Assistant](../stacks/home/home-assistant/)** on a **separate** always-on low-power machine—a **second Raspberry Pi** *(more RAM / larger boot medium than the NUT Pi if you like)* or a quiet **N100-class mini PC**. **Headless**; OS matches **§6.3** **QuietLatch**. Administer over **SSH** (or your chosen remote console); router DHCP should point LAN DNS at **this** host, not at the NUT Pi.

**3 — NAS-class box (backups + libraries)**  
Run **[Restic REST server](../stacks/backup/restic-rest-server/)**, **[Duplicati](../stacks/backup/duplicati/)**, and your **large disks** on what amounts to a **NAS** or **always-on file server**—the place bulk data already lives. **restic** clients and Duplicati targets should aim **here**, not at the NUT Pi.

The **NUT** Pi should:

- Stay powered whenever you care about **graceful shutdown** signaling on the LAN.
- Own a **reliable USB path** to the UPS (avoid flaky hubs).

Treat **`nut-master`** as **`upsd`** + **`upsmon`** in one Compose service—then **`local/upsmon.conf`** / **`pid: host`** so shutdown lands on the host—same pattern as the **[beginner](suggested-stacks-beginner.md)** / **[intermediate](suggested-stacks-intermediate.md)** / **[production](suggested-stacks-production.md)** guides. Co-fed hosts deploy **[`nut-slave`](../stacks/power/nut-slave/)**.

### 2.2 One UPS ⇒ own its own NUT relationship

For **safety and clarity**, treat **each independent UPS** as deserving **its own** NUT deployment tied to **that unit’s USB data cable**:

| Situation | Recommended pattern |
|-----------|---------------------|
| **Several PCs plug into one UPS** (same battery backup) | **One** machine—the **NUT master**—has the UPS **USB** cable and runs **[`nut-master`](../stacks/power/nut-master/)**; **other PCs** run **[`nut-slave`](../stacks/power/nut-slave/)** (or **`nut-client`** on the host OS) so **`upsmon`** subscribes over the LAN and **all** relevant hosts shut down when **that** battery exhausts. |
| **Two or more separate UPS devices** (different outlets, different rooms, different batteries) | **Safest:** **separate** **`nut-master`** stacks (or clearly isolated configs) so **runtime**, voltage, and **shutdown thresholds** always refer to the **correct** hardware—not one daemon fuzzy-logicing multiple unrelated batteries. Practically, that often means **each UPS USB lands on its own always-on host**, or you accept operational risk merging devices under one expert-tuned `ups.conf`. |

Trying to multiplex **multiple unrelated UPS models** through **one** ambiguous monitoring path is how labs miss outages or shut down the wrong machine. When in doubt, **duplicate the Pi-class utility host** before you duplicate ambiguity.

### 2.3 Slaves are not a shortcut around USB ownership

**LAN slaves** answer the question: “Other hosts lost mains **because this UPS did**—shut them down too.” They do **not** replace **knowing which UPS protects which load**.

---

## 3. Low-power versus high-power hosts

Use **idle watts** and **uptime expectations**, not vanity benchmarks.

| Tier | Typical hardware | Good workloads | UPS / NUT note |
|------|------------------|----------------|----------------|
| **NUT-only Pi** | **Pi 4 / Pi 5** with **1 GbE**, **32 GB microSD**, **1 GB RAM enough** for NUT-only *(Pi 4 1 GB)* | **[`nut-master`](../stacks/power/nut-master/)** **only** *(includes **`upsmon`**—tune host shutdown in README)* | **UPS A** USB lives **here**; **Raspberry Pi OS Lite** |
| **Edge / automation** *(second Pi or N100-class mini PC)* | Second **Pi 4 / Pi 5** or **N100-class** mini PC — **headless**; OS per **§6.3** **QuietLatch** | **Pi-hole + Unbound**, **WireGuard**, **Uptime Kuma**, **Homepage**, **Home Assistant** | Usually **not** the UPS USB owner—DNS goes here |
| **NAS-class / backup vault** | Tower with many disks, dedicated NAS, beefy mini PC with USB HDD farms | **[Restic REST server](../stacks/backup/restic-rest-server/)**, **Duplicati**, **Plex** / **Jellyfin**, libraries | **[`nut-slave`](../stacks/power/nut-slave/)** when this box shares the same UPS strip as **InkRelay** |
| **Mid-power general** | Older desktop, small tower | **Prometheus** retention, **Nextcloud** when 24/7 | Same UPS story if always-on |
| **High-power / intermittent** | Gaming rig, GPU workstation, creator desktop | **ComfyUI**, **Ollama + Open WebUI**, heavy **Plex/Jellyfin** transcoding experiments | Often **sleeps**—**avoid** being the sole **`upsmon`** master unless it truly runs 24/7; acceptable as **slave** or as owner of a **desk UPS** that only protects **that** desk |

**Rule of thumb:** **NUT USB** on the **smallest dedicated Pi**; **QuietLatch** workloads (**§6.3**) on the **second** low-power host; **backup targets** on the **NAS** tier—not all three on one SD card.

**Windows / Docker Desktop:** Fine for **media/AI** when README allows; **Pi-hole**, **Home Assistant**, **`nut-master`** with reliable USB, and **clean shutdown** are usually **Linux bare metal**—**InkRelay**: **Raspberry Pi OS Lite**; **QuietLatch**: OS per **§6.3**.

---

## 4. DNS, backups, and cross-machine habits

- **DNS:** Run **Pi-hole + Unbound** on the **edge/automation** host (§2.1 **#2**)—**not** on the **NUT-only** Pi. Use Pi-hole **Local DNS** for internal names.
- **Backups:** Run **[Restic REST server](../stacks/backup/restic-rest-server/)** and **[Duplicati](../stacks/backup/duplicati/)** on your **NAS-class** machine (§2.1 **#3**) so disks and backup jobs live with bulk storage. **restic** clients and Duplicati destinations should target **that** box; only use per-PC Duplicati when a host cannot be reached from the NAS.
- **TLS / Caddy:** Often lands on the machine that holds **public or LAN-trusted** ingress; split stacks behind **one** reverse proxy only after you understand Docker networking across hosts (this repo does not ship multi-host proxy Compose).

---

## 5. Deploy discipline

The **phase table** in **[suggested-stacks-production.md](suggested-stacks-production.md)** (§3.3) is written per **single** host—when you split roles, **repeat the relevant phases on each machine** that owns those stacks. Maintain your own inventory—spreadsheet, wiki, or internal runbook—with hostname, LAN IP, **wired** NIC speed (**1 GbE** minimum, **10 GbE** preferred on heavy movers), which UPS USB attaches where, and which host is **NUT master** for which battery.

---

## 6. Example composite layout *(illustrative only)*

The layout below is a **teaching example**: **per-host** hardware tables and stack lists, **fictional descriptive hostnames**, and **best-practice splits**: **NUT-only Pi**, **second low-power host** (**QuietLatch**) for Pi-hole / dashboards / **Home Assistant** / **VPN** (OS per §6.3), **NAS-class** box for **backups + libraries**, plus game panel and workstation—**wired Ethernet only**, **1 GbE minimum**, **10 GbE preferred** on heavy paths. **Illustrative only—not a design you are expected to copy verbatim.**

### 6.1 Design goals for this example

| Goal | How the example implements it |
|------|-------------------------------|
| **No Wi‑Fi as backbone** | Every host below uses **Ethernet** to the switch—consistent with the networking stance at the top of this guide. |
| **1 GbE floor, 10 GbE ceiling** | Every host has at least **Gigabit Ethernet**; **VaultBloom** ↔ **LedgerShelf** uses **10 GbE** where switches and NICs allow bulk library or backup traffic. |
| **NUT on the smallest Pi only** | **InkRelay** is **Raspberry Pi OS Lite** + **1 GB RAM** *(enough)* + **32 GB microSD** + **only** **`nut-master`**—nothing else. |
| **DNS / dashboards / HA elsewhere** | **QuietLatch** runs **Pi-hole + Unbound**, **WireGuard**, **Homepage**, **Uptime Kuma**, and **Home Assistant**—DHCP DNS targets **QuietLatch**, not **InkRelay**. |
| **Backup server on NAS** | **LedgerShelf** runs **[Restic REST server](../stacks/backup/restic-rest-server/)**, **Duplicati**, **Nextcloud**, **Project Nomad**, and media stacks beside bulk disks. |
| **Separate desk UPS** | **UPS B** protects **VaultBloom** only; USB **B** ideally lands on a **second** tiny always-on board (**[`nut-master`](../stacks/power/nut-master/)**) **or** a rehearsed Windows **NUT** profile. |
| **Media vs AI split** | **LedgerShelf** holds backups, **Nextcloud**, **Project Nomad**, and libraries; **VaultBloom** holds **GPU AI** stacks. |

### 6.2 **InkRelay** *(UPS inkwell — NUT only)*

Fictional **single-job Raspberry Pi**: **only** owns **UPS A’s USB** and speaks NUT—**32 GB SD is enough**; do **not** install Pi-hole or Restic here.

| | |
|--|--|
| **Hostname** | **InkRelay** |
| **Hardware** | **Raspberry Pi 4 or Pi 5** with **Gigabit Ethernet (1 GbE)** |
| **Role** | **`nut-master`** **only** |
| **RAM** | **1 GB sufficient** for NUT-only *(Pi 4 1 GB tier)*; larger SKUs OK |
| **Network** | **1 Gigabit Ethernet** to the switch |
| **System disk** | **32 GB microSD** *(sufficient for this role)* |
| **OS** | **[Raspberry Pi OS Lite](https://www.raspberrypi.com/software/)** (64-bit) |

#### Stacks on InkRelay

| Stack | Path in this repo |
|-------|-------------------|
| **NUT master (`nut-master`)** — **UPS A** USB | [`stacks/power/nut-master/`](../stacks/power/nut-master/) — **`upsd`** + **`upsmon`**; **`local/upsmon.conf`** / **`pid: host`** per README |

### 6.3 **QuietLatch** *(quiet latch — DNS, VPN & home dashboards)*

Fictional **second always-on low-power** box: **DNS**, **VPN**, **Home Assistant**, **Homepage**, and monitoring—**not** the NUT Pi. **Administration is headless** (SSH); no local GUI is assumed.

| | |
|--|--|
| **Hostname** | **QuietLatch** |
| **Hardware** | Second **Pi 4 / Pi 5** *(or N100-class mini PC)* — more CPU/RAM than **InkRelay** if **Home Assistant** grows |
| **Role** | **Pi-hole**, **VPN**, monitoring landing page, automation hub |
| **RAM** | **4 GB** minimum — **8 GB** comfortable for HA + Docker |
| **Network** | **1 Gigabit Ethernet** |
| **System disk** | **64 GB+ microSD** or small SSD *(HA + Pi-hole data grow over time)* |
| **OS** | **[Raspberry Pi OS Lite](https://www.raspberrypi.com/software/)** *(Pi)* · **[Ubuntu Server](https://ubuntu.com/download/server)** *(N100-class mini PC)* — **headless** |

#### Stacks on QuietLatch

| Stack | Path in this repo |
|-------|-------------------|
| **Pi-hole + Unbound** | [`stacks/networking/pihole-unbound/`](../stacks/networking/pihole-unbound/) |
| **WireGuard** | [`stacks/networking/wireguard/`](../stacks/networking/wireguard/) |
| **Uptime Kuma** | [`stacks/monitoring/uptime-kuma/`](../stacks/monitoring/uptime-kuma/) |
| **Homepage** | [`stacks/networking/homepage/`](../stacks/networking/homepage/) — bookmarks to Plex, AMP, ComfyUI, Pi-hole, etc. |
| **Home Assistant** | [`stacks/home/home-assistant/`](../stacks/home/home-assistant/) |
| **NUT slave (`nut-slave`)** *(if on UPS A)* | [`stacks/power/nut-slave/`](../stacks/power/nut-slave/) |

**UPS / NUT:** **`MONITOR`** targets **InkRelay**; see **`nut-slave`** README when **QuietLatch** shares **UPS A** power.

### 6.4 **LedgerShelf** *(ledger + shelves — NAS & backup vault)*

Fictional **NAS-class** machine: **bulk USB/internal disks**, **backup server** (**Restic**, **Duplicati**), **Nextcloud**, **Project Nomad**, and **libraries**—a familiar **NAS + media vault** pattern with backups **anchored** here per §2.1.

| | |
|--|--|
| **Hostname** | **LedgerShelf** |
| **Role** | **Backup target**, **Nextcloud**, **Project Nomad**, **Plex** / audiobooks / music |
| **CPU** | AMD Ryzen **7-class mobile** *(example SKU)* |
| **RAM** | **16 GB** DDR4 |
| **Network** | **10 Gigabit Ethernet** *(preferred)* to **VaultBloom**; **1 GbE** acceptable |
| **System disk** | **250 GB** NVMe *(OS + Docker layers)* |
| **Bulk storage** | **Two** × **5 TB** USB enclosures → **Plex** libraries |
| **Bulk storage** | **One** × **5 TB** USB HDD → **Audiobookshelf** + music roots |
| **OS** | **Linux** *(recommended for SMB + long-running backup targets)* |

#### Stacks on LedgerShelf

| Stack | Path in this repo |
|-------|-------------------|
| **Restic REST server** | [`stacks/backup/restic-rest-server/`](../stacks/backup/restic-rest-server/) — primary **restic** destination for PCs |
| **Duplicati** | [`stacks/backup/duplicati/`](../stacks/backup/duplicati/) — schedules for **this host’s** paths + optional pushes to **VaultBloom** backup disk or cloud |
| **Nextcloud** | [`stacks/productivity/nextcloud/`](../stacks/productivity/nextcloud/) |
| **Project Nomad** | [`stacks/knowledge/project-nomad/`](../stacks/knowledge/project-nomad/) *(Compose filename **`compose.yml`**)* |
| **Plex** | [`stacks/media/plex/`](../stacks/media/plex/) *(or **Jellyfin**—pick one primary library)* |
| **Audiobookshelf** | [`stacks/media/audiobookshelf/`](../stacks/media/audiobookshelf/) |
| **Open Audio (Navidrome)** | [`stacks/media/open-audio/`](../stacks/media/open-audio/) |
| **Portainer** *(optional)* | [`stacks/networking/portainer/`](../stacks/networking/portainer/) |
| **NUT slave (`nut-slave`)** *(if on UPS A)* | [`stacks/power/nut-slave/`](../stacks/power/nut-slave/) |

**UPS / NUT:** **`MONITOR`** targets **InkRelay** when **LedgerShelf** shares **UPS A**.

### 6.5 **DiceBench** *(Linux dice table for game panels)*

Fictional **game-server** convertible or small tower—**Ubuntu** + panel UI (e.g. CasaOS) managing **AMP**; kept **off** the media box so reboots don’t rescrape Plex.

| | |
|--|--|
| **Hostname** | **DiceBench** |
| **Role** | **AMP** and similar always-on-ish game panels |
| **CPU** | **Intel** mobile *(example SKU)* |
| **RAM** | **12 GB** |
| **Network** | **1 Gigabit Ethernet** *(minimum)* — game traffic stays on copper |
| **System disk** | **256 GB** NVMe |
| **OS** | **Ubuntu Server** + **CasaOS** *(illustrative)* |

#### Stacks on DiceBench

| Stack | Path in this repo |
|-------|-------------------|
| **AMP** | *Not in this repo* — [CubeCoders AMP](https://cubecoders.com/AMP) |
| **NUT slave (`nut-slave`)** *(if on UPS A)* | [`stacks/power/nut-slave/`](../stacks/power/nut-slave/) |

**UPS / NUT:** **`MONITOR`** targets **InkRelay** when **DiceBench** rides **UPS A**.

### 6.6 **VaultBloom** *(workstation vault where GPU workloads bloom)*

Fictional **daily driver + AI forge**: sleeps sometimes; **never** **Pi-hole**, **NUT** USB master, or primary **backup server** in this ideal.

| | |
|--|--|
| **Hostname** | **VaultBloom** |
| **Role** | Gaming, creative work, **ComfyUI**, **Ollama** |
| **CPU** | AMD Ryzen **9-class** *(example SKU)* |
| **RAM** | **128 GB** DDR5 |
| **GPU** | NVIDIA GeForce **RTX-class** *(example tier)* |
| **Network** | **10 Gigabit Ethernet** *(preferred)* peer to **LedgerShelf**; **1 GbE** minimum to router |
| **Boot / projects** | Multi-TB NVMe layout *(games, builds, ISO staging)* |
| **Backup disk** | Large USB HDD → **full-system backup** target |
| **OS** | **Windows 11 Pro** *(64-bit)* |

#### Stacks on VaultBloom

| Stack | Path in this repo |
|-------|-------------------|
| **ComfyUI** | [`stacks/ai/comfyui/`](../stacks/ai/comfyui/) |
| **Ollama + Open WebUI** | [`stacks/ai/ollama-open-webui/`](../stacks/ai/ollama-open-webui/) |
| **Vaultwarden** *(optional)* | [`stacks/security/vaultwarden/`](../stacks/security/vaultwarden/) |

**UPS / NUT:** **UPS B** (desk). Prefer a **second tiny Pi** (**[`nut-master`](../stacks/power/nut-master/)**) for USB **B**, **or** rehearse **NUT on Windows** after every GPU/Docker change.

---

### 6.7 Cross-cutting habits *(same fictional cast)*

- **DNS:** Router DHCP DNS → **QuietLatch** (**Pi-hole**). Pi-hole **Local DNS** for **`plex.lan`**, **`amp.lan`**, **`nut.lan`** *(optional)*, etc., pointing at **LedgerShelf**, **DiceBench**, **VaultBloom**, **InkRelay** IPs.
- **NUT:** **InkRelay** runs **`nut-master`**; **QuietLatch**, **LedgerShelf**, **DiceBench** add **`nut-slave`** when they share **UPS A**—firewall **3493/tcp** from slave hosts to **InkRelay**.
- **Backups:** **Restic REST server** and **Duplicati** live on **LedgerShelf**; **restic** clients on PCs target **LedgerShelf**; **Duplicati** jobs pull **LedgerShelf** paths first, then optional copy to **VaultBloom** backup disk or cloud; **VaultBloom** may still keep a **local full-system** backup disk—**restore-test** quarterly on at least one path.
- **Security:** Pi-hole, WireGuard, Home Assistant, Portainer, Duplicati, Restic, AMP admin—**LAN-only** or **VPN**; no accidental WAN paste.

### 6.8 What this section does *not* claim

- **InkRelay / QuietLatch / LedgerShelf / DiceBench / VaultBloom** are illustrative names and hardware sketches—not prescriptions for your real lab.
- Real houses mix **CasaOS**, **AMP**, **Windows**, and **Wi‑Fi clients** for phones—this guide simply **does not** recommend Wi‑Fi **as the backbone** between lab servers.

---

*For the full production software catalog and security notes, keep **[suggested-stacks-production.md](suggested-stacks-production.md)** open beside this guide.*
