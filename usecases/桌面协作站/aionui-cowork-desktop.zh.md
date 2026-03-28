# OpenClaw 桌面协作站 (AionUi) — 远程救援与多智能体中心

通过桌面 Cowork UI 使用 OpenClaw，远离时可通过 Telegram 或 WebUI 访问，无法连接时可远程修复。AionUi 是一个免费开源的应用程序，将 **OpenClaw 作为一级智能体** 与其他 12+ 个智能体（Claude Code、Codex、Qwen Code 等）一起运行，内置 **OpenClaw 部署专家** 用于安装、诊断和修复 — 包括 **远程救援** 功能，当 OpenClaw 出故障而你不在机器旁边时。

## 为什么选择 OpenClaw + AionUi

| 如果你想要… | AionUi 提供给你… |
|------------|------------------|
| **使用真实桌面 UI 使用 OpenClaw** | Cowork 工作空间，你可以看到 OpenClaw（和其他智能体）读取/写入文件、运行命令、浏览网页 — 而不仅仅是终端/聊天。 |
| **当 OpenClaw 出故障而你远程时进行修复** | 通过 **Telegram 或 WebUI** 从任何地方打开 AionUi → 使用 **OpenClaw 部署专家** 运行 `openclaw doctor`，修复配置，重启网关。许多用户都依赖这个功能。 |
| **一个地方管理 OpenClaw + 其他智能体** | OpenClaw、内置智能体、Claude Code、Codex 等都在一个应用中；可以切换或并行运行，所有智能体使用相同的 MCP 配置。 |
| **远程访问你的 OpenClaw** | WebUI、Telegram、飞书、钉Talk — 从手机或其他设备与同一个 AionUi 实例（从而是 OpenClaw）对话。 |

## 痛点

你已经通过 CLI 或 Telegram 使用 OpenClaw，但是：

- 你想要**看到**智能体在做什么（文件、终端、网页），而不是从日志中推断。
- 当 **OpenClaw 无法连接** 而你不在机器旁边时，你无法运行 `openclaw doctor` 或修复配置 — 你需要能够修复 OpenClaw 的远程访问。
- 你使用多个 CLI 智能体（OpenClaw、Claude Code、Codex 等），不想在多个应用间切换或为每个智能体重新配置 MCP。

## 它的功能

- **作为 Cowork 智能体的 OpenClaw**：安装 AionUi 和 OpenClaw；AionUi 自动检测 OpenClaw。从同一个 Cowork UI 使用 OpenClaw — 感知文件的工作空间，可见的操作。
- **远程 OpenClaw 救援**：当 OpenClaw 出故障或无法访问时，通过 **Telegram 或 WebUI** 打开 AionUi 并使用内置的 **OpenClaw 部署专家**。它帮助安装，运行 `openclaw doctor`，修复配置，重启网关，引导你完成恢复。这是运行无头 OpenClaw 或在其他机器上的用户的常见模式。
- **一个应用中的多智能体**：在 OpenClaw 旁边运行内置智能体（Gemini/OpenAI/Anthropic/Ollama）、Claude Code、Codex 和 12+ 个其他智能体 — 一个界面，并行会话。
- **一次配置，所有智能体使用 MCP**：在 AionUi 中配置 MCP 服务器一次；它们会同步到 OpenClaw 和每个其他智能体 — 无需为每个智能体单独设置 MCP。
- **远程访问**：使用 WebUI、Telegram、飞书或钉Talk 从任何地方访问你的 AionUi 实例（和 OpenClaw）。
- **可选的自动化**：AionUi 的定时任务可以按计划运行 OpenClaw（或其他智能体）用于 24/7 任务。

## 你需要的技能

- **OpenClaw**（例如 `npm install -g openclaw@latest`）。AionUi 的 **OpenClaw 设置** 助手可以指导安装、网关和配置。
- 你的模型的 API 密钥或认证（OpenClaw 配置 + AionUi 中任何内置智能体的密钥）。

## 如何设置

1. **安装 AionUi**：[AionUi 发布页面](https://github.com/iOfficeAI/AionUi/releases)（macOS / Windows / Linux）。
2. **安装 OpenClaw**（如果需要）：
   ```bash
   npm install -g openclaw@latest
   openclaw onboard --install-daemon   # 可选：为 24/7 运行的守护进程
   ```
3. **打开 AionUi**：它会自动检测 OpenClaw。如果没有检测到，使用应用内的 **OpenClaw 设置** 助手。
4. **创建 Cowork 会话** 并选择 OpenClaw。相同的工作空间、MCP 和（如果启用）远程频道。

对于远程访问或定时任务，在 AionUi 设置中配置频道和自动化。

## 相关链接

- [AionUi GitHub](https://github.com/iOfficeAI/AionUi)
- [AionUi 网站](https://www.aionui.com)
- [OpenClaw GitHub](https://github.com/openclaw/openclaw)
- [OpenClaw 文档](https://docs.openclaw.ai)