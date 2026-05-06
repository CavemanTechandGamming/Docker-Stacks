# Docker Stack Standards

These standards keep stacks understandable, safer, and easier to support over time.

## File Conventions

- Place each stack at **`stacks/<category>/<stack-name>/`** and document it in that category’s **`README.md`** (see [`stacks/README.md`](../stacks/README.md)).
- Use `compose.yaml` (not `docker-compose.yml`).
- Include `.env.example` in every stack directory.
- Do not commit live `.env` files.
- Add stack-specific `README.md` when setup is not obvious.

## Compose Design

- Use explicit service names.
- Prefer named volumes for persistence.
- Use dedicated networks for multi-service stacks.
- Define `restart` policy (`unless-stopped` is preferred default).
- Add `healthcheck` for critical services.
- Keep `container_name` optional unless operationally required.

## Configuration and Secrets

- Store runtime settings in `.env`.
- Keep secrets out of Compose files and Git history.
- Use secrets managers or external files when possible.
- Document required variables in `.env.example`.

## Images and Versioning

- Pin image tags (avoid `latest` for critical workloads).
- Upgrade images intentionally and test before rollout.
- Record notable version constraints in stack docs.

## Networking and Exposure

- Publish only required ports.
- Keep internal traffic on private Docker networks.
- Prefer reverse proxy routing for HTTP services.
- Avoid exposing admin interfaces directly to the internet.

## Operations

- Validate configuration before run:

  ```bash
  docker compose config
  ```

- Use `docker compose pull` before planned updates.
- Review logs and health before marking a stack stable.
- Include backup and restore notes for stateful services.
