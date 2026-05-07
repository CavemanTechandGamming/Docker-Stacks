# Development

**Source control, collaboration, and CI-adjacent tooling** you operate for yourself or a small team—Git forges, artifact registries (*when added*), and build hooks that expect a always-on server at home.

## Stacks

Stacks are listed **alphabetically** by directory name.

The **type** column summarizes the primary developer-facing surface.

| Stack | Type | Description |
|-------|------|-------------|
| [forgejo](forgejo/) | Git forge | **[Forgejo](https://forgejo.org/)** continuation of the Gitea lineage—self-hosted Git, issues, and automation hooks with default **SQLite** (`/data`) and optional **PostgreSQL** / **MySQL** migrations through documented **`FORGEJO__database__*`** variables and first-run wizard flows. |

If you add a stack here, extend the table alphabetically by folder name and follow **[docs/standards.md](../../docs/standards.md)** and **[CONTRIBUTING.md](../../CONTRIBUTING.md)**.
