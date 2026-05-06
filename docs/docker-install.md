# Install Docker

This repository assumes a working **Docker Engine** and the **Docker Compose V2 plugin** (`docker compose`). All links below point to Docker’s own documentation and download pages so you always get current install steps.

## Official resources

- **Overview (all platforms):** [Get Docker](https://docs.docker.com/get-docker/)
- **Docker Desktop (Windows and macOS):** [Docker Desktop](https://www.docker.com/products/docker-desktop/)
- **Linux (Engine only):** [Install Docker Engine](https://docs.docker.com/engine/install/)
- **Compose:** [Install the Compose plugin](https://docs.docker.com/compose/install/linux/) (Linux); Docker Desktop includes Compose.

---

## Windows

1. Confirm your edition: **Windows 10/11 64-bit** with WSL 2 enabled is the supported path for [Docker Desktop on Windows](https://docs.docker.com/desktop/setup/install/windows-install/).
2. Install **WSL 2** if you have not already ([Microsoft’s WSL guide](https://learn.microsoft.com/en-us/windows/wsl/install)).
3. Download and install **Docker Desktop** from [Docker Desktop for Windows](https://docs.docker.com/desktop/setup/install/windows-install/).
4. Start Docker Desktop and wait until it reports that the engine is running.
5. Open PowerShell or your preferred terminal and verify:

   ```powershell
   docker version
   docker compose version
   ```

If you use this repo from WSL, run the same commands inside your Linux distribution so the CLI talks to the same Docker context.

---

## macOS

1. Download **Docker Desktop for Mac** from [Docker Desktop for Mac](https://docs.docker.com/desktop/setup/install/mac-install/) (choose the correct chip: Apple Silicon or Intel).
2. Open the `.dmg`, drag Docker to Applications, launch Docker Desktop, and complete the first-run prompts.
3. Verify in Terminal:

   ```bash
   docker version
   docker compose version
   ```

---

## Linux (Docker Engine + Compose plugin)

Docker does not mandate a single command for every distribution. Use the page that matches your distro:

1. Open [Install Docker Engine](https://docs.docker.com/engine/install/) and select **your distribution** (Ubuntu, Debian, Fedora, etc.).
2. Follow Docker’s steps to install the **Engine** and enable the service.
3. Install the **Compose plugin** using [Install the Docker Compose plugin](https://docs.docker.com/compose/install/linux/) for your package manager.
4. Add your user to the `docker` group if you want to run Docker without `sudo` (log out and back in after):

   ```bash
   sudo usermod -aG docker "$USER"
   ```

5. Verify:

   ```bash
   docker version
   docker compose version
   ```

---

## After installation

- **Context:** If you use multiple Docker hosts, check `docker context ls` and [Manage contexts](https://docs.docker.com/engine/reference/commandline/context/).
- **Updates:** Keep Docker Desktop or Docker Engine updated from Docker’s official channels.
- **Next:** Clone this repo, open a stack under `stacks/<category>/<stack-name>/`, copy `.env.example` to `.env`, and run `docker compose up -d` from that stack directory (see the main [README](../README.md) and [`stacks/README.md`](../stacks/README.md)).
