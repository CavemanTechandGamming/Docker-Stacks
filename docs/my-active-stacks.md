# Stacks I’m running (personal checklist)

Working list of Compose stacks you actually run against this repo. **Incomplete** — add more as you audit your hosts.

---

## **cave-server** (~6 yr mini PC)

| | |
|--|--|
| **Hostname** | **cave-server** |
| **CPU** | AMD Ryzen 7 **4700U** with Radeon Graphics |
| **RAM** | **16 GB** DDR4 @ **3200 MHz** |
| **Network** | **1 Gigabit Ethernet** NIC *(wired)* |
| **System disk** | **~250 GB** PCIe SSD (boot) — **exact model not confirmed**; does not show a clear retail name under **Device Manager** / disk listings |
| **OS** | **Windows 10 Pro** (64-bit) |
| **LaCie Rugged** | Two × **5 TB** USB drives (reported as **USB SCSI disk** in Windows) → **Plex** libraries |
| **WD My Passport** | **2626** USB device, **5 TB** → **Audiobookshelf**; space/files for **music library** (**not set up yet**) |

### Stacks on cave-server

| Stack | Path in this repo |
|-------|-------------------|
| **Audiobookshelf** | [`stacks/media/audiobookshelf/`](../stacks/media/audiobookshelf/) — library on **WD My Passport** |
| **Plex** | [`stacks/media/plex/`](../stacks/media/plex/) — libraries on the **two LaCie Rugged** drives |
| **Music streaming** *(planned)* | [`stacks/media/open-audio/`](../stacks/media/open-audio/) — Navidrome; **not deployed**; intend to use **My Passport** alongside Audiobookshelf |
| **Pi-hole** | **Running today:** Pi-hole only (no Unbound yet). **Target:** [`stacks/networking/pihole-unbound/`](../stacks/networking/pihole-unbound/) — Pi-hole forwarding to local Unbound (recursive resolver). |

---

## **Game Server** (Lenovo **Yoga** — AMP / game servers)

Older **Lenovo Yoga** convertible *(exact model name not recorded)* — **AMP** moved here from **cave-server**. Managed via **CasaOS** on **Ubuntu Server**.

| | |
|--|--|
| **Hostname** | **Game Server** *(for now)* |
| **Hardware** | Lenovo **Yoga** *(exact SKU TBD)* |
| **CPU** | **Intel** *(specific SKU TBD)* |
| **RAM** | **12 GB** |
| **Network** | **Wi‑Fi** NIC only *(no wired uplink in use)* |
| **System disk** | **256 GB** NVMe SSD |
| **OS** | **Ubuntu Server** + **CasaOS** |

### Stacks on Game Server

| Stack | Path in this repo |
|-------|-------------------|
| **AMP** (game server panel, CubeCoders) | *Not in this repo yet* — [CubeCoders AMP](https://cubecoders.com/AMP) |

---

## **Obsidian Rainbow** (main PC — gaming + daily driver)

ComfyUI and Ollama + Open WebUI run **here**, not on **cave-server**. This is also your **primary** Windows machine for gaming and general use.

| | |
|--|--|
| **Hostname** | **Obsidian Rainbow** |
| **CPU** | AMD Ryzen 9 **9950X** |
| **RAM** | **128 GB** DDR5 @ **6000 MHz** |
| **GPU** | NVIDIA GeForce **RTX 3080 Ti** |
| **Network** | **10 Gigabit Ethernet** NIC *(wired)* |
| **Samsung SSD 990 Pro** *(boot)* | **2 TB** NVMe — Windows / system |
| **Samsung SSD 990 Pro** *(games)* | **4 TB** NVMe — all **games** |
| **Samsung SSD 990 Pro** *(projects & images)* | **4 TB** NVMe — programs you’re **building**, installers, and **OS images** before writing to USB |
| **Seagate Expansion** *(backup)* | **12 TB** USB external HDD — **full system backup** destination |
| **OS** | **Windows 11 Pro** |

### Stacks on Obsidian Rainbow

| Stack | Path in this repo |
|-------|-------------------|
| **ComfyUI** | [`stacks/ai/comfyui/`](../stacks/ai/comfyui/) |
| **Ollama + Open WebUI** | [`stacks/ai/ollama-open-webui/`](../stacks/ai/ollama-open-webui/) |

## Still to verify

*(Add rows or host sections after you look through Portainer / compose folders.)*

---

*Tip: keep `.env` and secrets out of this file; link to stack READMEs for how to run each project.*

*Network rows describe the **NIC / link type** (what the interface is built for and typically negotiates), not **sustained throughput**—real speeds depend on switches, cables, CPU load, protocol overhead, disk, and (for Wi‑Fi) RF conditions and distance.*
