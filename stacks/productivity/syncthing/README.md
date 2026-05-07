# Syncthing

Continuous **folder synchronization** between your PCs, NAS, and phones using **[Syncthing](https://syncthing.net/)**. Matches your research triage (**Syncthing**, row **#74**).

This stack is **not** a snapshot backup tool like **[Duplicati](../../backup/duplicati/)** or **[restic](../../backup/restic-rest-server/)**, and it is **not** a central “cloud drive” like **[Nextcloud](../nextcloud/)**. It keeps **chosen folders identical across devices** over encrypted peer connections—ideal for documents or project trees that should exist on more than one machine.

## Before you start

1. `cp .env.example .env` and adjust ports if **8384** / **22000** / **21027** already conflict on this host.

2. Ensure **`SYNCTHING_CONFIG_DIR`** exists on the host (defaults to **`./config`**). The official image runs Syncthing as **UID/GID 1000**; if Docker creates an empty directory as root, fix ownership so Syncthing can write:

   ```bash
   mkdir -p config
   sudo chown -R 1000:1000 config   # Linux — omit sudo if your user owns the tree
   ```

3. **Optional:** create **`sync/`**, uncomment the **`/sync`** volume line in **`compose.yaml`**, set **`SYNCTHING_SYNC_DIR=./sync`** in **`.env`**, then add a Syncthing folder pointing at **`/sync`** in the web UI.

4. `docker compose up -d`

5. Open **`http://<host-ip>:8384`**, set the GUI login (**Actions → Settings → GUI**) if this host is shared or reachable beyond trusted LAN.

## Pairing devices

Each machine runs its **own** Syncthing instance (this stack on your server, the Syncthing app or another Compose stack elsewhere). Use **Add remote device** on both sides and approve IDs out-of-band. Pick folders and directions (**send**, **receive**, **send & receive**) explicitly—Syncthing does **not** guess scope.

## Security

- Treat **8384** as **admin UI**: firewall from VLANs or WAN unless you fully trust every client on that segment.
- **22000/tcp** and **22000/udp** carry sync traffic; **21027/udp** helps **local discovery** on the LAN only—still expose deliberately.
- Prefer **VPN** or **LAN-only** operation for sensitive folders; use Syncthing’s built-in device passwords when pairing across networks.

## Official references

- [Syncthing](https://syncthing.net/)
- [Syncthing documentation](https://docs.syncthing.net/)
- [syncthing/syncthing (Docker Hub)](https://hub.docker.com/r/syncthing/syncthing)
