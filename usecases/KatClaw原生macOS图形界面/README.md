# KatClaw — OpenClaw 原生 macOS 图形界面

## 痛点

在 macOS 上配置 OpenClaw 需要使用终端、安装 Node.js、npm，并手动编辑配置文件。非技术用户（或偏好图形界面的用户）面临着陡峭的上手门槛。注重安全的用户也缺乏便捷的方式来控制智能体的执行权限。

## 功能介绍

[KatClaw](https://katclaw.ai) 是一款原生 macOS 应用，将 OpenClaw 封装为一键安装的完整图形界面。它提供以下功能：

- **一键安装** — 自动安装 Node.js 和 OpenClaw，无需使用终端
- **AI 供应商配置** — 通过下拉菜单配置 Claude、GPT、Gemini、DeepSeek、Moonshot/Kimi 等
- **Telegram 连接** — 引导式设置，支持二维码扫描
- **安全模式** — 提供保守、适度和完全三种模式，控制智能体的执行权限，配有可视化执行审批弹窗
- **技能管理** — 浏览、安装和管理来自 ClawHub 和 SkillHub（腾讯）的智能体技能，集成 VirusTotal 安全审核徽章
- **健康检查** — 内置诊断工具（`openclaw doctor`），支持自动修复
- **自动更新** — 基于 Sparkle 框架的自动更新，同时更新 KatClaw 和 OpenClaw

## 适用人群

- 希望在不接触命令行的情况下使用 OpenClaw 的 Mac 用户
- 需要对智能体执行权限进行安全管控的用户
- 中文用户（支持简体中文本地化，集成 SkillHub/腾讯注册源，预配置 DeepSeek/Kimi）

## 安装步骤

1. 从 [katclaw.ai](https://katclaw.ai) 下载
2. 打开应用，选择 AI 供应商，输入 API 密钥
3. 可选连接 Telegram
4. 完成 — 你的智能体已开始运行

## 所需技能

无需额外技能 — KatClaw 通过内置的技能窗口管理技能安装。

## 相关链接

- 官网：[katclaw.ai](https://katclaw.ai)
- Product Hunt：[KatClaw on Product Hunt](https://www.producthunt.com/products/katclaw-mac-automation-made-easy)
