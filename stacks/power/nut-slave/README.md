# NUT slave (`nut-slave`) — `upsmon` for hosts without the UPS USB cable

Use this stack on **Linux Docker hosts** that sit behind the **same UPS** as your **[`nut-master`](../nut-master/)** box but **do not** have the UPS data cable. **`upsmon`** subscribes to the master’s **`upsd`** on **TCP 3493** and runs **`SHUTDOWNCMD`** on **this** machine when the battery is exhausted.

This is standard **NUT master / slave** layout; here **`upsmon`** runs in an **Alpine** container built from the official **`nut`** package.

## Prerequisites

- A running **[`nut-master`](../nut-master/)** on the LAN (**`upsd`** reachable from this host on port **3493**).
- **`NUT_API_USER`** / **`NUT_API_PASSWORD`** on the slave’s **`MONITOR`** line must match the master’s **`.env`**.
- **Firewall:** allow **this host → master:3493/tcp** (and **UDP 3493** if your `upsd` uses it).

## Quick start

1. On **this** host:

   ```bash
   cp .env.example .env
   mkdir -p local
   cp upsmon.slave.example local/upsmon.conf
   ```

2. Edit **`local/upsmon.conf`**: set **`MASTER_IP`**, password, UPS name, and port if not **3493**. Keep role **`slave`** on the **`MONITOR`** line.

3. Build and start:

   ```bash
   docker compose build
   docker compose up -d
   ```

**`privileged: true`** and **`pid: host`** are set so **`SHUTDOWNCMD`** can affect the **Docker host** (same class of requirement as on the master — rehearse once).

## Alpine `SHUTDOWNCMD`

The example uses **`/sbin/poweroff`** (BusyBox on Alpine). On some hosts you may need **`/sbin/shutdown -h +0`** — install matching tools or bind-mount host **`/sbin`** only if you understand the trade-offs.

## Security

- Keep **3493** on the **LAN only** (VPN/firewall), same as the master README.
- **`local/upsmon.conf`** holds secrets — do not commit it; **`local/`** is gitignored.

## Official references

- [Network UPS Tools](https://networkupstools.org/)
- [upsmon.conf](https://networkupstools.org/docs/man/upsmon.conf.html)
- Master image: [instantlinux/nut-upsd](https://hub.docker.com/r/instantlinux/nut-upsd)
