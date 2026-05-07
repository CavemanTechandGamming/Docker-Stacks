# AI

Self-hosted **machine learning and conversational AI** workloads: run models and front ends on your own hardware instead of routing prompts through proprietary APIs.

## Stacks

Stacks are listed **alphabetically** by directory name.

The **type** column is a **high-level workload label**. Real deployments often blend categories (for example diffusion stacks with animation or video pipelines, or gateways that invoke both APIs and local models).

| Stack | Type | Description |
|-------|------|-------------|
| [automatic1111-webui](automatic1111-webui/) | Image / video diffusion | Browser UI for AUTOMATIC1111 **Stable Diffusion WebUI**, using a community Docker image geared toward NVIDIA GPUs; bind-mounted trees for checkpoints, extensions, outputs, and related assets. |
| [comfyui](comfyui/) | Image / video diffusion | **ComfyUI** node-graph interface for Stable Diffusion and related tooling; relies on an **ai-dock** image with a workspace volume for models, custom nodes, and user data (CUDA/ROCm/CPU tags per upstream documentation). |
| [ollama-open-webui](ollama-open-webui/) | LLMs (text / chat) | Local **large language model** runtime (**Ollama**) paired with **Open WebUI**, giving a straightforward browser chat surface over Docker’s internal network. |
| [openclaw](openclaw/) | Assistant gateway | Personal AI **gateway**: web control plane, integrations for chat channels (Telegram, Discord, WhatsApp, etc.), and configurable providers (including local inference via host-exposed endpoints). |
| [paperclip](paperclip/) | Agent orchestration | Agent **orchestration** stack with scheduling, oversight, and a web dashboard; aligns with upstream’s single-service Compose layout and embedded datastore pattern. |

If you add a stack here, extend the table alphabetically by folder name and follow **[docs/standards.md](../../docs/standards.md)** and **[CONTRIBUTING.md](../../CONTRIBUTING.md)**.
