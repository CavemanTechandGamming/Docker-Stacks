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

**All documentation:** **[docs/README.md](docs/README.md)** — index of guides, standards, and research notes.

**Suggested stacks:** **[docs/suggested-stacks-beginner.md](docs/suggested-stacks-beginner.md)** → **[docs/suggested-stacks-intermediate.md](docs/suggested-stacks-intermediate.md)** → **[docs/suggested-stacks-production.md](docs/suggested-stacks-production.md)** → **[docs/suggested-stacks-split-host.md](docs/suggested-stacks-split-host.md)** (multi-machine / **NUT** / UPS placement—companion to production). The first three stand alone for single-host layouts; **split-host** builds on that mental model.

## Repository layout

Stacks live under **`stacks/<category>/<stack-name>/`**. Each **category** has a **`README.md`** that lists the stacks in that group. Each **stack** normally includes **`compose.yaml`**, **`.env.example`**, and a **`README.md`** with quick start steps and **official upstream** links.

```text
.
├── LICENSE                    # MIT — repo config and docs (not upstream apps)
├── README.md
├── CONTRIBUTING.md            # PR checklist and stack additions
├── .github/
│   └── workflows/
│       └── compose-validate.yml   # CI: docker compose config --no-interpolate
├── docs/
│   ├── README.md              # documentation index (start here)
│   ├── docker-install.md
│   ├── standards.md           # compose and documentation conventions
│   ├── suggested-stacks-beginner.md
│   ├── suggested-stacks-intermediate.md
│   ├── suggested-stacks-production.md
│   ├── suggested-stacks-split-host.md   # multi-machine; after production alphabetically
│   ├── research-self-hosted-apps.md
│   └── my-active-stacks.md    # optional personal inventory template
├── stacks/
│   ├── README.md              # category index
│   ├── _template/             # copy when adding a new stack
│   └── <category>/
│       ├── README.md
│       └── <stack-name>/
│           ├── compose.yaml   # (rare: compose.yml in a few stacks)
│           ├── .env.example
│           └── README.md
└── ...
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

See **[CONTRIBUTING.md](CONTRIBUTING.md)** for pull-request expectations, how to validate Compose locally, and how to add a stack (**`stacks/_template/`**, category **`README.md`**, **`docker compose config --no-interpolate`** before commit).

## Research and planning

**[docs/research-self-hosted-apps.md](docs/research-self-hosted-apps.md)** explains how optional local triage files relate to this repo (for example a large export kept out of Git). Use it as a guide for turning research into a concrete stack under **`stacks/`**.

A personal **“what I run”** checklist (optional): **[docs/my-active-stacks.md](docs/my-active-stacks.md)**.

## License

Repository **Compose files, documentation, and supporting snippets** are licensed under the **[MIT License](LICENSE)** unless otherwise noted in a specific file.

**Container images and upstream applications** (for example Plex, Pi-hole, Ollama) remain under their **respective upstream licenses**; this repo only provides example Compose wiring. You are responsible for complying with each vendor’s terms when you run their software.
