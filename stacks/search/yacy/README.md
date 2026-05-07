# YaCy

[YaCy](https://yacy.net/) is a **distributed search engine**: self‑hosted crawling and indexing that can participate in a peer network, complementing aggregator stacks like **[SearXNG](../searxng/)**.

## Quick start

1. Copy **`env`**:

   ```bash
   cp .env.example .env
   ```

2. Start:

   ```bash
   docker compose up -d
   ```

3. Open **`http://localhost:8090`** by default (**`YACY_PUBLISH_HTTP`** in **`.env`**). HTTPS is available from the container on **`8443`** (host mapping **`YACY_PUBLISH_HTTPS`**)—often you terminate TLS at a reverse proxy instead.

## Security

- Default web admin is **`admin` / `yacy`** until you change it in **`/ConfigAccounts_p.html`**—**do not** expose the UI to the Internet with defaults.
- Prefer [Caddy](../../networking/caddy/) or another reverse proxy with TLS and access controls; optionally stop publishing **`8443`** on the host if you terminate TLS at the proxy.

## Persistence and resources

- Data lives in Docker volume **`yacy-data`** at **`/opt/yacy_search_server/DATA`** (matches upstream Dockerfile layout).
- Indexing can be JVM‑heavy—watch memory on small hosts after large crawls.

## Official references

- [YaCy homepage](https://yacy.net/)
- [Docker image README (GitHub)](https://github.com/yacy/yacy_search_server/blob/master/docker/README.md)
- [Docker Hub — yacy/yacy_search_server](https://hub.docker.com/r/yacy/yacy_search_server)
