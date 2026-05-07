# Power

**UPS awareness and coordinated shutdowns** using **Network UPS Tools (NUT)**—typically a **USB-attached master** on an always-on Pi or server, with **slaves** elsewhere on the same battery feed.

## Stacks

Stacks are listed **alphabetically** by directory name.

The **type** column captures the **NUT role**: who owns the USB cable versus who only listens on the LAN.

| Stack | Type | Description |
|-------|------|-------------|
| [nut-master](nut-master/) | UPS master | **`instantlinux/nut-upsd`** multi-arch image: USB driver, **`upsd`**, and packaged **`upsmon`**—documented **`local/upsmon.conf`** + optional **`pid: host`** path for real host shutdown when batteries exhaust. |
| [nut-slave](nut-slave/) | UPS client | Alpine **`upsmon`** subscribing to **`nut-master:3493`** so **this** Linux Docker host halts when upstream NUT declares critical power—requires matching credentials and reachable TCP **3493**. |

If you add a stack here, extend the table alphabetically by folder name and follow **[docs/standards.md](../../docs/standards.md)** and **[CONTRIBUTING.md](../../CONTRIBUTING.md)**.
