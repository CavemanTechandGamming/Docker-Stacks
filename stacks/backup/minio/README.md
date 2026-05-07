# MinIO

**[MinIO](https://min.io/)** is **S3-compatible object storage** you run at home: buckets, access keys, and the same API many backup tools and apps already speak. Matches your research triage (**MinIO**, row **#58**).

### How this differs from other stacks here

| Stack | Role |
|-------|------|
| **[Restic REST server](../restic-rest-server/)** | Native **`rest:`** HTTP backend for the **restic** CLI. |
| **[Nextcloud](../../productivity/nextcloud/)** | Files, sharing, CalDAV — not a raw **S3** endpoint. |
| **MinIO** | **Amazon S3–style API** for scripts, apps, and tools that expect **`s3://`**. |

## Before you start

1. `cp .env.example .env` and set **`MINIO_ROOT_USER`** / **`MINIO_ROOT_PASSWORD`** to strong values.

2. Create **`data/`** on the host (or set **`MINIO_DATA_DIR`**) so object data persists.

3. `docker compose up -d`

4. Open **`http://<host>:<MINIO_CONSOLE_PORT>`** (default **9001**), sign in with the root user, create **buckets** and **service accounts** / keys — avoid using root credentials from every client.

## Clients

Point SDKs and backup tools at **`http(s)://<host>:9000`** (API port), region often **`us-east-1`** unless you configure otherwise upstream. For **TLS**, put **[Caddy](../../networking/caddy/)** or another proxy in front and match **`MINIO_SERVER_URL`** / browser expectations per MinIO docs.

## Security

- Do **not** publish **9000/9001** to the internet without hardening, TLS, and tight IAM-style policies.
- Prefer **LAN** or **VPN**; scope keys per bucket and rotate after leaks.

## Official references

- [MinIO](https://min.io/)
- [MinIO documentation](https://min.io/docs/minio/linux/index.html)
- [MinIO server container](https://min.io/docs/minio/container/index.html)
