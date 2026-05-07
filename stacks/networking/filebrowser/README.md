# File Browser

**[File Browser](https://filebrowser.org/)** is a small **web file manager**: browse directories under a single **root**, upload/download, share links, and manage users—without standing up a full **[Nextcloud](../../productivity/nextcloud/)** stack. Matches your research triage (**File Browser** / **FileBrowser**, rows **#50** / **#51**).

Use it when you want a **quick LAN portal** to a specific folder tree (dump disk, ISO stash, share tree).

## Before you start

1. Create **`srv/`** (or set **`FILEBROWSER_ROOT`**) with the files you intend to expose.

2. `cp .env.example .env`

3. `docker compose up -d`

4. Open **`http://<host>:<FILEBROWSER_PORT>`** — **first launch prompts you to set an admin user** (stored in the **`filebrowser-db`** Docker volume).

## Relationship to other stacks

| Stack | When to prefer it |
|-------|-------------------|
| **File Browser** | One lightweight root, minimal setup. |
| **[Nextcloud](../../productivity/nextcloud/)** | Sync, group folders, office integrations. |
| **[SFTPGo](../sftpgo/)** | SFTP/WebDAV-first workflows and multi-protocol servers. |

## Security

- Assume **everyone who can reach the UI can read/write whatever sits under **`FILEBROWSER_ROOT`**** once logged in—keep it **LAN-only** or behind **[VPN](../wireguard/)** / **[Caddy](../caddy/)** with strong auth.

## Official references

- [File Browser](https://filebrowser.org/)
- [GitHub — filebrowser/filebrowser](https://github.com/filebrowser/filebrowser)
- [Docker Hub — filebrowser/filebrowser](https://hub.docker.com/r/filebrowser/filebrowser)
