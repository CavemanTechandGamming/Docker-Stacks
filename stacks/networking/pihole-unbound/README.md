# Pi-hole + Unbound

Network-wide **ad blocking** and **DNS** using:

- **[Pi-hole](https://pi-hole.net/)** — blocklists, caching, and your LAN DNS entrypoint.
- **[Unbound](https://nlnetlabs.nl/projects/unbound/about/)** (via [`klutchell/unbound`](https://hub.docker.com/r/klutchell/unbound)) — recursive resolver so Pi-hole is not forced to trust a public upstream for every query.

Pi-hole forwards allowed queries to the `unbound` service on the internal Docker network (`FTLCONF_dns_upstreams: unbound`), matching the [upstream example compose](https://github.com/klutchell/unbound-docker/blob/main/examples/pi-hole/docker-compose.yml).

## Quick start

1. Copy the environment file and set an admin password:

   ```bash
   cp .env.example .env
   ```

2. Start the stack:

   ```bash
   docker compose up -d
   ```

3. Open the Pi-hole UI at `http://localhost:8080` (or your server IP on the HTTP port you set).

4. Point your **router DHCP “DNS server”** (or individual devices) at the **host IP** running this stack. Clients must use the host’s address; Pi-hole listens on host port `53` by default.

## What runs where

| Service   | Role |
|----------|------|
| `pihole` | Blocklists + answers client DNS on published `53` / UI on mapped HTTP(S) ports. |
| `unbound`| Recursive resolver; **not** published to the host — only reachable inside the compose network. |

## Optional: custom Unbound snippets

Unbound defaults in the image are suitable for many home labs. For extra tuning (matches Pi-hole’s [Unbound guide](https://docs.pi-hole.net/guides/dns/unbound/) spirit), add `.conf` files under `unbound/` and uncomment the volume on the `unbound` service in `compose.yaml`:

```yaml
volumes:
  - ./unbound:/etc/unbound/custom.conf.d:ro
```

See [`klutchell/unbound` usage](https://github.com/klutchell/unbound-docker#usageexamples).

## Host port `53` and Windows

- **Linux**: Publishing `53` may require that nothing else binds DNS on the host; you may need `sudo` / elevated Docker or `net.ipv4.ip_unprivileged_port_start` adjustments depending on distro.
- **Windows / Docker Desktop**: binding host port `53` is often blocked or already in use. For testing, you can temporarily map `5353:53` in `compose.yaml` and `dig @host -p 5353`; for real “whole network” DNS, plan for a Linux bridge or a host where `53` is free.

## Recursive DNS and your ISP

If outbound DNS to root servers is intercepted or broken, Unbound may fail in confusing ways. Pi-hole documents checks here: [Unbound guide — test root access](https://docs.pi-hole.net/guides/dns/unbound/#recommended-test-access-to-root-servers).

## DHCP

Pi-hole can act as DHCP; that requires UDP `67` published and `NET_ADMIN`, plus router configuration (or DHCP relay). Uncomment the DHCP port in `compose.yaml` only if you intend to use that mode.

## Operational notes

- Pi-hole’s data lives in the `pihole-etc` volume (`/etc/pihole` in the container).
- Pi-hole publishes guidance on **Watchtower** and automatic upgrades; read their [tips](https://docs.pi-hole.net/docker/tips-and-tricks/) before enabling unattended image updates.
- Environment-driven `FTLCONF_*` values are treated as the source of truth and may be read-only in the UI; see [Pi-hole Docker configuration](https://docs.pi-hole.net/docker/configuration/).

## Official references

- [Pi-hole](https://pi-hole.net/) — [pi-hole/pi-hole (GitHub)](https://github.com/pi-hole/pi-hole) — [pi-hole/docker-pi-hole (GitHub)](https://github.com/pi-hole/docker-pi-hole)
- [Unbound](https://nlnetlabs.nl/projects/unbound/about/) — [NLnet Labs Unbound (GitHub)](https://github.com/NLnetLabs/unbound)
- Unbound image used here: [klutchell/unbound-docker (GitHub)](https://github.com/klutchell/unbound-docker) — [Pi-hole + Unbound compose example](https://github.com/klutchell/unbound-docker/blob/main/examples/pi-hole/docker-compose.yml)
