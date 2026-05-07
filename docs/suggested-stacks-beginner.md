# Suggested starter stack — modest homelab hardware

This document is a **concise blueprint** for a first homelab on an **older mini PC** (typical machines from the last 5–10 years: **4–8 GB RAM**, low-power **x86_64** CPU, small **SSD**, no GPU assumed). Everything listed exists in this repository as a ready-made Compose project.

---

## 1. What you need (hardware)

| Requirement | Minimum | Recommended |
|-------------|---------|-------------|
| **RAM** | 4 GB (host + Docker + a few light containers) | 8 GB |
| **CPU** | 64-bit, 2 cores | 4 logical CPUs |
| **Storage** | SSD for OS and container layers | SSD + separate disk later for media or backups |
| **Network** | Ethernet to your router | Static IP or DHCP reservation for the homelab host |

**Host OS:** **Linux** on bare metal (or a small Linux VM) is the best fit for this profile. Docker Desktop on Windows or macOS works for learning but usually leaves **less RAM** for containers on the same class of hardware.

---

## 2. Suggested software stack and rationale

The goal is **high utility, low idle cost**: DNS control, visibility into Docker, and a single dashboard—then passwords and VPN when you need them.

**Backup and UPS framing:** The suggested-stack guides in **`docs/`** use the **same operational stance**: backups are **baseline hygiene** (scheduled, encrypted, proven with an occasional **restore-test**), and a **UPS** should drive **graceful shutdown** via **NUT**—not silent optimism. This tier uses **Duplicati** only; **[intermediate](suggested-stacks-intermediate.md)** adds **Restic REST server**, and **[production](suggested-stacks-production.md)** expects both paths plus stricter habits—same principles, more capacity. When services span **several PCs**, read **[split-host](suggested-stacks-split-host.md)** after production (Pi-class **NUT** masters, UPS ownership, low- vs high-power roles).

### Core starter (deploy first)

| Service | Repository path | Why it belongs in a minimal lab |
|---------|-----------------|--------------------------------|
| **Pi-hole + Unbound** | [`stacks/networking/pihole-unbound/`](../stacks/networking/pihole-unbound/) | LAN-wide DNS with optional filtering; **Unbound** answers queries recursively so everyday browsing does not depend on your ISP’s resolver alone. |
| **Portainer** | [`stacks/networking/portainer/`](../stacks/networking/portainer/) | Web UI for containers and Compose stacks; reduces friction for beginners who are not yet comfortable with only the CLI. |
| **Homepage** | [`stacks/networking/homepage/`](../stacks/networking/homepage/) | One landing page linking to Pi-hole, Portainer, and future services—keeps the lab navigable as it grows. |

Together, these three stay **light at idle** and are a coherent **day-one** set on a 4 GB machine if the host is not running much else.

### Backups (recommended for every homelab)

| Service | Repository path | Why it belongs in the baseline |
|---------|-----------------|--------------------------------|
| **Duplicati** | [`stacks/backup/duplicati/`](../stacks/backup/duplicati/) | Scheduled **encrypted** backups with a web UI. Include Pi-hole data, Compose **volumes**, and bind-mounted paths—not only downloads. Run backup **windows off-peak** on tight hardware; **restore-test** periodically; keep at least one generation **off-site** or on a **second machine** when you can. |

Treat backups like DNS: **not glamorous**, but the first thing you miss when they are absent.

### UPS and graceful shutdown (when you have a UPS)

| Service | Repository path | Why it matters |
|---------|-----------------|----------------|
| **NUT master (`nut-master`)** | [`stacks/power/nut-master/`](../stacks/power/nut-master/) | **UPS USB** at **this** host: **[instantlinux/nut-upsd](https://hub.docker.com/r/instantlinux/nut-upsd)** runs **USB driver**, **`upsd`** (port **3493**), and **`upsmon`** in one container. Use **`./local/upsmon.conf`** (see **[`upsmon.local.example`](../stacks/power/nut-master/upsmon.local.example)**) and optional **`pid: host`** so **`upsmon`** can **halt the Docker host**—see **[README](../stacks/power/nut-master/README.md)**. |
| **NUT slave (`nut-slave`)** | [`stacks/power/nut-slave/`](../stacks/power/nut-slave/) | Same UPS power strip as the master, **no** USB cable here: **`docker compose build`** then **`up -d`**; **`local/upsmon.conf`** from **[`upsmon.slave.example`](../stacks/power/nut-slave/upsmon.slave.example)** (**`slave`** role). |

No UPS is fine for learning; **with** a UPS, wiring shutdown correctly is part of running the lab responsibly.

### Common next steps (after core + backups are underway)

| Service | Repository path | Why add it next |
|---------|-----------------|-----------------|
| **Vaultwarden** | [`stacks/security/vaultwarden/`](../stacks/security/vaultwarden/) | Self-hosted password vault (Bitwarden-compatible); valuable before you create many local accounts. |
| **Uptime Kuma** | [`stacks/monitoring/uptime-kuma/`](../stacks/monitoring/uptime-kuma/) | Simple uptime checks for Pi-hole, the host, or external sites. |

### When you have a clear need

| Service | Repository path | When it makes sense |
|---------|-----------------|---------------------|
| **WireGuard** | [`stacks/networking/wireguard/`](../stacks/networking/wireguard/) | Remote access to the lab over VPN; expect a **Linux** host for the usual container pattern—read that stack’s README first. |
| **Caddy** | [`stacks/networking/caddy/`](../stacks/networking/caddy/) | Reverse proxy and HTTPS once you expose multiple web apps or use real hostnames. |

---

## 3. How to set it up (quick path)

1. **Install Docker Engine and Compose V2** on the host, and confirm with `docker version` and `docker compose version`. Use **[docker-install.md](docker-install.md)** for platform-specific steps.

2. **Clone this repository** on the homelab machine (or copy only the stack folders you need).

3. **Deploy each stack from its own directory**, in this order: **Pi-hole + Unbound** → **Portainer** → **Homepage**. For each one:
   - `cd` into the stack folder (for example `stacks/networking/pihole-unbound/`).
   - Copy `.env.example` to `.env` and adjust values.
   - Run `docker compose up -d`.
   - Read that folder’s **README.md** for ports, volumes, and one-time setup (Pi-hole admin password, etc.).

4. **Backups:** Deploy **Duplicati** from [`stacks/backup/duplicati/`](../stacks/backup/duplicati/) using the same pattern. Include Pi-hole data, stack volumes, and any bind-mounted folders you care about; **restore-test** (recover at least one file or folder) before you trust the job.

5. **Point DNS at Pi-hole:** On your router, set the **LAN DNS** (or DHCP DNS option) to the **static IP** of the homelab host running Pi-hole, or assign Pi-hole only on devices you control. Confirm browsing still works, then tighten blocklists if you use them.

6. **Secure the management UIs:** Keep Portainer, Homepage, Pi-hole, and Duplicati on **trusted LAN** only (or behind **WireGuard** / a reverse proxy with auth). Do not publish their ports to the public internet without TLS and access control.

7. **If you use a UPS on this host:** **USB here** ⇒ **[`stacks/power/nut-master/`](../stacks/power/nut-master/)** (**`upsd`** + **`upsmon`**); **`local/upsmon.conf`** / **`pid: host`** per README. **Same UPS, another PC** ⇒ **[`stacks/power/nut-slave/`](../stacks/power/nut-slave/)**—same **NUT** pattern as intermediate and production.

8. **Optional:** Track what you actually run in **[my-active-stacks.md](my-active-stacks.md)** so this blueprint and your real deployment stay aligned.

---

*This guide is opinionated and scoped to small hardware; the full catalog lives under [`stacks/`](../stacks/README.md).*
