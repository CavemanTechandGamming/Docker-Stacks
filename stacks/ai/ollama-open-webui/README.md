# Ollama + Open WebUI

Local LLM stack with Ollama as the model runtime and Open WebUI as the browser interface.

## What This Stack Includes

- `ollama`: runs local models and serves the API.
- `open-webui`: web interface connected to Ollama over an internal Docker network.

## Quick Start

1. Copy environment template:

   ```bash
   cp .env.example .env
   ```

2. Start services:

   ```bash
   docker compose up -d
   ```

3. Open:
   - Open WebUI: `http://localhost:3000`
   - Ollama API: `http://localhost:11434`

## Pull a Model

After the stack is running, pull at least one model:

```bash
docker compose exec ollama ollama pull llama3
```

Then refresh Open WebUI and choose the model.

## Notes

- Data is persisted in Docker named volumes (`ollama-data`, `open-webui-data`).
- If you use a GPU host, uncomment `gpus: all` in `compose.yaml` after NVIDIA runtime is configured.
- For team sharing, avoid exposing this stack directly to the internet without authentication and reverse proxy controls.

## Official references

- [Ollama](https://ollama.com/) — [Ollama GitHub](https://github.com/ollama/ollama)
- [Open WebUI](https://openwebui.com/) — [Open WebUI GitHub](https://github.com/open-webui/open-webui)
