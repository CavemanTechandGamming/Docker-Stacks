# Backup

Stacks whose **primary role** is **protecting or hosting backup data**: schedule-driven backup applications, **`restic`** REST repositories, and **S3-compatible** object stores that clients address with **`s3://`**.

This category pairs with **`productivity/nextcloud/`** (user-facing files) by **backing up** their volumes—not by treating live sync as archival.

## Stacks

Stacks are listed **alphabetically** by directory name.

The **type** column is a **high-level workload label**. Many labs combine a **UI scheduler** (**Duplicati**), endpoint **`restic`** jobs (**rest-server**), and **bucket** targets (**MinIO**) based on what each device can run.

| Stack | Type | Description |
|-------|------|-------------|
| [duplicati](duplicati/) | Scheduled backup UI | **[Duplicati](https://www.duplicati.com/)** encrypts snapshots to disks, **`s3://`**, SMB targets, and more—Compose mounts **`read-only`** sources so backup churn stays isolated from workloads like **`security/vaultwarden/`**. |
| [minio](minio/) | S3-compatible object storage | **MinIO** exposes Amazon **S3–style** buckets for apps and scripts that already speak **`s3://`**—complements **[`restic-rest-server`](restic-rest-server/)** (native **`rest:`**) and differs from full personal clouds (**[`productivity/nextcloud/`](../productivity/nextcloud/)**). |
| [restic-rest-server](restic-rest-server/) | Restic HTTP backend | Runs **[restic/rest-server](https://github.com/restic/rest-server)** so each machine with the **restic CLI** deduplicates ciphertext into **`rest:`** URLs; file-level restore story, not snapshot UI like **Duplicati** or continuous folder mirroring (**[`productivity/syncthing/`](../productivity/syncthing/)**). |

If you add a stack here, extend the table alphabetically by folder name and follow **[docs/standards.md](../../docs/standards.md)** and **[CONTRIBUTING.md](../../CONTRIBUTING.md)**.
