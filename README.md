# Docker Stacks

A curated collection of production-minded Docker Compose stacks for self-hosting and small team environments.

This repository is designed for personal use and sharing with friends, while maintaining professional standards in structure, documentation, and operational safety.

## Install Docker

You need **Docker** with the **Compose V2** CLI (`docker compose`, not the legacy `docker-compose` standalone binary).

| Step | Action |
|------|--------|
| 1 | Download and install using Docker’s official guides: **[Get Docker](https://docs.docker.com/get-docker/)** |
| 2 | On **Windows** or **macOS**, use **[Docker Desktop](https://www.docker.com/products/docker-desktop/)** (installs Engine and Compose together) |
| 3 | On **Linux**, install **[Docker Engine](https://docs.docker.com/engine/install/)** and the **[Compose plugin](https://docs.docker.com/compose/install/linux/)** |
| 4 | Confirm in a terminal: `docker version` and `docker compose version` |

For a concise platform-by-platform walkthrough, see **[docs/docker-install.md](docs/docker-install.md)**.

## Goals

- Keep stacks easy to run and easy to maintain.
- Use clear, consistent Compose conventions.
- Favor secure defaults where practical.
- Make onboarding simple for non-experts.

## Repository Structure

Stacks live under **`stacks/<category>/<stack-name>/`** (see [`stacks/README.md`](stacks/README.md) for categories). Each category folder includes a **`README.md`** that explains what belongs there (folders usually list above that file in directory views).

```text
.
|-- stacks/
|   |-- README.md           # index of categories
|   |-- _template/
|   |   |-- compose.yaml
|   |   `-- .env.example
|   |-- <category>/         # e.g. media/, networking/, backup/
|   |   |-- README.md       # what belongs in this category
|   |   `-- <stack-name>/
|   |       |-- compose.yaml
|   |       `-- .env.example
|-- docs/
|   |-- docker-install.md
|   `-- standards.md
`-- README.md
```

## Quick Start

1. Clone the repository.
2. Copy a stack template or choose an existing stack under `stacks/<category>/`.
3. Duplicate `.env.example` to `.env` and customize values.
4. Start the stack from its folder:

```bash
docker compose up -d
```

5. Check service health and logs:

```bash
docker compose ps
docker compose logs -f
```

## Compose Standards

Each stack should follow these baseline practices:

- Use `compose.yaml` as the primary filename.
- Keep service names explicit and stable.
- Define persistent volumes intentionally.
- Avoid hardcoded secrets in Compose files.
- Use `.env.example` to document required configuration.
- Add `healthcheck` where appropriate.
- Add restart policies for long-running services.
- Pin image tags where stability matters.

See `docs/standards.md` for detailed guidance.

## Security Notes

- Never commit real secrets or private keys.
- Review published ports and expose only what is needed.
- Prefer internal Docker networks for service-to-service traffic.
- Keep container images updated and track breaking changes.

## Contributing (Friends Welcome)

If you add a stack:

1. Start from `stacks/_template/`.
2. Add the new stack under the best-fitting **`stacks/<category>/`** folder; update that category’s `README.md` with a link to the new stack.
3. Keep names and file layout consistent.
4. Include a short stack-specific README if setup is non-trivial, with an **Official references** section linking the upstream project repo (and website/docs where helpful).
5. Verify startup with `docker compose config` before committing.

Each stack folder includes a `README.md` that points to the **official upstream** projects (and third-party write-ups only when useful, e.g. Project Nomad).

## Roadmap

- Add core starter stacks (reverse proxy, monitoring, media, automation).
- Add backup and restore patterns.
- Add CI checks for Compose validation.

