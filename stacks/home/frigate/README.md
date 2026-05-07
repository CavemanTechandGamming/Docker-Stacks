# Frigate

**[Frigate](https://frigate.video/)** is an open-source **NVR** focused on **local AI object detection** (people, packages, vehicles, etc.) while keeping video on your LAN. Matches your research triage (**Frigate**, row **#142**).

This repo keeps Frigate under **`home/`** next to **[Home Assistant](../home-assistant/)** and **[Mosquitto](../mosquitto/)**—CCTV and automation share the same “household infrastructure” bucket, separate from **`media/`** stacks aimed at **libraries and playback**.

### How this differs from **[Plex](../../media/plex/)** / **[Jellyfin](../../media/jellyfin/)**

Those stacks target **movies and libraries**. Frigate targets **security cameras**: RTSP/RTMP streams, **recording**, **snapshots**, and **MQTT / Home Assistant** hooks—not theatrical playback UX.

## Before you start

1. `mkdir -p media` next to **`compose.yaml`** for recordings (or set **`FRIGATE_MEDIA_DIR`**).

2. Edit **`config/config.yml`**: add at least **one camera** with a valid **`ffmpeg`** input (`rtsp://…`). Start from **[Frigate configuration docs](https://docs.frigate.video/configuration/)**—empty **`cameras:`** is only a placeholder so the repo validates; Frigate expects real inputs before it is useful.

3. `cp .env.example .env` — adjust ports if needed (**8971** avoids colliding with many defaults).

4. `docker compose up -d`

5. Open **`http://<host>:8971`** (or your **`FRIGATE_WEB_PORT`**).

## Hardware acceleration

- **CPU detector** (shipped here) is fine for **one or two modest streams**; heavier setups benefit from **Coral USB**, **Coral M.2**, or **GPU/VAAPI** per upstream guides.
- For **Coral USB**, uncomment the **`devices:`** block in **`compose.yaml`** mapping **`/dev/bus/usb`**.

## MQTT and Home Assistant

Enable **`mqtt:`** in **`config.yml`** when you run **[Mosquitto](../mosquitto/)**—point Frigate at the same broker you use with **[Home Assistant](../home-assistant/)**.

## Security

- **Never** expose RTSP credentials or Frigate’s UI to the **public internet** without understanding proxy auth and TLS.
- Firewall **8554/8555** like any streaming surface.

## Official references

- [Frigate](https://frigate.video/)
- [Documentation](https://docs.frigate.video/)
- [GitHub — blakeblackshear/frigate](https://github.com/blakeblackshear/frigate)
