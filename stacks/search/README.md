# Search

**Self-hosted search and meta-search**: reduce dependence on single ad-heavy providers by aggregating engine results you control—often paired with **`networking/caddy/`** TLS and **`allowlist`** style access policies.

## Stacks

Stacks are listed **alphabetically** by directory name.

The **type** column is a concise workload label—meta‑search, proxied single‑engine UIs, and full indexers can coexist here.

| Stack | Type | Description |
|-------|------|-------------|
| [searxng](searxng/) | Meta-search | **SearXNG** relays queries across many backends while withholding persistent profiling—requires accurate **`SEARXNG_BASE_URL`** in **`.env`** so generated links remain consistent. |
| [whoogle](whoogle/) | Google proxy UI | **Whoogle** renders a Google‑like experience by proxying Google HTML—convenient but can break when markup or bot checks change; hardened defaults align with upstream (`user`, `tmpfs`, `cap_drop`). |
| [yacy](yacy/) | Distributed index | **YaCy** crawls and indexes as a self‑hosted search node (optional P2P peers); ships with default **`admin` / `yacy`** credentials you must change before any wide exposure. |

If you add a stack here, extend the table alphabetically by folder name and follow **[docs/standards.md](../../docs/standards.md)** and **[CONTRIBUTING.md](../../CONTRIBUTING.md)**.
