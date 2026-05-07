# Backup

Tools whose **primary job** is backing up or restoring data: scheduled backup UIs, **restic** HTTP targets, and **S3-compatible** storage for tools that sync to buckets.

## Stacks

- **[duplicati](duplicati/)** — Duplicati web UI for encrypted backups (paths mounted on the **server**).
- **[minio](minio/)** — MinIO (S3-compatible object storage for apps and destinations that use **`s3://`**).
- **[restic-rest-server](restic-rest-server/)** — **Restic** REST backend; install **restic** on each **PC** for encrypted, deduplicated backups to this host.

If you add a stack here, list it above and follow **[docs/standards.md](../../docs/standards.md)** and **[CONTRIBUTING.md](../../CONTRIBUTING.md)**.
