# Whoogle Search

[Whoogle Search](https://github.com/benbusby/whoogle-search) is a **Google‑style frontend** backed by scraped Google HTML—useful when you want familiar results layout without handing queries to a giant search UI, at the cost of **fragility** whenever Google markup or bot checks change upstream.

## Quick start

1. Copy the environment template (**`.env.example`** → **`.env`**). All values are optional for a quick local trial.

   ```bash
   cp .env.example .env
   ```

2. Start:

   ```bash
   docker compose up -d
   ```

3. Open **`http://localhost:5000`** unless you changed **`WHOOGLE_PUBLISH_PORT`** in **`.env`**.

## Operational notes

- **Breakage:** If results fail or degrade, check [project issues](https://github.com/benbusby/whoogle-search/issues)—this class of proxy tends to need updates when targets change.
- **Linux‑oriented Compose:** **`user`**, **`tmpfs`**, and **`cap_drop`** match upstream hardened defaults and assume a normal Linux daemon. Behavior on exotic Docker backends may differ—remove or tweak only if you understand the tradeoffs.
- **`WHOOGLE_DOTENV=1`** in **`.env`** enables loading extra variables documented upstream (alternate frontends for Twitter, Reddit, etc.).
- **Reverse proxy:** place [Caddy](../../networking/caddy/) in front; consider optional **`WHOOGLE_USER`** / **`WHOOGLE_PASS`** for basic auth behind the proxy.

## Official references

- [benbusby/whoogle-search (GitHub)](https://github.com/benbusby/whoogle-search)
- [Docker Hub — benbusby/whoogle-search](https://hub.docker.com/r/benbusby/whoogle-search)
