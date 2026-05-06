# WireGuard (LinuxServer)

[WireGuard](https://www.wireguard.com/) VPN using [LinuxServer.io’s image](https://docs.linuxserver.io/images/docker-wireguard/), which can generate a **server** config and **peer** profiles from environment variables.

## Requirements

- **Linux host** (bare metal or VM) with WireGuard support for this container pattern. **Docker Desktop on Windows** usually will **not** give you a working server the same way; use WSL2/Linux or run WireGuard on the host/router instead.
- **UDP** port `51820` (or your `WG_SERVERPORT`) forwarded on your edge router if you want inbound clients from the internet.

## Quick start

1. Copy the environment file and set `WG_SERVERURL` if not using `auto`:

   ```bash
   cp .env.example .env
   ```

2. Start:

   ```bash
   docker compose up -d
   ```

3. Fetch client configs / QR codes:

   - Logs: `docker compose logs wireguard` (if `WG_LOG_CONFS=true`)
   - Files under `./config/peer_*` (or `./config/peer1` when `PEERS` is a number)
   - Show QR: `docker compose exec wireguard /app/show-peer 1`

4. Import the `.conf` or QR into the WireGuard app on your phone/laptop.

## Pi-hole / LAN DNS

For **split tunneling** or “use Pi-hole only when on VPN”, adjust `WG_ALLOWEDIPS` and peer routes; see [LinuxServer WireGuard docs](https://docs.linuxserver.io/images/docker-wireguard/) (`PEERDNS`, `SERVER_ALLOWEDIPS_PEER_*`, etc.).

## Security

- Protect `./config` — it contains **private keys**.
- This stack is **not** a substitute for hardening your router or monitoring who can reach UDP `WG_SERVERPORT`.

## Official references

- [WireGuard](https://www.wireguard.com/)
- [LinuxServer WireGuard](https://docs.linuxserver.io/images/docker-wireguard/) — [linuxserver/docker-wireguard (GitHub)](https://github.com/linuxserver/docker-wireguard)
