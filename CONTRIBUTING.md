# Contributing

Thanks for helping improve this repository. The goal is predictable **Compose** layouts and **upstream-first** documentation.

## Before you open a pull request

1. Read **[docs/standards.md](docs/standards.md)** — file names, Compose patterns, secrets, networking.
2. From the stack directory you changed, run:

   ```bash
   docker compose config --no-interpolate
   ```

   That checks that the Compose file resolves without requiring real secrets in CI. For a full local check with your own values, copy **`.env.example`** → **`.env`**, fill in variables, then run **`docker compose config`** (without `--no-interpolate`).

3. Do **not** commit **`.env`**, keys, or bind-mounted app data covered by **[`.gitignore`](.gitignore)**.

## Adding a new stack

1. Copy **`stacks/_template/`** into **`stacks/<category>/<new-stack-name>/`** (pick the category from **[stacks/README.md](stacks/README.md)**).
2. Add a bullet link to the new stack in that category’s **`README.md`**.
3. Ship **`compose.yaml`** (see standards — **exception** only when upstream tooling requires another filename, documented in the stack **README.md**).
4. Ship **`.env.example`** listing every variable operators must set, with safe placeholders.
5. Ship **`README.md`** with quick start, host constraints (OS, GPU, LAN-only, etc.), and **Official references** pointing at upstream projects.

## Documentation only changes

Edits under **`docs/`** should stay accurate relative to **`stacks/`**—when you add or rename a stack, update indexes (**[docs/README.md](docs/README.md)**, **[README.md](README.md)**) if readers would expect to find it there.

## Questions

Open an issue with the stack name and host OS if something in **standards** conflicts with upstream; exceptions belong in **standards** and the stack README, not one-off undocumented shortcuts.
