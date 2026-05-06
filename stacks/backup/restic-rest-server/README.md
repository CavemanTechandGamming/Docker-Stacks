# Restic REST server

This stack runs **[restic/rest-server](https://github.com/restic/rest-server)** on your homelab: a small HTTP service that stores **[restic](https://restic.net/)** repositories. It matches your research triage (**Restic**, rows **#69** / **#131**).

Use it for **full file-level backups of your computers** to the server: install the **restic CLI** on each PC, then `backup` to a `rest:` repository URL pointing at this host. Restic does **deduplication and encryption** client-side; the server stores opaque chunks.

This is **not** a bare-metal block image (like Clonezilla). It is a **file backup**: you choose paths (e.g. whole user profile, `C:\Users\...`, or Linux `/home`). Restores are file-oriented; OS reinstall + restore is a normal workflow.

## Before you start

1. Create **`data/`** (or set `RESTIC_DATA_DIR`) so `/data` in the container is persistent.

2. **Authentication (recommended):** create **`data/.htpasswd`** before the first `up`, or use `create_user` (see below). The published image expects a bcrypt `.htpasswd` under `/data` unless you set **`DISABLE_AUTHENTICATION`** (trusted LAN only).

   On Linux / WSL / Git Bash with Apache `htpasswd`:

   ```bash
   mkdir -p data
   htpasswd -B -c data/.htpasswd backupuser
   ```

3. `cp .env.example .env` and adjust **`REST_SERVER_PORT`**.

4. `docker compose up -d`

### Create users via container (alternative)

If the server is running with **`DISABLE_AUTHENTICATION=1`** temporarily on a trusted network:

```bash
docker compose exec rest-server create_user backupuser 'your-strong-password'
```

Then remove **`DISABLE_AUTHENTICATION`**, restart, and use that user in the `rest:` URL.

## Client: initialize repository and backup (example)

Replace `RESTIC_PASSWORD` with a **strong encryption secret** (this is **separate** from the HTTP user password). Store it in your password manager.

```bash
export RESTIC_REPOSITORY=rest:http://backupuser:HTTP_PASSWORD@homelab-host:8000/backup-pc1
export RESTIC_PASSWORD='your-repo-encryption-secret'

restic init
restic backup C:\Users\you\Documents
# Linux example: restic backup /home/you
restic snapshots
```

Use your homelab hostname or IP and the port from **`REST_SERVER_PORT`**. For **HTTPS**, terminate TLS at [Caddy](../../networking/caddy/) and point clients at the HTTPS URL (see restic docs for `rest:` with TLS).

**`--append-only`** (default in `REST_SERVER_OPTIONS`) helps protect snapshots from a compromised client deleting history; manage pruning from a trusted admin context.

## How this relates to Duplicati

**[Duplicati](../duplicati/)** in this repo is oriented toward **backing up paths the server can mount** (NAS, stack data). To back up **a PC** with Duplicati, install **Duplicati on the PC** and set the **destination** to your homelab (SFTP, SMB, S3, etc.). This stack is the **native restic** destination if you prefer the restic CLI and ecosystem.

## Security

- Treat **`RESTIC_PASSWORD`** and **HTTP credentials** as secrets.
- Do **not** expose **`REST_SERVER_PORT`** to the internet without TLS and tight access control; prefer **VPN or LAN-only**.

## Official references

- [restic](https://restic.net/) — [REST server backend](https://restic.readthedocs.io/en/latest/030_preparing_a_new_repository.html#rest-server)
- [restic/rest-server (GitHub)](https://github.com/restic/rest-server)
- [restic/rest-server (Docker Hub)](https://hub.docker.com/r/restic/rest-server)
