# ComfyUI

[ComfyUI](https://github.com/comfyanonymous/ComfyUI) in Docker using the [ai-dock/comfyui](https://github.com/ai-dock/comfyui) image (configurable CUDA / ROCm / CPU tags on [GHCR](https://github.com/ai-dock/comfyui/pkgs/container/comfyui)).

## What this stack includes

- One service exposing the ComfyUI web UI (default **8188**).
- A **`workspace`** bind mount for models, custom nodes, and user data (standard ComfyUI layout under that tree).

Images do **not** bundle checkpoints or third-party models; add files under `workspace` or use ComfyUI / external tooling to download them.

## Quick start

1. Copy the environment template:

   ```bash
   cp .env.example .env
   ```

2. Start:

   ```bash
   docker compose up -d
   ```

3. Open `http://localhost:8188` (or the port set in `.env`).

## GPU and image tags

- **NVIDIA (typical):** use a CUDA tag (the default `latest` points at a CUDA build per upstream README). On Linux, install the [NVIDIA Container Toolkit](https://docs.nvidia.com/datacenter/cloud-native/container-toolkit/latest/install-guide.html) and uncomment `gpus: all` in `compose.yaml`.
- **AMD ROCm / CPU:** pick an image tag from the [ai-dock ComfyUI README](https://github.com/ai-dock/comfyui/blob/main/README.md) (ROCm and CPU patterns are documented there) and set `COMFYUI_IMAGE` in `.env`.

## Auth and extra services

The ai-dock base image can enable a web auth gate (`WEB_ENABLE_AUTH`). This compose defaults it to **false** for simple homelab LAN use; set `WEB_USER`, `WEB_PASSWORD`, and `WEB_ENABLE_AUTH=true` if you expose the UI beyond a trusted network.

The full upstream project’s `docker-compose.yaml` also exposes SSH, Jupyter, Syncthing, and a service portal. This stack only maps **ComfyUI’s port** to keep the footprint small; see the [ai-dock base wiki](https://github.com/ai-dock/base-image/wiki) if you need those services.

## Official references

- [comfyanonymous/ComfyUI](https://github.com/comfyanonymous/ComfyUI)
- [ai-dock/comfyui](https://github.com/ai-dock/comfyui) — [Environment variables](https://github.com/ai-dock/comfyui/blob/main/README.md#additional-environment-variables)
