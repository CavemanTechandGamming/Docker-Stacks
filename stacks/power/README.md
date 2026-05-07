# Power

**UPS and power-fail** tooling — monitoring power hardware and coordinating shutdowns (often on a Pi or small server).

## Stacks

- **[nut-master](nut-master/)** — NUT **master**: USB UPS + **`upsd`** + **`upsmon`** ([instantlinux/nut-upsd](https://hub.docker.com/r/instantlinux/nut-upsd))
- **[nut-slave](nut-slave/)** — NUT **slave**: **`upsmon`** only, subscribes to a **`nut-master`** over the LAN (local Alpine-based image)

If you add a stack here, list it above and follow **[docs/standards.md](../../docs/standards.md)** and **[CONTRIBUTING.md](../../CONTRIBUTING.md)**.
