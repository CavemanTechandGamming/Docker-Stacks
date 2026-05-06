# NUT (`nut-upsd`) — UPS power and graceful shutdown

[Network UPS Tools (NUT)](https://networkupstools.org/) lets you read UPS status (on battery, charge %, runtime estimate) and coordinate **graceful shutdown** when power fails.

This stack runs [**instantlinux/nut-upsd**](https://hub.docker.com/r/instantlinux/nut-upsd) (multi-arch: **amd64 / arm64 / arm32** — suitable for **Raspberry Pi**). It exposes **`upsd`** on port **3493** and talks to the UPS over **USB** (`/dev/bus/usb`).

Homelab context: you and friends run these stacks at home; the Pi is a common place to plug a USB UPS and keep monitoring always on.

## What this container does / does not do

- **Does:** USB driver + `upsd` so clients can query the UPS (`upsc`, `upsmon`, monitoring tools).
- **Does not by itself:** Reliably **`shutdown`** the Raspberry Pi from inside the container. For that, run **`upsmon` on the Pi host** (recommended) or a carefully designed notify path — see below.

## Quick start (Raspberry Pi or Linux host)

1. Plug the UPS into USB on the machine that will run this stack.

2. Copy env and set a strong `NUT_API_PASSWORD`:

   ```bash
   cp .env.example .env
   ```

3. For many **APC** units, set **`NUT_SERIAL`** to the 12-digit serial (from `lsusb -v` on the host).

4. Start:

   ```bash
   docker compose up -d
   ```

5. Query from the host (install `nut-client` if needed: `sudo apt install nut-client`):

   ```bash
   upsc ups@127.0.0.1:3493
   ```

   (Use `NUT_UPS_NAME` from `.env` instead of `ups` if you changed it: `upsc myups@127.0.0.1:3493`.)

## Graceful shutdown (recommended pattern)

1. Keep **`nut-upsd`** in Docker as above.
2. On the **same Pi**, install the client tools:  
   `sudo apt install nut-client`
3. Create **`/etc/nut/upsmon.conf`** (paths can differ slightly by distro) with content like:

   ```conf
   RUN_AS_USER root
   MINSUPPLIES 1
   SHUTDOWNCMD "/sbin/shutdown -h +0"
   POWERDOWNFLAG /etc/killpower
   DEADTIME 25
   MONITOR ups@127.0.0.1:3493 1 upsmon YOUR_NUT_API_PASSWORD primary
   ```

   Replace `ups` with `NUT_UPS_NAME` and use the same password as **`NUT_API_PASSWORD`** in `.env`.

4. Enable and start **`nut-monitor`** on the host (service name varies, e.g. `upsmon` / `nut-monitor`).

Then when NUT decides power is critical, **`upsmon` on the Pi** runs **`SHUTDOWNCMD`** and the **whole system** (and Docker) goes down cleanly. Adjust timeouts and **`notify`** stanzas using [NUT upsmon documentation](https://networkupstools.org/docs/man/upsmon.html).

## Other machines (NAS, PC, friends’ servers)

Install **NUT client** on each host and point **`MONITOR`** at the Pi’s LAN IP and port **3493** (same user/password). Configure each host’s **`SHUTDOWNCMD`** appropriately. This is the standard **NUT master / slave** style layout.

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
