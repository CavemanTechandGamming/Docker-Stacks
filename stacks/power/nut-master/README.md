# NUT master (`nut-master`) — UPS USB, `upsd`, and graceful shutdown

[Network UPS Tools (NUT)](https://networkupstools.org/) lets you read UPS status (on battery, charge %, runtime estimate) and coordinate **graceful shutdown** when power fails.

This stack is the **NUT master**: it runs [**instantlinux/nut-upsd**](https://hub.docker.com/r/instantlinux/nut-upsd) (multi-arch: **amd64 / arm64 / arm32** — suitable for **Raspberry Pi**). It exposes **`upsd`** on port **3493**, talks to the UPS over **USB** (`/dev/bus/usb`), and — important — the upstream image **`exec`s `upsmon -F`** after starting the driver and **`upsd`**, so **`upsmon` is part of this stack**, not an extra manual install for the master role.

**LAN slaves:** Other hosts on the same UPS should run **[`nut-slave`](../nut-slave/)** (or install **`nut-client`** on the host OS with their own **`upsmon.conf`**).

Homelab context: you and friends run these stacks at home; the Pi is a common place to plug a USB UPS and keep monitoring always on.

## What this container does / caveats

- **Does:** USB driver, **`upsd`** (LAN queries on **3493**), and **`upsmon`** in the **same** container (upstream entrypoint).
- **Host shutdown:** By default the image generates a minimal **`upsmon.conf`** ( **`MONITOR`** + **`RUN_AS_USER nut`** ) without an explicit **`SHUTDOWNCMD`**. That may **not** power off your Raspberry Pi when the battery is exhausted. Treat **[`upsmon.local.example`](upsmon.local.example)** → **`./local/upsmon.conf`** plus optional **`pid: host`** in **`compose.yaml`** as the **supported** way to make **`upsmon`** halt the **Docker host** cleanly — see **Graceful shutdown** below.

## Quick start (Raspberry Pi or Linux host)

1. Plug the UPS into USB on the machine that will run this stack.

2. Copy env and set a strong `NUT_API_PASSWORD`:

   ```bash
   cp .env.example .env
   ```

3. For many **APC** units, set **`NUT_SERIAL`** to the 12-digit serial (from `lsusb -v` on the host).

4. **Recommended before `up -d`:** create **`./local/`**, copy **`upsmon.local.example`** to **`./local/upsmon.conf`**, insert your **`NUT_API_PASSWORD`** on the **`MONITOR`** line, and uncomment **`pid: host`** under **`nut-master`** in **`compose.yaml`** if this is a dedicated NUT Pi (see **Graceful shutdown**).

5. Start:

   ```bash
   docker compose up -d
   ```

6. Query from the host (install `nut-client` if needed: `sudo apt install nut-client`):

   ```bash
   upsc ups@127.0.0.1:3493
   ```

   (Use `NUT_UPS_NAME` from `.env` instead of `ups` if you changed it: `upsc myups@127.0.0.1:3493`.)

## Graceful shutdown (Docker host)

Pick **one** primary approach (you can combine **`local/upsmon.conf`** with **`pid: host`**):

1. **`./local/upsmon.conf`** — Copy **[`upsmon.local.example`](upsmon.local.example)** to **`./local/upsmon.conf`**. It sets **`RUN_AS_USER root`**, **`SHUTDOWNCMD`**, and a **`MONITOR`** stanza for **`upsd`** inside the container (**`ups@localhost`**).

2. **`pid: host`** — Uncomment **`pid: host`** on the **`nut-master`** service in **`compose.yaml`**. The container shares the host PID namespace so **`/sbin/shutdown`** from **`upsmon`** targets the **machine**, not an isolated container namespace. **Trade-off:** weaker process isolation; acceptable on a **dedicated** NUT Pi.

After any change, **rehearse** a controlled shutdown (pull UPS mains for a few seconds in a safe window, or use documented NUT tests) so you trust the path before an outage.

Adjust timeouts and **`notify`** stanzas using [NUT upsmon documentation](https://networkupstools.org/docs/man/upsmon.html).

## Other machines (NAS, PC, friends’ servers)

Use **[`nut-slave`](../nut-slave/)** on each host that shares **this** UPS strip but **not** the USB cable — **`MONITOR`** targets **this** machine’s LAN IP and port **3493** with role **`slave`** and the same **`NUT_API_USER`** / **`NUT_API_PASSWORD`**.

## Custom driver / `ups.conf`

Mount overrides under **`./local/`** → `/etc/nut/local` (see [image README](https://hub.docker.com/r/instantlinux/nut-upsd)). You may need **`privileged: true`** and correct **`NUT_DRIVER`** / **`NUT_VENDORID`** / **`POLLINTERVAL`** for your hardware.

## Security

- **Do not expose port 3493 to the internet** without TLS/VPN and strong auth.
- Treat **`NUT_API_PASSWORD`** like any admin secret.

## Official references

- [Network UPS Tools](https://networkupstools.org/)
- [NUT documentation](https://networkupstools.org/documentation.html)
- [Hardware compatibility list](https://networkupstools.org/stable-hcl.html)
- [instantlinux/nut-upsd (Docker Hub)](https://hub.docker.com/r/instantlinux/nut-upsd) — [Source](https://github.com/instantlinux/docker-tools/tree/main/images/nut-upsd)
