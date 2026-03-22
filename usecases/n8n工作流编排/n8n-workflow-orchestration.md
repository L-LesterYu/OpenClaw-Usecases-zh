# OpenClaw + n8n 工作流编排

让 AI 智能体直接管理 API 密钥和调用外部服务是安全隐患。每新增一个集成意味着 `.env.local` 中多一个凭证，智能体可能意外泄露或滥用的攻击面多一个。

这个用例描述了一种模式：OpenClaw 通过 Webhook 将所有外部 API 交互委托给 n8n 工作流——智能体从不接触凭证，每个集成都可可视化检查和锁定。

## 痛点

当 OpenClaw 直接处理一切时，会遇到三个复合问题：

- **缺乏可见性**：当智能体构建的内容隐藏在 JavaScript 技能文件或 shell 脚本中时，很难检查它实际做了什么
- **凭证泛滥**：每个 API 密钥都存放在智能体的环境中，一次错误的提交就可能暴露
- **浪费 token**：确定性子任务（发送邮件、更新电子表格）消耗 LLM 推理 token，而它们本可以作为简单工作流运行

## 功能介绍

- **代理模式**：OpenClaw 通过传入 Webhook 编写 n8n 工作流，然后在所有后续 API 交互中调用这些 Webhook
- **凭证隔离**：API 密钥存放在 n8n 的凭证存储中——智能体只知道 Webhook URL
- **可视化调试**：每个工作流都可在 n8n 的拖拽 UI 中检查
- **可锁定工作流**：工作流构建和测试完成后，锁定它以防止智能体修改其与 API 的交互方式
- **安全步骤**：你可以在 n8n 中添加验证、限速和审批门控，在任何外部调用执行之前

## 工作原理

1. **智能体设计工作流**：告诉 OpenClaw 你需要什么（例如，"创建一个工作流，当新的 GitHub issue 被标记为 `urgent` 时发送 Slack 消息"）
2. **智能体在 n8n 中构建**：OpenClaw 通过 n8n API 创建工作流，包括传入 Webhook 触发器
3. **你添加凭证**：在 n8n 的 UI 中手动添加你的 Slack token / GitHub token
4. **你锁定工作流**：阻止智能体进一步修改
5. **智能体调用 Webhook**：从现在起，OpenClaw 使用 JSON 负载调用 `http://n8n:5678/webhook/my-workflow`——它永远看不到 API 密钥

```text
┌──────────────┐     webhook 调用     ┌─────────────────┐     API 调用     ┌──────────────┐
│   OpenClaw   │ ───────────────────→  │   n8n 工作流    │ ─────────────→  │  外部        │
│   (智能体)   │   （无凭证）          │  (已锁定，含     │  (凭证留在这里)  │  服务        │
│              │                       │   API 密钥)     │                  │  (Slack 等)  │
└──────────────┘                       └─────────────────┘                  └──────────────┘
```

## 所需技能

- `n8n` API 访问（用于创建/触发工作流）
- `fetch` 或 `curl`，用于 Webhook 调用
- Docker（如使用预配置技术栈）
- n8n 凭证管理（手动，每个集成一次性设置）

## 设置方法

### 方案 1：预配置 Docker 技术栈

社区维护的 Docker Compose 配置 ([openclaw-n8n-stack](https://github.com/caprihan/openclaw-n8n-stack)) 在共享 Docker 网络上预连接一切：

```bash
git clone https://github.com/caprihan/openclaw-n8n-stack.git
cd openclaw-n8n-stack
cp .env.template .env
# 在 .env 中添加你的 Anthropic API key
docker-compose up -d
```

这给你提供：
- 端口 3456 上的 OpenClaw
- 端口 5678 上的 n8n
- 共享 Docker 网络，使 OpenClaw 可以直接调用 `http://n8n:5678/webhook/...`
- 预构建的工作流模板（多 LLM 事实核查、邮件分类、社交监控）

### 方案 2：手动设置

1. 安装 n8n（`npm install n8n -g` 或通过 Docker 运行）
2. 配置 OpenClaw 知道 n8n 基础 URL
3. 在你的 AGENTS.md 中添加：

```text
## n8n Integration Pattern

When I need to interact with external APIs:

1. NEVER store API keys in my environment or skill files
2. Check if an n8n workflow already exists for this integration
3. If not, create one via n8n API with a webhook trigger
4. Notify the user to add credentials and lock the workflow
5. For all future calls, use the webhook URL with a JSON payload

Workflow naming: openclaw-{service}-{action}
Example: openclaw-slack-send-message

Webhook call format:
curl -X POST http://n8n:5678/webhook/{workflow-name} \
  -H "Content-Type: application/json" \
  -d '{"channel": "#general", "message": "Hello from OpenClaw"}'
```

## 核心洞察

- **一举三得**：可观察性（可视化 UI）、安全性（凭证隔离）和性能（确定性工作流不消耗 token）
- **测试后锁定**："构建 → 测试 → 锁定"循环至关重要——不锁定的话，智能体可以静默修改工作流
- **n8n 有 400+ 集成**：你想连接的大多数外部服务已经有 n8n 节点，节省智能体编写自定义 API 调用的时间
- **免费获得审计追踪**：n8n 记录每次工作流执行的输入/输出数据

## 灵感来源

这个模式由 [Simon Høiberg](https://x.com/SimonHoiberg/status/2020843874382487959) 描述，他概述了这种方法比让 OpenClaw 直接处理 API 交互更好的三个原因：通过 n8n 的可视化 UI 实现可观察性，通过凭证隔离实现安全性，以及通过将确定性子任务作为工作流而非 LLM 调用运行来实现性能优化。[openclaw-n8n-stack](https://github.com/caprihan/openclaw-n8n-stack) 仓库提供了实现此模式的现成 Docker Compose 配置。

## 相关链接

- [n8n 文档](https://docs.n8n.io/)
- [openclaw-n8n-stack（Docker 配置）](https://github.com/caprihan/openclaw-n8n-stack)
- [n8n Webhook 触发器文档](https://docs.n8n.io/integrations/builtin/core-nodes/n8n-nodes-base.webhook/)
