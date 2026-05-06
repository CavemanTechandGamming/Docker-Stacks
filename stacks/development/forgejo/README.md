# Forgejo

[Forgejo](https://forgejo.org/) is a self-hosted Git forge (community continuation of Gitea). You own repos, issues, and CI hooks without GitHub/GitLab.

This stack uses **SQLite** in `/data` for a simple homelab default. You can switch to **PostgreSQL** or **MySQL** from the install wizard or by adjusting `FORGEJO__database__*` variables (see [Forgejo configuration](https://forgejo.org/docs/latest/admin/config-cheat-sheet/)).

## Quick start

1. Copy the environment file and set **`FORGEJO_ROOT_URL`** to the URL you will use in the browser (must match how clients reach the server).

   ```bash
   cp .env.example .env
   ```

2. Start:

   ```bash
   docker compose up -d
   ```

3. Open `FORGEJO_ROOT_URL`, complete the first-run wizard.

4. **Git over SSH:** use port **`FORGEJO_SSH_PORT`** on the host (default `3022`), e.g.  
   `git clone ssh://git@your-host:3022/user/repo.git`

## Data

State lives in the **`forgejo-data`** volume (`/data` in the container). Back it up with [Duplicati](../../backup/duplicati/) or your usual method.

## Reverse proxy

Terminate TLS at [Caddy](../../networking/caddy/) and set `FORGEJO_ROOT_URL` to your HTTPS URL.

## Official references

- [Forgejo](https://forgejo.org/)
- [Forgejo documentation](https://forgejo.org/docs/latest/)
- [Container / installation](https://forgejo.org/docs/latest/admin/installation/) — image: [forgejo/forgejo (Docker Hub)](https://hub.docker.com/r/forgejo/forgejo)
