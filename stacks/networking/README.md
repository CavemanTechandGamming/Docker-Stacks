# Networking

**How traffic enters and crosses the lab:** DNS, TLS termination at the edge, remote-access and overlay tunnels, dashboards, Docker operations, and **focused** LAN or perimeter file portals—distinct from household-scale sync suites (see **[`productivity/nextcloud/`](../productivity/nextcloud/)**).

## Stacks

Stacks are listed **alphabetically** by directory name.

The **type** column is a **high-level role label**. You will often compose several—for example Pi-hole beside Caddy, or WireGuard alongside NetBird experimentation—but each stack solves a narrower problem than an all-in-one “network appliance.”

| Stack | Type | Description |
|-------|------|-------------|
| [caddy](caddy/) | Reverse proxy & TLS | **Caddy** edge reverse proxy with automatic HTTPS for Internet-facing DNS names—kept **separate** from LAN recursive DNS so **Caddyfile** or certificate churn cannot take down **[pihole-unbound](pihole-unbound/)**. |
| [filebrowser](filebrowser/) | Edge file portal (web) | **File Browser** exposes one host directory tree in the browser (browse, uploads, shares, light accounts)—narrower footprint than **[sftpgo](sftpgo/)** protocols or **[Nextcloud](../../productivity/nextcloud/)** as a productivity suite. |
| [headscale](headscale/) | Overlay coordination (Tailscale) | **Headscale** replaces the hosted Tailscale control plane while clients still run stock **Tailscale** apps; Compose runs **`serve`** read-only with **`tmpfs`** for UNIX sockets—tune **`config/config.yaml`** for **`server_url`**, **`dns.base_domain`**, and ACL/policy files before clients join. |
| [homepage](homepage/) | Homelab dashboard | **[Homepage](https://gethomepage.dev/)** organizes bookmarks and status widgets—no first-party authentication; terminate TLS and attach auth at **[caddy](caddy/)** (or equivalent) before exposing WAN-side. |
| [netbird](netbird/) | Overlay networking (NetBird) | **NetBird combined server + dashboard**—mesh control with relays, signaling, OAuth, and **UDP 3478** STUN needing careful HTTPS fronts plus **`h2c`** gRPC forwarding; read the stack README, then defer to **[NetBird self-hosted quickstart](https://docs.netbird.io/selfhosted/selfhosted-quickstart)** for first production installs. |
| [openconnect](openconnect/) | Remote access VPN (TLS) | **OpenConnect / ocserv** VPN (**AnyConnect-style** thin clients via **`cherts/ocserv`**, Raspberry Pi friendly) demanding deliberate NAT, **ip_forward**, and published **443** TCP/UDP—compare with **[wireguard](wireguard/)** for pure WireGuard ergonomics. |
| [pihole-unbound](pihole-unbound/) | LAN DNS & filtering | **Pi-hole + Unbound** pair configured so Pi-hole’s upstream is the **`unbound`** container—LAN-wide recursion, caching, filtering—orthogonal to HTTPS edge routers such as **[caddy](caddy/)**. |
| [portainer](portainer/) | Container operations | **Portainer CE** attaches to Docker’s **socket** for stack, secret, volume, and image workflows—protect like any omnipotent orchestration dashboard (network ACLs, credentials, audited changes). |
| [sftpgo](sftpgo/) | Protocol file servers | **SFTPGo** multiplexes **SFTP**, optional **FTP/FTPS**, **WebDAV**, and admin/UI surfaces over **`lib/`** + **`srv/`** bind mounts geared to backup ingestion or partner uploads—prefer **[filebrowser](filebrowser/)** when HTTPS browsing alone suffices. |
| [wireguard](wireguard/) | Remote access VPN (WireGuard) | **LinuxServer WireGuard** auto-materializes server + **`peer_*`** artifacts and QR onboarding—explicitly framed for **Linux-class Docker hosts** (**README** warns **Docker Desktop** Windows/mac scenarios differ materially). |

If you add a stack here, extend the table alphabetically by folder name and follow **[docs/standards.md](../../docs/standards.md)** and **[CONTRIBUTING.md](../../CONTRIBUTING.md)**.
