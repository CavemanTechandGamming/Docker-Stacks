# Open Books (ebooks)

This stack runs **[OpenBooks](https://github.com/evan-buss/openbooks)** — a self-hosted web app that searches and downloads eBooks via IRC (**Irchighway `#ebook`**). It is **not** a Calibre-style library manager; it is a bridge to that IRC channel.

## Research note (`research-self-hosted-apps.local.md` row 224)

Your triage file lists **OpenEBOOKS** with image `openebooks/openebooks` and [github.com/OpenEbooks/OpenEbooks](https://github.com/OpenEbooks/OpenEbooks). That repository and Docker image are **not available** (404 as of this writing), so this stack uses **OpenBooks** (`evanbuss/openbooks`) — a different, maintained project with a similar “open + books” role.

For a **local EPUB library + reader**, see **[Kavita](../kavita/)** or **[Calibre-Web](https://github.com/janeczku/calibre-web)** (also named in the same research table).

## Quick start

1. `cp .env.example .env` and set **`OPENBOOKS_IRC_NAME`** to a unique IRC username (required).

2. `docker compose up -d`

3. Open **http://localhost:8080** (or `OPENBOOKS_PORT`).

4. Read [OpenBooks Docker](https://evan-buss.github.io/openbooks/setup/docker/) and [configuration](https://evan-buss.github.io/openbooks/configuration/) for `BASE_PATH`, TLS behind a proxy, and behavior.

## Legal / ethics

Only use OpenBooks in line with IRC network rules and copyright law in your jurisdiction.

## Official references

- [OpenBooks](https://evan-buss.github.io/openbooks/)
- [evan-buss/openbooks (GitHub)](https://github.com/evan-buss/openbooks)
- [evanbuss/openbooks (Docker Hub)](https://hub.docker.com/r/evanbuss/openbooks)
