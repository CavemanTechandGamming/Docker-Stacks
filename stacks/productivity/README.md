# Productivity

**Everyday personal or small-team tools**—files, calendars, feeds, OCR’d archives, encrypted note sync, and device-to-device replication that replace mainstream SaaS for daily workflows.

## Stacks

Stacks are listed **alphabetically** by directory name.

The **type** column summarizes the **dominant user experience**; overlaps are normal (for example **Syncthing** plus **Nextcloud** for different replication models).

| Stack | Type | Description |
|-------|------|-------------|
| [freshrss](freshrss/) | RSS reader | **FreshRSS** aggregates feeds with a self-hosted reader UI—keeps subscriptions off commercial aggregators while pairing naturally with reverse proxies (**[`networking/caddy/`](../networking/caddy/)**). |
| [joplin-server](joplin-server/) | Note sync backend | **Joplin Server** + **PostgreSQL** implements the official multi-service layout for **Joplin** clients—**`JOPLIN_BASE_URL`** must mirror the browser-facing URL or sync and admin flows break subtly. |
| [nextcloud](nextcloud/) | Personal cloud suite | **Nextcloud** (LinuxServer image + **MariaDB**) covers files, CalDAV/CardDAV, and optional apps—heavy state; plan backups (**[`backup/duplicati/`](../backup/duplicati/)**, etc.). |
| [paperless-ngx](paperless-ngx/) | Document archive | **Paperless-ngx** OCRs receipts, manuals, scans—semantic search/tag filters distinct from bookshelf readers (**[`media/kavita/`](../media/kavita/)**) or offline archives (**[`knowledge/project-nomad/`](../knowledge/project-nomad/)**). |
| [syncthing](syncthing/) | Folder replication | **Syncthing** keeps selected directories byte-identical across devices over encrypted QUIC/TCP—not snapshot backups (**[`backup/`](../backup/)**) nor centralized “drive” UX like **Nextcloud**. |

If you add a stack here, extend the table alphabetically by folder name and follow **[docs/standards.md](../../docs/standards.md)** and **[CONTRIBUTING.md](../../CONTRIBUTING.md)**.
