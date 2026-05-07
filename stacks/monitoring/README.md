# Monitoring

**Operational visibility**: synthetic checks, dashboards, metrics stores, and aggregated logs so you notice downtime or regressions before users do.

## Stacks

Stacks are listed **alphabetically** by directory name.

The **type** column distinguishes **user-friendly uptime panels** from **full observability** stacks that include metrics and log pipelines.

| Stack | Type | Description |
|-------|------|-------------|
| [prometheus-grafana](prometheus-grafana/) | Metrics & logs | **Prometheus**, **Grafana**, **Loki**, and **Promtail**—time-series metrics plus log shipping (Promtail uses the Docker socket by default); bootstrap admin credentials via **`.env`** before exposing beyond the lab. |
| [uptime-kuma](uptime-kuma/) | Uptime dashboard | **Uptime Kuma** tracks HTTP/TCP/ping checks, lightweight notifications, and status pages—complements (does not replace) deep metrics stacks like **`prometheus-grafana/`**. |

If you add a stack here, extend the table alphabetically by folder name and follow **[docs/standards.md](../../docs/standards.md)** and **[CONTRIBUTING.md](../../CONTRIBUTING.md)**.
