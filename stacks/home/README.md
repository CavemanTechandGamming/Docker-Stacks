# Home & automation

**Local-first home automation, IoT glue, and CCTV**—MQTT buses, radio bridges, assistants, and camera / NVR workloads that sit beside (not inside) entertainment libraries under **`media/`**.

## Stacks

Stacks are listed **alphabetically** by directory name.

The **type** column is a **high-level workload label**. Real homes usually **compose** these (for example **Home Assistant** subscribing to **Mosquitto** while **Zigbee2MQTT** publishes there and **Frigate** feeds automations).

| Stack | Type | Description |
|-------|------|-------------|
| [frigate](frigate/) | CCTV / NVR | **Frigate** NVR with **on-prem object detection** hooks for **MQTT / Home Assistant**, distinct from Plex-style playback stacks—expects real **`ffmpeg`** camera inputs in **`config/config.yml`**. |
| [home-assistant](home-assistant/) | Automation hub | **[Home Assistant](https://www.home-assistant.io/)** keeps automations local—official container with bind-mounted **`config/`** for integrations, dashboards, and scripting. |
| [mosquitto](mosquitto/) | MQTT broker | **Eclipse Mosquitto** publishes the **topic bus** many bridges expect—documented defaults favor **trusted LAN**; harden **`allow_anonymous`** and credentials before WAN exposure. |
| [zigbee2mqtt](zigbee2mqtt/) | Zigbee ↔ MQTT bridge | **Zigbee2MQTT** maps USB coordinators to MQTT topics for **Home Assistant** or other subscribers—run **beside** **`mosquitto/`** and tailor **`data/configuration.yaml`** + **`devices:`** passthrough per hardware docs. |

If you add a stack here, extend the table alphabetically by folder name and follow **[docs/standards.md](../../docs/standards.md)** and **[CONTRIBUTING.md](../../CONTRIBUTING.md)**.
