# FileFlows

[FileFlows](https://fileflows.com/) automates file-processing pipelines (video transcodes, audio, images, ebooks, and more) with optional hardware acceleration. Official Docker guidance and a **Compose generator** live in the [FileFlows Docker documentation](https://fileflows.com/docs/installation/docker).

## Layout

| Path | Container path | Purpose |
|------|----------------|---------|
| `data` (default) | `/app/Data` | Database, config, plugins — **back this up** ([upgrade / backup notes](https://fileflows.com/docs/installation/upgrades)) |
| `temp` (default) | `/temp` | Working temp for flow runs; use a fast drive |
| `media` (default) | `/media` | Default **Browser Start Directory** in the web file picker |
| `dockermods` (default) | `/app/DockerMods` | Persist [DockerMods](https://fileflows.com/docs/webconsole/config/extensions/dockermods) across recreates |

The container also mounts **`/var/run/docker.sock`** read-only, as required by upstream for Docker-based features.

## Quick start

1. Copy **`.env.example`** → **`.env`** and set **`FILEFLOWS_TEMP_DIR`** (and optionally **`FILEFLOWS_MEDIA_DIR`**) to host folders that match how you organize media (for example a fast NVMe path on a workstation).
2. `docker compose up -d`
3. Open **`http://<host>:<FILEFLOWS_HTTP_PORT>`** (default host port **19200**).

On first launch you must accept the EULA in the UI before schedulers and flow runners activate.

## Image tags

Common tags on [Docker Hub `revenz/fileflows`](https://hub.docker.com/r/revenz/fileflows): **`26.04`** (calendar pin), **`stable`**, **`latest`**, **`modded`** / **`modded-stable`** (bundled FFmpeg/ImageMagick when you cannot use DockerMods). See the [Docker install docs](https://fileflows.com/docs/installation/docker) for trade-offs.

## NVIDIA GPU (Linux hosts)

For **NVENC** / GPU decode on **Linux** with the [NVIDIA Container Toolkit](https://docs.nvidia.com/datacenter/cloud-native/container-toolkit/install-guide.html), add GPU access to the service. Example (supported Compose syntax on recent Docker Desktop / Engine):

```yaml
services:
  fileflows:
    gpus: all
```

Alternatively use the generator on the [Docker install page](https://fileflows.com/docs/installation/docker) and merge its `environment` / `deploy` settings into your compose file.

**Windows:** GPU passthrough with Docker depends on **WSL2** backend and a supported driver stack; treat NVENC as best-effort until you confirm `nvidia-smi` inside a test container.

## Intel QSV / `/dev/dri`

The upstream generator can pass **`/dev/dri`** for Intel Quick Sync. This repo does not add those devices by default (many AMD-only desktops have nothing to map).

## Processing nodes

Distributed workers use the separate image **`revenz/fileflows-node`**; see the same [Docker documentation](https://fileflows.com/docs/installation/docker) (**Type: Processing Node**).

## Related stacks

Plex / Jellyfin libraries in this repo often pair well with FileFlows for **library hygiene** and transcoding — see [`../plex/`](../plex/) and [`../jellyfin/`](../jellyfin/).
