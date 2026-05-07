# Knowledge

**Reference libraries and publishing stacks** you browse or search as curated knowledge—wikis, structured documentation, and upstream “command center” bundles.

**Personal note sync** (Joplin apps) belongs under **[`productivity/`](../productivity/)** (see **[`joplin-server/`](../productivity/joplin-server/)**), not here.

## Stacks

Stacks are listed **alphabetically** by directory name.

The **type** column is a **high-level workload label**. **Wiki.js** offers classic multi-editor wikis while **Project Nomad** orchestrates a broader offline toolkit set.

| Stack | Type | Description |
|-------|------|-------------|
| [project-nomad](project-nomad/) | Offline knowledge suite | **Project N.O.M.A.D.** Command Center plus satellite services (Kiwix, Kolibri, optional Ollama stacks, etc.) with **Docker socket** access—Linux/WSL-oriented, high privilege; upstream retains **`compose.yml`** filename by design. |
| [wiki-js](wiki-js/) | Collaborative wiki | **Wiki.js** pairs **Node.js** + **PostgreSQL** for versioned pages, permissions, and polished editing—suited to household or team runbooks rather than Nomad’s bundled offline archive story. |

If you add a stack here, extend the table alphabetically by folder name and follow **[docs/standards.md](../../docs/standards.md)** and **[CONTRIBUTING.md](../../CONTRIBUTING.md)**.
