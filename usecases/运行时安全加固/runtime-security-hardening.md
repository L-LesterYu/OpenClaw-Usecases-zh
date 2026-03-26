# 使用 PRISM 进行运行时安全加固

## 痛点

OpenClaw 智能体拥有广泛的工具访问权限——它们可以执行命令、读写文件和发起网络请求。一次来自恶意邮件、网页或工具结果的提示注入攻击，就可能劫持智能体去执行危险命令、窃取凭证或篡改关键配置文件。没有运行时防御机制的情况下，你只能在事故发生后才发现安全漏洞。

## 功能介绍

[PRISM](https://github.com/KyaClaw/openclaw-prism) 是一个零分支安全层，通过 10 个 OpenClaw 钩子拦截智能体生命周期的**每一个阶段**。它以一个插件加四个边车服务的形式运行：

- **注入检测** — 两层扫描（10 条启发式正则规则 + 可选 Ollama LLM 级联），对所有入站消息和工具结果进行检测
- **会话风险累积** — 基于会话的风险评分，带有 TTL 衰减。高风险时自动阻止危险工具调用和子智能体生成
- **执行沙箱** — 白名单优先、黑名单次之的管道，支持 Shell 弹跳检测（`bash -c`、`python -c`、`node -e`）、元字符拒绝和受保护路径强制执行
- **出站数据防泄漏** — 在消息离开网关之前扫描出站消息中的凭证模式（AWS 密钥、SSH 私钥、Slack/GitHub/OpenAI 令牌）
- **文件完整性监控** — 监控关键 OpenClaw 文件（openclaw.json、AGENTS.md、SOUL.md、auth-profiles.json）的未授权变更
- **HMAC 签名审计日志** — 仅追加的 JSONL 日志，每条记录附带 HMAC-SHA256 签名，支持通过 CLI 进行链式验证
- **安全仪表盘** — Web UI 用于查看拦截事件、一键放行工作流和实时配置管理

## 安装

```bash
git clone https://github.com/KyaClaw/openclaw-prism.git
cd openclaw-prism
bash install.sh
```

`install.sh` 安装程序会生成密钥、将插件链接到 `~/.openclaw/extensions/`，并写入 PRISM 运行时配置。
在 Linux 上使用 `systemd` 时，`install.sh` 还会自动安装并启动 PRISM 服务，并将环境变量注入 OpenClaw 用户服务。
在 macOS 上，`install.sh` 只会打印 `launchd` 和手动启动步骤，因此你需要自行运行提供的 `launchd` 命令。

安装完成后，在浏览器中打开 `http://127.0.0.1:18768` 访问安全仪表盘，输入 `.env` 文件中的 `PRISM_DASHBOARD_TOKEN` 即可实时查看拦截事件。

## 所需技能

无需任何 OpenClaw 技能——PRISM 作为原生 OpenClaw 插件安装（使用钩子 API）。可与任何现有技能无冲突地并行工作。

## 相关链接

- [PRISM GitHub](https://github.com/KyaClaw/openclaw-prism)
- [OpenClaw 安全指南](https://docs.openclaw.ai/gateway/security)
- [OpenClaw 钩子 API](https://docs.openclaw.ai/automation/hooks)
