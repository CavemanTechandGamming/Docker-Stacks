# Networking

**How devices find and reach your services:** DNS filtering, TLS termination, and remote access into the lab.

## Stacks

- **[pihole-unbound](pihole-unbound/)** — Pi-hole with Unbound (LAN DNS and ad blocking)
- **[caddy](caddy/)** — Caddy reverse proxy (e.g. `homelab_edge` for edge routing)
- **[wireguard](wireguard/)** — WireGuard VPN (LinuxServer image)

If you add another networking / edge stack, put it in this folder and list it here.
