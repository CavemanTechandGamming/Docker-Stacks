# SFTPGo

**[SFTPGo](https://github.com/drakkan/sftpgo)** bundles **SFTP**, **FTPS**, **WebDAV**, optional **HTTP(S)** file serving, and a **web admin UI** for users, folders, and quotas—without handing everything to a full suite like **[Nextcloud](../../productivity/nextcloud/)**. Matches your research triage (**SFTPGo**, row **#70**).

Typical uses: **backup destinations** (Duplicati SFTP, `rsync`-adjacent workflows), controlled shares for **one vendor or subnet**, or **WebDAV** mounts where SMB is awkward.

## Before you start

1. `mkdir -p lib srv` next to **`compose.yaml`** (or point **`SFTPGO_*_DIR`** elsewhere).

2. `cp .env.example .env` — set **`SFTPGO_ADMIN_USERNAME`** / **`SFTPGO_ADMIN_PASSWORD`** before **first** **`up`** (SFTPGo seeds the admin only when the data dir is empty).

3. `docker compose up -d`

4. Open **`http://<host>:<SFTPGO_WEB_PORT>`** — define virtual folders that map into **`/srv/sftpgo`** inside the container (same tree as **`./srv`** on the host).

## Ports

| Port | Role |
|------|------|
| **SFTPGO_WEB_PORT** (default **8089**) | Admin UI + HTTP/S features if enabled in SFTPGo |
| **SFTPGO_SFTP_PORT** (default **2022**) | SFTP (`sftp -P 2022 user@host`) |

Additional bindings (**FTP**, **WebDAV**, etc.) are configured from the UI or SFTPGo docs—not duplicated here so this Compose file stays small.

## Security

- Treat the **admin UI** like infrastructure: **LAN / VPN** only unless fronted by **[Caddy](../caddy/)** with auth you trust.
- Prefer **per-user** credentials and **chrooted** virtual folders over sharing root passwords.

## Official references

- [SFTPGo](https://github.com/drakkan/sftpgo)
- [SFTPGo documentation](https://docs.sftpgo.com/)
- [Docker Hub — drakkan/sftpgo](https://hub.docker.com/r/drakkan/sftpgo)
