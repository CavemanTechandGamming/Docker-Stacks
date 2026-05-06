# Docker Stacks

A curated set of **Docker Compose** stacks for self-hosting: homelab services, media, backups, local AI, and edge networking. Layout and docs are meant to be easy to adopt on a fresh clone and safe to share with a small team or friends.

## Prerequisites

You need **Docker Engine** and the **Compose V2** plugin (`docker compose`). The legacy standalone `docker-compose` binary is not assumed.

| Step | Action |
|------|--------|
| 1 | Follow Docker’s **[Get Docker](https://docs.docker.com/get-docker/)** overview for your platform. |
| 2 | On **Windows** or **macOS**, **[Docker Desktop](https://www.docker.com/products/docker-desktop/)** bundles Engine and Compose. |
| 3 | On **Linux**, install **[Docker Engine](https://docs.docker.com/engine/install/)** and the **[Compose plugin](https://docs.docker.com/compose/install/linux/)**. |
| 4 | Confirm: `docker version` and `docker compose version`. |

A shorter, platform-oriented walkthrough lives in **[docs/docker-install.md](docs/docker-install.md)**.

## Repository layout

Stacks live under **`stacks/<category>/<stack-name>/`**. Each **category** has a **`README.md`** that lists the stacks in that group. Each **stack** normally includes **`compose.yaml`**, **`.env.example`**, and a **`README.md`** with quick start steps and **official upstream** links.

```text
.
├── stacks/
│   ├── README.md              # category index
│   ├── _template/             # copy when adding a new stack
│   └── <category>/
│       ├── README.md
│       └── <stack-name>/
│           ├── compose.yaml
│           ├── .env.example
│           └── README.md
├── docs/
│   ├── docker-install.md
│   ├── standards.md           # compose and documentation conventions
│   └── research-self-hosted-apps.md  # how triage notes relate to stacks
└── README.md
```

For the full category table (AI, media, networking, backup, and so on), see **[stacks/README.md](stacks/README.md)**.

## Quick start

1. Clone this repository.
2. Open the stack you want under **`stacks/<category>/<stack-name>/`**.
3. Copy **`.env.example`** to **`.env`** and edit values (never commit real secrets; `.env` is ignored by default).
4. From that stack directory:

   ```bash
   docker compose up -d
   ```

5. Inspect status and logs:

   ```bash
   docker compose ps
   docker compose logs -f
   ```

Some stacks assume a **Linux** host or specific hardware (for example VPN or GPU services). Always read the stack’s **`README.md`** before exposing ports to the internet.

## Design goals

- **Predictable layout** — same filenames and patterns from stack to stack.
- **Sensible defaults** — restart policies, documented env vars, clear ports and volumes.
- **Upstream-first docs** — each stack README links to official projects and install guides.
- **Operational clarity** — when a stack only fits certain hosts (Pi, NVIDIA, LAN-only), that is called out in the stack README.

## Compose conventions

Baseline expectations for stacks in this repo:

- Primary Compose filename: **`compose.yaml`**.
- Stable service names; intentional volumes and port mappings.
- No committed secrets; use **`.env.example`** as the contract for configuration.
- **`restart: unless-stopped`** (or equivalent) for long-running services where it makes sense.
- Pin image tags when you care about reproducible upgrades.

Details: **[docs/standards.md](docs/standards.md)**.

## Security

- Treat **`.env`**, VPN keys, and app data directories as sensitive; they are gitignored where bind mounts would otherwise pollute commits.
- Expose only the ports you need; prefer a reverse proxy and TLS at the edge for browser-facing services.
- Keep images updated and read upstream release notes before major tag bumps.

## Contributing

To add or extend a stack:

1. Start from **`stacks/_template/`**.
2. Place the new folder under the appropriate **`stacks/<category>/`** and add a bullet link in that category’s **`README.md`**.
3. Include a stack **`README.md`** with quick start, host requirements, and an **Official references** section.
4. Run **`docker compose config`** in the stack directory before committing.

## Research and planning

**[docs/research-self-hosted-apps.md](docs/research-self-hosted-apps.md)** explains how optional local triage files relate to this repo (for example a large export kept out of Git). Use it as a guide for turning research into a concrete stack under **`stacks/`**.
