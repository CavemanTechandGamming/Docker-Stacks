# Media

**Libraries and streaming** for movies, television, music, photos, audiobooks, and ebooks—your files served on your LAN—plus **transcoding / file pipelines** (**FileFlows**) that often complement those libraries.

## Stacks

Stacks are listed **alphabetically** by directory name.

The **type** column is a **high-level workload label**. A single LAN often runs several stacks together—for example Plex *or* Jellyfin for playback, Kavita alongside music, Immich beside either, plus FileFlows for hygiene jobs.

| Stack | Type | Description |
|-------|------|-------------|
| [audiobookshelf](audiobookshelf/) | Audiobooks & podcasts | Self-hosted **Audiobookshelf** server for streaming audiobooks and podcasts with playback progress, libraries, and metadata; bind-mount layout aligns with upstream Docker conventions. |
| [fileflows](fileflows/) | Transcoding & file automation | **FileFlows** automates ingest and processing pipelines—video/audio transcoding, images, ebooks, and more—with official image **`revenz/fileflows`**, DockerMods support, and optional GPU passthrough documented in the stack README. |
| [immich](immich/) | Photo & personal-video backup | **Immich** (Google Photos–style backups) bundles **immich-server**, **immich-machine-learning**, **PostgreSQL** with upstream’s extensions image, and **Valkey** (Redis-compatible)—match storage, backup, and ML sizing to docs. |
| [jellyfin](jellyfin/) | Video streaming (open-source) | **Jellyfin** media server with discrete **config**, **cache**, and **library** volumes; **`JELLYFIN_UID_GID`** should mirror the owning user on mounted media directories. |
| [kavita](kavita/) | Reading (ebooks / comics / manga) | **Kavita** self-hosted reader for ebooks, comics, and manga (OPDS, library management, reader UI), using LinuxServer-style images and a primary **`data`** library mount. |
| [open-audio](open-audio/) | Music streaming | Runs **Navidrome** behind the folder label **Open Audio**: Subsonic-compatible **music** streaming for your own FLAC/MP3 tree; README explains naming vs unrelated “Open Audio” projects. |
| [open-ebooks](open-ebooks/) | Ebook discovery (IRC) | **OpenBooks**: web frontend that discovers and downloads ebooks through **IRC** (Irchighway `#ebook`); not a Calibre-like library shelf—README contrasts **OpenEBOOKS** research noise vs what is actually shipped here. |
| [plex](plex/) | Video streaming (Plex ecosystem) | **Plex Media Server** on LinuxServer’s image—**`PLEX_CLAIM`** for account linking, persistent **`config`**, and a **`data`** volume (or bind path) backing your Plex libraries and client ecosystem. |

If you add a stack here, extend the table alphabetically by folder name and follow **[docs/standards.md](../../docs/standards.md)** and **[CONTRIBUTING.md](../../CONTRIBUTING.md)**.
