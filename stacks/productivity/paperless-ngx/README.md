# Paperless-ngx

**[Paperless-ngx](https://docs.paperless-ngx.com/)** is a self-hosted **document archive**: ingest **PDFs**, scans, and images, run **OCR** where useful, then **search**, **tag**, and filter by correspondent or document type. It matches your research triage (**Paperless-ng** / **Paperless-ngx**, rows **#257** / **#258**).

Use it for **manuals, warranties, receipts, and office PDFs**—material that is not really a “book” collection.

### How this differs from other stacks here

| Need | Better fit |
|------|------------|
| **Fiction / ebooks / reading UX** | **[Kavita](../../media/kavita/)**, **[OpenBooks](../../media/open-ebooks/)**, etc. |
| **General cloud-style files + sync** | **[Nextcloud](../nextcloud/)**, **[Syncthing](../syncthing/)** |
| **Offline knowledge “command center”** | **[Project Nomad](../../knowledge/project-nomad/)** |
| **PDF + scan archive with search & tags** | **This stack** |

## Before you start

1. **RAM:** OCR and indexing are happier with **~2 GB free** for this stack beyond your OS baseline (more if you bulk-import huge libraries).

2. `cp .env.example .env` and set:
   - **`POSTGRES_PASSWORD`** — database password.
   - **`PAPERLESS_SECRET_KEY`** — long random secret (do **not** reuse across installs).
   - **`PAPERLESS_URL`** — exactly how you open the UI (**`http://host:port`**). Mismatched URLs commonly cause **login / CSRF** errors.

3. Optional **first login:** add **`PAPERLESS_ADMIN_USER`** and **`PAPERLESS_ADMIN_PASSWORD`** to **`.env`** **only** for the first boot on empty volumes (they are **not** listed in **`compose.yaml`**—Compose passes them through from **`.env`** when present). Log in once, then **remove those keys** from **`.env`** and restart so you are not storing an admin password in a plain file.

4. `docker compose up -d`

5. Open **`PAPERLESS_URL`** in a browser, sign in, then upload documents or drop files into **`consume/`** on the host (see **`PAPERLESS_CONSUME_DIR`**).

## Workflow tips

- **Consumption folder:** PDFs placed in **`consume/`** are picked up by the consumer process (timing depends on workload). You can also upload through the web UI and use mail ingest if you configure it upstream.
- **Tags & rules:** Use tags and matching rules so invoices, manuals, and scans sort themselves over time.
- **Backup:** Persist Docker volumes **`paperless-pgdata`**, **`paperless-data`**, **`paperless-media`** (and **`paperless-export`** if you use exports). A **[Duplicati](../../backup/duplicati/)** job or host **[restic](../../backup/restic-rest-server/)** client covering those volumes is enough for many labs.

## Security

- Treat **`8000`** as **administrator access** to your papers—keep it **LAN-only** or behind **[VPN](../../networking/wireguard/)** / **[Caddy](../../networking/caddy/)** with authentication you trust.
- **Do not** expose PostgreSQL or Redis ports; they stay on the internal Compose network by default.

## Official references

- [Paperless-ngx documentation](https://docs.paperless-ngx.com/)
- [Setup — Docker](https://docs.paperless-ngx.com/setup/#docker)
- [Configuration](https://docs.paperless-ngx.com/configuration/)
- [Paperless-ngx (GitHub)](https://github.com/paperless-ngx/paperless-ngx)
