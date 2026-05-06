# Open Audio (music streaming)

This stack runs **[Navidrome](https://www.navidrome.org/)** — a lightweight, self-hosted music server (Subsonic-compatible API) for your own audio files.

## Research note (`research-self-hosted-apps.local.md` row 223)

That row lists **OpenAudio** with image `openaudio/openaudio` and a GitHub link that does not match a usable container image. The well-known **OpenAudioMC** project is a **Minecraft** voice plugin, not a music streaming server.

So this folder is named for your triage label **“Open Audio”**, but the implementation follows **row 222 (Navidrome)** in the same research table — the streaming option that actually matches “self-hosted music.”

### Different product: “OpenAudio” ML platform

If you meant the **AI audio analysis** application **[davidamacey/OpenAudio](https://github.com/davidamacey/OpenAudio)** (diarization, separation, etc.), it is a **multi-service** stack with its own Compose files. Use their [install instructions](https://github.com/davidamacey/OpenAudio) (e.g. `setup-openaudio.sh`); vendoring it here would duplicate a large upstream project.

## Quick start

1. `cp .env.example .env`

2. Put music files under **`music/`** (or set `NAVIDROME_MUSIC_DIR`).

3. `docker compose up -d`

4. Open **http://localhost:4533** and create an admin user.

On **Windows** or if you hit permission errors, see [Navidrome Docker](https://www.navidrome.org/docs/installation/docker/) (you may adjust or omit `user:` in `compose.yaml` for testing).

## Official references

- [Navidrome](https://www.navidrome.org/)
- [Installing with Docker](https://www.navidrome.org/docs/installation/docker/)
- [deluan/navidrome (Docker Hub)](https://hub.docker.com/r/deluan/navidrome)
