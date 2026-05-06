# Duplicati

[Duplicati](https://www.duplicati.com/) is a backup tool with a **web UI**: encrypted backups to local disk, NAS, S3-compatible storage, and many other targets.

It lives in its **own** stack so you can:

- Mount **read-only** paths of the data you want to protect without coupling to Vaultwarden or DNS.
- Restart or upgrade backups without touching your password vault.

Vaultwarden’s SQLite/volume should be **included in a Duplicati job** (or another backup method) so you can restore passwords if the volume is lost.

## Quick start

1. Copy the environment file:

   ```bash
   cp .env.example .env
   ```

2. Set **`DUPLICATI_SOURCE_DIR`** in `.env` to a **host path** you want to back up (photos, stack volumes, etc.), or add more read-only volumes in `compose.yaml`.

3. Start:

   ```bash
   docker compose up -d
   ```

4. Open `http://localhost:8200` (or your host IP on that port) and complete the Duplicati setup wizard.

5. Create a backup job: source `/source` (and any extra mount points), choose destination, **encryption passphrase**, and schedule.

## Backing up **client** computers (Windows / Mac / Linux)

The stack above runs Duplicati **on the server** and only sees files you **mount** into the container. To back up **your PC’s disks** to the homelab, use either:

1. **Duplicati on the PC** — install [Duplicati](https://duplicati.com/) locally and set the **backup destination** to something your server exposes (SMB share, SFTP, WebDAV, S3-compatible, etc.), or  
2. **[Restic REST server](../restic-rest-server/)** — run the server stack on the homelab, install the **restic** CLI on the PC, and `restic backup` to a `rest:` URL (see that stack’s README).

## Mounting more than one source

Duplicate the volume pattern in `compose.yaml`, for example:

```yaml
volumes:
  - /path/to/immich/library:/immich:ro
```

Then in the Duplicati UI, add `/immich` (and `/source`) as sources.

## Docker volume backups

Named volumes (e.g. Vaultwarden’s `vaultwarden-data`) live under Docker’s storage root. Options:

- Use **Duplicati** on the host to back up that path if you know it, or
- Run a **temporary** container that mounts the volume and backs up from inside, or
- Use **`docker run --volumes-from`** / bind-mount the volume to a path Duplicati can read.

Pick the approach that matches your OS and comfort level.

## Security

- The Duplicati UI is powerful (reads your files). **Do not expose port 8200** to the internet without a VPN or reverse proxy and access control.
- Store the **backup encryption passphrase** somewhere safe (password manager, offline copy).

## Official references

- [Duplicati](https://www.duplicati.com/)
- [duplicati/duplicati (GitHub)](https://github.com/duplicati/duplicati)
- Image used here: [LinuxServer.io Duplicati](https://docs.linuxserver.io/images/docker-duplicati/) — [linuxserver/docker-duplicati (GitHub)](https://github.com/linuxserver/docker-duplicati)
