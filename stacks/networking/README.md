# Networking

**How traffic enters and crosses the lab:** DNS, TLS termination, VPNs, dashboards, Docker administration, and **controlled file access** at the edge (SFTP/WebDAV or a simple web file UI)—not generic “whole-house” file suites (see **[productivity/nextcloud/](../productivity/nextcloud/)**).

## Stacks

- **[caddy](caddy/)** — Caddy reverse proxy (e.g. `homelab_edge` for edge routing)
- **[filebrowser](filebrowser/)** — File Browser (lightweight web UI for one exposed folder tree)
- **[homepage](homepage/)** — [Homepage](https://gethomepage.dev/) application dashboard
- **[openconnect](openconnect/)** — OpenConnect / ocserv VPN (AnyConnect-compatible; Pi-friendly image)
- **[pihole-unbound](pihole-unbound/)** — Pi-hole with Unbound (LAN DNS and ad blocking)
- **[portainer](portainer/)** — Portainer CE (Docker management UI)
- **[sftpgo](sftpgo/)** — SFTPGo (SFTP / FTPS / WebDAV + web admin)
- **[wireguard](wireguard/)** — WireGuard VPN (LinuxServer image)

If you add a stack here, list it above and follow **[docs/standards.md](../../docs/standards.md)** and **[CONTRIBUTING.md](../../CONTRIBUTING.md)**.
