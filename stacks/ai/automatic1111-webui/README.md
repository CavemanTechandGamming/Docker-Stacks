# AUTOMATIC1111 Stable Diffusion WebUI

Browser UI for [AUTOMATIC1111/stable-diffusion-webui](https://github.com/AUTOMATIC1111/stable-diffusion-webui), using the community image [universonic/stable-diffusion-webui](https://hub.docker.com/r/universonic/stable-diffusion-webui) (NVIDIA-oriented; see upstream image docs for tags such as `latest`, `minimal`, and `full`).

## What this stack includes

- One service that serves the WebUI on port **8080** (configurable).
- Bind mounts for models, outputs, extensions, and related folders next to `compose.yaml`.

## Quick start

1. Copy the environment template:

   ```bash
   cp .env.example .env
   ```

2. Place at least one Stable Diffusion checkpoint under **`models/Stable-diffusion/`** on the host (the WebUI will not stay up without a model in that path).

3. Start:

   ```bash
   docker compose up -d
   ```

4. Open `http://localhost:8080` (or the host and port you set in `.env`).

## GPU

- **Linux + NVIDIA:** Install the [NVIDIA Container Toolkit](https://docs.nvidia.com/datacenter/cloud-native/container-toolkit/latest/install-guide.html), then uncomment `gpus: all` in `compose.yaml`.
- **Windows:** GPU passthrough typically goes through Docker Desktop + WSL2; validate with NVIDIA’s current Docker Desktop guidance. This image is aimed at NVIDIA GPUs.
- **CPU-only:** This image is not a practical default for CPU inference; consider ComfyUI with a CPU-oriented image or a different workflow.

## Low VRAM

If you use the `minimal` image tag, the image maintainer suggests extra flags (see Docker Hub README). You can add a `command:` line to the service in `compose.yaml`, for example:

`command: ["--no-half", "--no-half-vae", "--precision", "full"]`

(Adjust to match how the image invokes the WebUI; confirm with `docker inspect` or the image README if startup fails.)

## Alternative: build-based compose

The [AUTOMATIC1111 wiki “Containers”](https://github.com/AUTOMATIC1111/stable-diffusion-webui/wiki/Containers) lists other Docker approaches (for example compose that builds from profiles). Use those if you prefer an upstream-aligned build instead of a prebuilt Hub image.

## Official references

- [AUTOMATIC1111/stable-diffusion-webui](https://github.com/AUTOMATIC1111/stable-diffusion-webui) — [Wiki](https://github.com/AUTOMATIC1111/stable-diffusion-webui/wiki)
- [universonic/stable-diffusion-webui (Docker Hub)](https://hub.docker.com/r/universonic/stable-diffusion-webui)
