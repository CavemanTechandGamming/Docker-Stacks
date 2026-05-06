# OpenConnect (ocserv)

Self-hosted **[OpenConnect](https://www.infradead.org/openconnect/)** VPN server using **[ocserv](https://gitlab.com/openconnect/ocserv)**, packaged for Docker. Clients include **OpenConnect** (Linux/macOS/Windows) and often **Cisco AnyConnect**–compatible apps.

This stack uses the lightweight **[cherts/ocserv](https://hub.docker.com/r/cherts/ocserv)** image (Alpine-based, **amd64** and **arm64**), which fits **Raspberry Pi** and other small hosts.

## Research note (`research-self-hosted-apps.local.md` row 295)

That row lists **PiVPN-OpenConnect** (`chriswayg/pivpn-openconnect`). The linked GitHub repository and Docker image were **not found** (404) when this stack was added, so this folder implements the same *role* (OpenConnect/AnyConnect-style remote access) with a maintained **multi-arch** image instead.

## Requirements

- **Linux host** (bare metal, VM, or Raspberry Pi OS) with Docker. **Docker Desktop** on Windows/macOS is a poor fit for VPN servers (no TUN/routing parity with a Pi or VPS).
- **`net.ipv4.ip_forward=1`** on the host if clients should reach beyond the VPN server (typical site-to-LAN). Example:

  ```bash
  sudo sysctl -w net.ipv4.ip_forward=1
  ```

- **Firewall / NAT**: allow the published TCP and UDP ports (default **443**) from the internet if you want remote clients; forward them on your router.

## Quick start

1. `cp .env.example .env` and set **`HC_SRV_CN`** to a name that matches how clients will reach the server (often your DDNS hostname).

2. `docker compose up -d`

3. Get the initial **`test`** user password (unless you set **`HC_NO_TEST_USER`**):

   ```bash
   docker compose logs ocserv | findstr /i "Creating test user"
   ```

   (On Linux/macOS, use `grep` instead of `findstr`.)

4. Connect with an OpenConnect client to `https://<your-host>:<OCSERV_PUBLISH_TCP_PORT>/` using that username/password.

5. For production, create real users, set **`HC_NO_TEST_USER`**, and manage passwords per [cherts/ocserv](https://github.com/cherts/ocserv_docker) / ocserv docs.

## Host port conflicts

If **443** is already used (e.g. Caddy), set **`OCSERV_PUBLISH_TCP_PORT`** and **`OCSERV_PUBLISH_UDP_PORT`** to something else (e.g. **4443**) and forward those on your router.

## Alternatives in this repo

- **[WireGuard](../wireguard/)** — different protocol, often simpler UDP-only NAT traversal.

## Official references

- [OpenConnect](https://www.infradead.org/openconnect/)
- [ocserv](https://gitlab.com/openconnect/ocserv) — [manual](https://ocserv.openconnect-vpn.net/ocserv.8.html)
- [cherts/ocserv (Docker Hub)](https://hub.docker.com/r/cherts/ocserv) — [ocserv_docker (GitHub)](https://github.com/cherts/ocserv_docker)
