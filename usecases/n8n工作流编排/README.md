# OpenClaw + n8n 工作流编排

让 AI 智能体直接管理 API 密钥并调用外部服务，是安全事件的温床。每新增一个集成，就意味着 `.env.local` 中多一组凭据，智能体意外泄露或滥用的攻击面也随之扩大。

本用例描述了一种模式：OpenClaw 通过 webhook 将所有外部 API 交互委托给 n8n 工作流——智能体永远不接触凭据，每个集成都可以在可视化界面中检查和锁定。

## 痛点

当 OpenClaw 直接处理一切时，你会面临三个叠加的问题：

- **缺乏可见性**：当内容深埋在 JavaScript 技能文件或 shell 脚本中时，很难审查智能体实际构建了什么
- **凭据蔓延**：每个 API 密钥都存在于智能体的环境中，一次错误的 commit 就可能导致泄露
- **浪费 Token**：确定性子任务（发送邮件、更新表格）本可以作为简单工作流运行，却消耗了 LLM 推理 Token

## 功能概述

- **代理模式**：OpenClaw 编写带有入站 webhook 的 n8n 工作流，然后通过调用这些 webhook 来处理所有后续的 API 交互
- **凭据隔离**：API 密钥存储在 n8n 的凭据仓库中——智能体只知道 webhook URL
- **可视化调试**：每个工作流都可以在 n8n 的拖拽式界面中检查
- **可锁定的工作流**：工作流构建和测试完成后，你可以将其锁定，防止智能体修改其与 API 的交互方式
- **安全防护步骤**：你可以在 n8n 中为任何外部调用执行前添加验证、限流和审批关卡

## 工作原理

1. **智能体设计工作流**：告诉 OpenClaw 你的需求（例如："创建一个工作流，当新的 GitHub Issue 被标记为 `urgent` 时发送 Slack 消息"）
2. **智能体在 n8n 中构建**：OpenClaw 通过 n8n 的 API 创建工作流，包括入站 webhook 触发器
3. **你添加凭据**：打开 n8n 的界面，手动添加你的 Slack Token / GitHub Token
4. **你锁定工作流**：阻止智能体进一步修改
5. **智能体调用 webhook**：从此以后，OpenClaw 通过 JSON 负载调用 `http://n8n:5678/webhook/my-workflow`——它永远看不到 API 密钥

```text
┌──────────────┐     webhook 调用      ┌─────────────────┐     API 调用     ┌──────────────┐
│   OpenClaw   │ ───────────────────→  │   n8n 工作流     │ ─────────────→  │  外部服务     │
│   (智能体)    │   (不携带凭据)         │  (已锁定，持有    │  (凭据留存于此)  │  (Slack 等)   │
│              │                       │   API 密钥)      │                 │              │
└──────────────┘                       └─────────────────┘                  └──────────────┘
```

## 所需技能

- `n8n` API 访问权限（用于创建/触发工作流）
- `fetch` 或 `curl` 用于 webhook 调用
- Docker（如使用预配置的方案）
- n8n 凭据管理（手动操作，每个集成一次性配置）

## 如何设置

### 方案一：预配置的 Docker 方案

一个社区维护的 Docker Compose 方案（[openclaw-n8n-stack](https://github.com/caprihan/openclaw-n8n-stack)）在共享的 Docker 网络中预配置好了一切：

```bash
git clone https://github.com/caprihan/openclaw-n8n-stack.git
cd openclaw-n8n-stack
cp .env.template .env
# 在 .env 中添加你的 Anthropic API 密钥
docker-compose up -d
```

这将为你提供：
- OpenClaw 运行在 3456 端口
- n8n 运行在 5678 端口
- 共享的 Docker 网络，OpenClaw 可以直接调用 `http://n8n:5678/webhook/...`
- 预构建的工作流模板（多 LLM 事实核查、邮件分流、社交媒体监控）

### 方案二：手动设置

1. 安装 n8n（`npm install n8n -g` 或通过 Docker 运行）
2. 配置 OpenClaw 使其知晓 n8n 的基础 URL
3. 将以下内容添加到你的 AGENTS.md：

```text
## n8n 集成模式

当我需要与外部 API 交互时：

1. 绝不将 API 密钥存储在我的环境变量或技能文件中
2. 检查是否已存在该集成的 n8n 工作流
3. 如果不存在，通过 n8n API 创建一个带有 webhook 触发器的工作流
4. 通知用户添加凭据并锁定工作流
5. 所有后续调用均使用 webhook URL 携带 JSON 负载

工作流命名规范：openclaw-{服务}-{动作}
示例：openclaw-slack-send-message

Webhook 调用格式：
curl -X POST http://n8n:5678/webhook/{workflow-name} \
  -H "Content-Type: application/json" \
  -d '{"channel": "#general", "message": "Hello from OpenClaw"}'
```

## 核心洞察

- **一举三得**：可观测性（可视化界面）、安全性（凭据隔离）和性能（确定性工作流不消耗 Token）
- **测试后立即锁定**："构建 → 测试 → 锁定"循环至关重要——不锁定的话，智能体可能悄悄修改工作流
- **n8n 拥有 400+ 集成**：你想连接的大多数外部服务已经有现成的 n8n 节点，无需智能体编写自定义 API 调用
- **免费的审计追踪**：n8n 记录每个工作流的执行日志，包含输入/输出数据

## 灵感来源

这一模式由 [Simon Høiberg](https://x.com/SimonHoiberg/status/2020843874382487959) 提出，他概述了这种方法优于让 OpenClaw 直接处理 API 交互的三个原因：通过 n8n 的可视化界面实现可观测性，通过凭据隔离实现安全性，以及通过将确定性子任务作为工作流而非 LLM 调用来运行以提升性能。[openclaw-n8n-stack](https://github.com/caprihan/openclaw-n8n-stack) 仓库提供了一个开箱即用的 Docker Compose 方案来实现这一模式。

## 相关链接

- [n8n 官方文档](https://docs.n8n.io/)
- [openclaw-n8n-stack（Docker 方案）](https://github.com/caprihan/openclaw-n8n-stack)
- [n8n Webhook 触发器文档](https://docs.n8n.io/integrations/builtin/core-nodes/n8n-nodes-base.webhook/)
