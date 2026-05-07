# Wiki.js

**[Wiki.js](https://wiki.js.org/)** is a **collaborative wiki**: versioned pages, search, permissions, and a modern editor—useful for **household or team knowledge** that feels like a small **encyclopedia**, not a single “command center” app. Matches your research triage (**Wiki.js**, row **#135**).

### Wikipedia vs this stack

**[Wikipedia](https://www.wikipedia.org/)** runs **[MediaWiki](https://www.mediawiki.org/)**—different software, not shipped in this repo. **Wiki.js** is the **research-backed** choice here: Node.js, PostgreSQL, and a straightforward Compose layout. If you **must** have MediaWiki for extension compatibility, use upstream Docker docs or ask for a dedicated stack.

### How this differs from **[Project Nomad](../project-nomad/)**

**Nomad** is an offline **research / intelligence** workflow with upstream-specific Compose naming. **Wiki.js** is a **classic wiki** for prose, how-tos, and reference pages anyone can browse and edit with the right accounts.

## Before you start

1. `cp .env.example .env` and set **`WIKIJS_DB_PASSWORD`** (and optional **`WIKIJS_PORT`** if **3030** conflicts).

2. `docker compose up -d`

3. Open **`http://<host>:3030`** (or your **`WIKIJS_PORT`**) and complete the **setup wizard** (admin user, site title, etc.).

4. Put the site behind **[Caddy](../../networking/caddy/)** with TLS when you use a stable hostname on the LAN or over VPN.

## Backup

Persist the **`wiki-js-pgdata`** volume (PostgreSQL) and follow Wiki.js docs for **file uploads / assets** if you enable local storage beyond the DB. **[Duplicati](../../backup/duplicati/)** or **[restic](../../backup/restic-rest-server/)** on the host can cover volumes and bind mounts.

## Security

- Treat the wiki like **shared documentation**: strong admin password, least-privilege editors, **no** direct WAN exposure without reverse proxy + TLS + auth patterns you trust.

## Official references

- [Wiki.js](https://wiki.js.org/)
- [Documentation](https://docs.requarks.dev/)
- [Install — Docker](https://docs.requarks.dev/install/docker)
- [GitHub — requarks/wiki](https://github.com/requarks/wiki)
