# Zigbee2MQTT

**[Zigbee2MQTT](https://www.zigbee2mqtt.io/)** bridges **Zigbee devices** to **MQTT**, so **[Home Assistant](../home-assistant/)**, **[Node-RED](https://nodered.org/)**, or anything MQTT-aware can subscribe without vendor clouds or proprietary hubs. Matches your research triage (**Zigbee2MQTT**, row **#172**).

Run this **beside** **[Mosquitto](../mosquitto/)**: Zigbee2MQTT publishes topics your broker forwards to subscribers.

## Before you start

1. Flash firmware onto your coordinator per **[Zigbee2MQTT adapter docs](https://www.zigbee2mqtt.io/guide/adapters/)** (Sonoff ZBDongle-E, SLZB-06, etc.).

2. **`data/configuration.yaml`** — set **`mqtt.server`** to a broker reachable **from this container**:
   - **Linux (Docker bridge):** **`mqtt://172.17.0.1:1883`** often reaches **host-published** Mosquitto; your gateway IP may differ (`docker network inspect bridge`).
   - **Docker Desktop:** try **`mqtt://host.docker.internal:1883`**.
   - **Same user-defined network:** advanced users can attach Mosquitto and Zigbee2MQTT to one Compose network and use **`mqtt://mosquitto:1883`** with both stacks coordinated upstream.

3. Match **`serial.port`** to your stick (**`/dev/ttyACM0`** vs **`/dev/ttyUSB0`**).

4. Uncomment **`devices:`** in **`compose.yaml`** and map the correct **`/dev/...`** path.

5. `docker compose up -d`

6. Web UI: **`http://<host>:8091`** (default **`ZIGBEE2MQTT_PORT`**).

Set **`homeassistant: true`** in **`configuration.yaml`** when you want automatic **[MQTT discovery](https://www.home-assistant.io/integrations/mqtt/)** payloads.

## Security

- MQTT without TLS + anonymous Mosquitto on a flat LAN is convenient but brittle—**tighten Mosquitto auth** before exposing Wi‑Fi guest VLANs.

## Official references

- [Zigbee2MQTT](https://www.zigbee2mqtt.io/)
- [Getting started](https://www.zigbee2mqtt.io/guide/getting-started/)
- [Docker guide](https://www.zigbee2mqtt.io/guide/installation/02_docker.html)
