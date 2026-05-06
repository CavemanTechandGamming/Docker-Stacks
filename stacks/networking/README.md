# Networking

**How devices find and reach your services:** DNS filtering, TLS termination, remote access, and a browser landing page for everything else.

## Stacks

- **[pihole-unbound](pihole-unbound/)** — Pi-hole with Unbound (LAN DNS and ad blocking)
- **[caddy](caddy/)** — Caddy reverse proxy (e.g. `homelab_edge` for edge routing)
- **[wireguard](wireguard/)** — WireGuard VPN (LinuxServer image)
- **[homepage](homepage/)** — [Homepage](https://gethomepage.dev/) application dashboard
- **[portainer](portainer/)** — Portainer CE (Docker management UI)
- **[openconnect](openconnect/)** — OpenConnect / ocserv VPN (AnyConnect-compatible; Pi-friendly image)

If you add another networking / edge stack, put it in this folder and list it here.
