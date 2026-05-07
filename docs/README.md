# Documentation index

Start here for guides and conventions. Stack-specific instructions live in each **`stacks/<category>/<stack-name>/README.md`**.

## Getting started

| Document | Purpose |
|----------|---------|
| **[docker-install.md](docker-install.md)** | Install Docker Engine and Compose V2 by platform. |
| **[suggested-stacks-beginner.md](suggested-stacks-beginner.md)** | Small, low-resource starter homelab blueprint. |
| **[suggested-stacks-intermediate.md](suggested-stacks-intermediate.md)** | Fuller single-machine lab (media, sync, SMB patterns, optional AI). |
| **[suggested-stacks-production.md](suggested-stacks-production.md)** | Workstation / server–grade breadth (observability, backups, UPS, more AI). |
| **[suggested-stacks-split-host.md](suggested-stacks-split-host.md)** | Multi-machine homelab: **NUT** / UPS placement (e.g. Raspberry Pi), low- vs high-power roles, DNS and backups across hosts—**companion** to production. |

The **beginner**, **intermediate**, and **production** guides are written to stand alone for **single-host** planning. **Split-host** assumes that baseline and focuses on **which PC runs what**; read it after production when you split workloads across machines.

## Maintaining stacks and the repo

| Document | Purpose |
|----------|---------|
| **[standards.md](standards.md)** | Compose layout, env files, networking, and operations expectations for new stacks. |
| **[CONTRIBUTING.md](../CONTRIBUTING.md)** | How to contribute stacks or docs; validation commands before opening a PR. |
| **[research-self-hosted-apps.md](research-self-hosted-apps.md)** | How research / triage notes relate to adding stacks (including optional local exports kept out of Git). |

## Optional / personal

| Document | Purpose |
|----------|---------|
| **[my-active-stacks.md](my-active-stacks.md)** | Example **“what I actually run”** inventory. Treat it as a **personal checklist template**—not a required architecture for users of this repo. Forks may replace it with their own hosts or delete it. |

Some maintainers keep private planning files under **`docs/`** that are **gitignored** (see the repo **`.gitignore`**). Those files are intentionally not part of the shared documentation set.

---

Back to the repository overview: **[../README.md](../README.md)**.
