# OpenClaw 桌面协作站（AionUi）— 远程救援与多智能体中心

通过桌面 Cowork UI 使用 OpenClaw，在出门时通过 Telegram 或 WebUI 访问，并在连接故障时远程修复。AionUi 是一款免费开源应用，将 **OpenClaw 作为一等智能体**运行，同时支持 12+ 个其他智能体（Claude Code、Codex、Qwen Code 等），内置 **OpenClaw 部署专家**，支持安装、诊断和修复——包括在 OpenClaw 宕机且你不在电脑旁时的**远程救援**。

## 为什么选择 OpenClaw + AionUi

| 如果你想要… | AionUi 提供你… |
|---------------|--------------------|
| **通过桌面 UI 使用 OpenClaw** | Cowork 工作空间，让你看到 OpenClaw（和其他智能体）读写文件、运行命令、浏览网页——不仅是终端/聊天。 |
| **远程修复 OpenClaw** | 从任何地方通过 **Telegram 或 WebUI** 打开 AionUi → 使用内置的 **OpenClaw 部署专家**运行 `openclaw doctor`、修复配置、重启网关。很多用户依赖这个功能。 |
| **一个应用管理 OpenClaw + 其他智能体** | OpenClaw、内置智能体、Claude Code、Codex 等在一个应用中；切换或并行运行，所有智能体共享同一 MCP 配置。 |
| **远程访问你的 OpenClaw** | WebUI、Telegram、Lark、钉钉——从手机或其他设备与同一个 AionUi 实例（以及 OpenClaw）对话。 |

## 痛点

你已经通过 CLI 或 Telegram 使用 OpenClaw，但：

- 你想**看到**智能体在做什么（文件、终端、网页），而不是从日志中推测。
- 当 **OpenClaw 无法连接**而你不在电脑旁时，你无法运行 `openclaw doctor` 或修复配置——你需要远程访问能修复 OpenClaw 的工具。
- 你使用多个 CLI 智能体（OpenClaw、Claude Code、Codex…），不想在应用间切换或为每个重新配置 MCP。

## 功能介绍

- **OpenClaw 作为 Cowork 智能体**：安装 AionUi 和 OpenClaw；AionUi 自动检测 OpenClaw。从同一个 Cowork UI 使用 OpenClaw——文件感知工作空间，可视化操作。
- **远程 OpenClaw 救援**：当 OpenClaw 故障或无法访问时，通过 **Telegram 或 WebUI** 打开 AionUi，使用内置的 **OpenClaw 部署专家**。它帮助安装、运行 `openclaw doctor`、修复配置、重启网关，并引导你完成恢复。这对在无头环境或另一台机器上运行 OpenClaw 的用户来说是常见模式。
- **一个应用中的多智能体**：在 OpenClaw 旁边运行内置智能体（Gemini/OpenAI/Anthropic/Ollama）、Claude Code、Codex 和 12+ 个其他智能体——一个界面，并行会话。
- **MCP 一次配置，所有智能体可用**：在 AionUi 中配置一次 MCP 服务器；它们自动同步到 OpenClaw 和每个其他智能体——无需逐个配置。
- **远程访问**：使用 WebUI、Telegram、Lark 或钉钉从任何地方访问你的 AionUi 实例（和 OpenClaw）。
- **可选自动化**：AionUi cron 可以按计划运行 OpenClaw（或其他智能体），实现 24/7 任务。

## 所需技能

- **OpenClaw**（例如 `npm install -g openclaw@latest`）。AionUi 的 **OpenClaw 设置**助手可以引导安装、网关和配置。
- 模型的 API 密钥或认证（OpenClaw 配置 + AionUi 中任何内置智能体的密钥）。

## 设置方法

1. **安装 AionUi**：[AionUi Releases](https://github.com/iOfficeAI/AionUi/releases)（macOS / Windows / Linux）。
2. **安装 OpenClaw**（如果尚未安装）：
   ```bash
   npm install -g openclaw@latest
   openclaw onboard --install-daemon   # 可选：24/7 守护进程
   ```
3. **打开 AionUi**：它会自动检测 OpenClaw。如果没有，使用应用内的 **OpenClaw 设置**助手。
4. **创建 Cowork 会话**并选择 OpenClaw。共享工作空间、MCP 和（如果启用）远程频道。

如需远程访问或定时任务，在 AionUi 设置中配置频道和自动化。

## 相关链接

- [AionUi GitHub](https://github.com/iOfficeAI/AionUi)
- [AionUi 官网](https://www.aionui.com)
- [OpenClaw GitHub](https://github.com/openclaw/openclaw)
- [OpenClaw 文档](https://docs.openclaw.ai)
