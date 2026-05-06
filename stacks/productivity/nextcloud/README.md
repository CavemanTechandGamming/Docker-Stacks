# Nextcloud

[Nextcloud](https://nextcloud.com/) for files, calendar, contacts, and more — typical “own your cloud” replacement for big-tech sync.

This stack uses [LinuxServer.io Nextcloud](https://docs.linuxserver.io/images/docker-nextcloud/) plus **MariaDB** (recommended over SQLite for normal use).

## Quick start

1. Copy the environment file and set **strong** database passwords:

   ```bash
   cp .env.example .env
   ```

2. Start:

   ```bash
   docker compose up -d
   ```

3. Open **`https://<host>:4443`** (or whatever you set for `NEXTCLOUD_HTTPS_PORT`).  
   The image uses a **self-signed** certificate by default; your browser will warn you until you trust it or terminate TLS at [Caddy](../../networking/caddy/).

4. On the **first-run** setup screen, use database type **MySQL/MariaDB** and:

   | Field | Value |
   |------|--------|
   | Database host | `db` |
   | Database name | `nextcloud` (or `MYSQL_DATABASE` from `.env`) |
   | Database user | `nextcloud` (or `MYSQL_USER`) |
   | Database password | same as `MYSQL_PASSWORD` in `.env` |

5. Create the admin account and finish the wizard.

## Data

Docker volumes: **`nextcloud-config`**, **`nextcloud-data`**, **`nextcloud-db`**. Include them in [Duplicati](../../backup/duplicati/) or your backup plan.

## Reverse proxy (Caddy)

Put Nextcloud behind Caddy with your real hostname; see [LinuxServer strict proxies FAQ](https://docs.linuxserver.io/faq#strict-proxy) if the proxy validates upstream TLS. You may point Caddy at `https://nextcloud:443` with `tls_insecure_skip_verify` only on a trusted LAN — prefer fixing trust properly per LS docs.

## Optional: Redis

For larger installs, add a `redis` service and configure caching in Nextcloud (`config.php` or admin settings). Omitted here to keep the stack small.

## Official references

- [Nextcloud](https://nextcloud.com/)
- [Nextcloud admin manual](https://docs.nextcloud.com/server/latest/admin_manual/)
- [LinuxServer Nextcloud](https://docs.linuxserver.io/images/docker-nextcloud/) — [linuxserver/docker-nextcloud (GitHub)](https://github.com/linuxserver/docker-nextcloud)
- [MariaDB](https://mariadb.org/) — [mariadb/server (Docker Hub)](https://hub.docker.com/_/mariadb)
