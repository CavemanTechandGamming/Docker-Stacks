# Home Assistant

[Home Assistant](https://www.home-assistant.io/) is open-source home automation that keeps processing local. This stack runs the official container with a bind-mounted **`config`** directory.

## Quick start

1. Copy the environment file:

   ```bash
   cp .env.example .env
   ```

2. Start:

   ```bash
   docker compose up -d
   ```

3. Open **http://localhost:8123** (or your host IP and `HOMEASSISTANT_PORT`) and complete onboarding.

## Networking and hardware

- **Default (this compose):** bridge network with **8123** published. Works well for the web UI and many cloud or LAN integrations.
- **Linux + USB radios / Bluetooth / best discovery:** Home Assistant often documents **`network_mode: host`** for full feature parity. That mode conflicts with publishing `ports:` in Compose; follow [Home Assistant’s Docker install guide](https://www.home-assistant.io/installation/docker) and adjust this file if you need host networking.
- **Windows / macOS Docker Desktop:** some hardware and discovery scenarios are limited compared to a dedicated Linux host or appliance.

Optional on **Linux** only, you can add a read-only timezone sync (not valid on Windows hosts):

```yaml
volumes:
  - ${HOMEASSISTANT_CONFIG_DIR:-./config}:/config
  - /etc/localtime:/etc/localtime:ro
```

## Official references

- [Home Assistant](https://www.home-assistant.io/)
- [Home Assistant Container install](https://www.home-assistant.io/installation/docker)
- [home-assistant/core (GitHub)](https://github.com/home-assistant/core)
