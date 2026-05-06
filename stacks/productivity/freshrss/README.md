# FreshRSS

[FreshRSS](https://freshrss.org/) is a self-hosted RSS aggregator and reader — keep feeds without a hosted reader or algorithmic timeline.

## Quick start

1. Copy the environment file:

   ```bash
   cp .env.example .env
   ```

2. Start:

   ```bash
   docker compose up -d
   ```

3. Open `http://localhost:8089` (or your host IP on `FRESHRSS_HTTP_PORT`) and complete the setup wizard.

4. You can use the built-in **SQLite** or point the wizard at an external **MySQL/MariaDB** (see [LinuxServer docs](https://docs.linuxserver.io/images/docker-freshrss/)).

## Data

Configuration (and default DB) lives under **`FRESHRSS_CONFIG_DIR`** → `/config` in the container.

## Official references

- [FreshRSS](https://freshrss.org/)
- [LinuxServer FreshRSS](https://docs.linuxserver.io/images/docker-freshrss/) — [linuxserver/docker-freshrss (GitHub)](https://github.com/linuxserver/docker-freshrss)
