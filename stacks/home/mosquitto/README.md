# Eclipse Mosquitto (MQTT broker)

Runs **[Eclipse Mosquitto](https://mosquitto.org/)**, a small **MQTT broker** on your LAN. Matches your research triage (**MQTT Broker — Eclipse Mosquitto**, rows **#150** / **#152**).

**[Home Assistant](../home-assistant/)** can publish and subscribe to MQTT directly; many bridges (**Zigbee2MQTT**, **ESPHome**, DIY firmware) expect a broker like Mosquitto **somewhere** on the network. This stack supplies that **central topic bus** without tying configuration to a Home Assistant add-on.

## Before you start

1. `mkdir -p data` next to **`compose.yaml`** so queued messages (when **`persistence`** is on) survive container restarts.

2. `cp .env.example .env` — adjust **`MOSQUITTO_PORT`** if **1883** is taken.

3. Review **`config/mosquitto.conf`**. The shipped file enables **`allow_anonymous true`** so you can bring devices online quickly on a **trusted LAN**. Before **any** route toward the internet or guest VLANs, switch to **`allow_anonymous false`** and a **`password_file`** (see below).

4. `docker compose up -d`

## Clients and discovery

Point publishers and subscribers at **`mqtt://<this-host>:1883`** (or your Docker host LAN IP). Home Assistant’s MQTT integration typically uses **1883** with optional credentials once you enable authentication.

## Locking down authentication

1. Generate a password file in **`config/`** (example user **`iot`**):

   ```bash
   docker compose run --rm --entrypoint mosquitto_passwd mosquitto -c /mosquitto/config/passwd iot
   ```

   Enter the password when prompted (twice). The file appears on the host as **`config/passwd`**.

2. Edit **`config/mosquitto.conf`**: set **`allow_anonymous false`** and add **`password_file /mosquitto/config/passwd`**.

3. `docker compose restart`

Use **`acl_file`** in **`mosquitto.conf`** when you need topic-level separation between vendors—see Mosquitto upstream docs.

## Optional WebSockets

Home Assistant’s MQTT-over-WebSockets tutorials sometimes expect port **9001**. Add a **`listener 9001`** stanza and **`protocol websockets`** to **`config/mosquitto.conf`**, then uncomment **`MOSQUITTO_WS_PORT`** in **`compose.yaml`** and **`.env`**.

## Security

- **`allow_anonymous true`** is **not** appropriate on networks you do not fully control.
- MQTT over **1883** is **not TLS**. Keep traffic on **LAN / VPN**; terminate TLS at a reverse proxy or tunnel only when you understand the implications.

## Official references

- [Eclipse Mosquitto](https://mosquitto.org/)
- [mosquitto.conf](https://mosquitto.org/man/mosquitto-conf-5.html)
- [eclipse-mosquitto (Docker Hub)](https://hub.docker.com/_/eclipse-mosquitto)
