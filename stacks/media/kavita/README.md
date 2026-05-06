# Kavita

[Kavita](https://www.kavitareader.com/) is a self-hosted reading server for ebooks, comics, and manga (OPDS, libraries, reader UI). It is a common choice when you want a **private library** instead of a commercial e-reader cloud. This stack uses the [LinuxServer.io Kavita image](https://docs.linuxserver.io/images/docker-kavita/).

## Quick start

1. Copy the environment file:

   ```bash
   cp .env.example .env
   ```

2. Put books or comics under **`data/`** (or point `KAVITA_DATA_DIR` at an existing library tree).

3. Start:

   ```bash
   docker compose up -d
   ```

4. Open **http://localhost:5000** (or `KAVITA_PORT`) and finish the setup wizard. Add library roots that match your mounts (default **`/data`** inside the container).

## Multiple library folders

The LinuxServer docs describe optional extra mounts (for example separate `/books`, `/comics`, `/manga` paths). Add matching `volumes:` entries in `compose.yaml` if you prefer several host directories instead of one **`data`** tree.

## Permissions

On **Linux**, adjust **`PUID`** / **`PGID`** in `.env` so new files match your media owner. See the [LinuxServer “Understanding PUID and PGID”](https://docs.linuxserver.io/general/understanding-puid-and-pgid/) guide.

## Reverse proxy

Put [Caddy](../../networking/caddy/) (or another proxy) in front for HTTPS. Set Kavita’s **public URL** in the app if you use a domain.

## Related stacks

- **[Audiobookshelf](../audiobookshelf/)** — audiobooks and podcasts (different role; pairs well on the same homelab).

## Official references

- [Kavita](https://www.kavitareader.com/)
- [Kareadita/Kavita (GitHub)](https://github.com/Kareadita/Kavita)
- [LinuxServer — Kavita](https://docs.linuxserver.io/images/docker-kavita/)
