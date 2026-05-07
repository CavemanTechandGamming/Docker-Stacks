# Stack template

Copy this folder when adding a stack under **`stacks/<category>/`** (see [`../README.md`](../README.md)). Preserve upstream-required filenames when their tooling hard-codes paths (for example **`compose.yml`** for Project Nomad—document the reason).

Each new stack ships **`compose.yaml`** (unless upstream forbids renaming), **`.env.example`**, and a focused **`README.md`** with upstream links under **Official references**.

When registering the stack, update that category’s **`README.md`** using the repo-wide blueprint:

- Stacks listed **alphabetically** by directory name  
- **`| Stack | Type | Description |`** table mirroring **`stacks/ai/README.md`**  
- Short **type** label plus one professional sentence for **description**  
- Footer reminding contributors about **`docker compose config --no-interpolate`**

This template’s **`README.md`** is instructional only—replace it wholesale when you instantiate a real service.

## Official references

- [Docker Compose documentation](https://docs.docker.com/compose/)
- [Compose specification (GitHub)](https://github.com/compose-spec/compose-spec)
