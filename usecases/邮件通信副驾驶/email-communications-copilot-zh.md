---
title: OpenClaw 邮件副驾驶：收件箱清零、会议纪要与回复草稿
slug: email-communications-copilot
summary: 将 OpenClaw 变为邮件与会议副驾驶，自动摘要收件箱线程、从会议纪要中提取后续行动项、并生成待审核的回复草稿。
whatItDoes: 将 Gmail 或 AgentMail 收件箱连接到 OpenClaw，让智能体自动分拣收件通信、摘要线程、提取行动项、并起草供人工审核的回复。
category: support-success
difficulty: intermediate
tags:
  - inbox-zero
  - email-triage
  - meeting-notes
  - reply-drafting
  - customer-communication
targetUser:
  - 客户支持负责人
  - 客户成功团队
  - 创始人
skillsUsed:
  - name: AgentMail
    href: https://docs.agentmail.to/integrations/openclaw
  - name: Gmail Pub/Sub
    href: https://docs.openclaw.ai/automation/gmail-pubsub
updatedAt: '2026-03-20'
published: true
---

## 功能介绍
- 监控 Gmail 或 AgentMail 收件箱，新邮件到达时自动推送至 OpenClaw。
- 摘要长线程，提取下一步行动，仅将需要处理的事项推送给操作者。
- 将 Google Meet 纪要转化为后续跟进材料，从生成的文档或摘要邮件中提取决策、负责人和截止日期。
- 为客户支持、客户成功或其他面向客户的沟通起草回复，最终发送仍由人工审核把关。

## 所需技能
- [AgentMail](https://docs.agentmail.to/integrations/openclaw)
- [Gmail Pub/Sub](https://docs.openclaw.ai/automation/gmail-pubsub)

## 痛点
沟通分散在收件箱、会议纪要和后续任务之间。团队反复做三件低价值工作：重读长线程、重写会议后续、起草类似的回复。

## 核心价值
- **邮件处理可压缩为摘要、行动项和草稿**：Google 公开文档了 Gmail 摘要、草稿编辑和上下文回复生成功能；OpenClaw 将这些输出路由回操作者的工作流。
- **会议后续可从生成的纪要开始**：Vimeo 和 Equifax 公开描述了使用 Meet + Gemini 进行纪要、摘要和行动项提取；这些材料可直接输入后续邮件或任务队列。
- **外发风险更低**：AgentMail 支持创建草稿供人工审核后再发送。
- **回复质量更稳定**：Google 文档记录了基于文件的回复提示模式，Thoughtworks 公开描述了以作者语气生成 Gmail 草稿的流程。

## 典型场景
- **晨间收件箱重置**：摘要过夜线程，归类需要回复的邮件，忽略简报或低信号更新。
- **高频回复处理**：将常见问题转化为基于 FAQ 或政策文档的可审核草稿。
- **会后清理**：从 Meet 纪要中提取决策和行动项，然后发送一封精致的后续邮件给参会者。
- **创始人沟通分拣**：比较多个供应商或客户线程，识别缺失的承诺，准备第一轮回复。

## 设置方法
1. 对于 Gmail 接入，运行 `openclaw webhooks gmail setup --account you@example.com`，然后通过 `openclaw webhooks gmail run` 保持监听运行。
2. 启用 Gmail 预设映射，使收件邮件到达 OpenClaw 会话；使用 `deliver: true` 和 `channel: "last"` 将摘要返回到最近的聊天界面。
3. 如需专用 AI 收件箱或更安全的草稿审批流程，使用 `npx clawhub@latest install agentmail` 安装 AgentMail，并将 `AGENTMAIL_API_KEY` 添加到 `~/.openclaw/openclaw.json`。
4. 以草稿形式生成回复，然后由人工验证语气、事实和收件人后再发送。
5. 为定期会议开启 Google Meet "为我做笔记"功能，使纪要文档、日历附件和摘要邮件成为后续工作流的结构化输入。

## 存档资料

### Gmail 钩子投递配置片段
```json
{
  "hooks": {
    "enabled": true,
    "presets": ["gmail"],
    "mappings": [
      {
        "match": { "path": "gmail" },
        "action": "agent",
        "name": "Gmail",
        "deliver": true,
        "channel": "last"
      }
    ]
  }
}
```

## 相关链接
- [OpenClaw 文档：Gmail Pub/Sub](https://docs.openclaw.ai/automation/gmail-pubsub)
- [OpenClaw 文档：`openclaw webhooks gmail setup` / `run`](https://docs.openclaw.ai/cli/webhooks)
- [AgentMail 文档：OpenClaw 集成](https://docs.agentmail.to/integrations/openclaw)
- [Latin Center of the Midlands：公开的 Gmail 草稿编辑和零收件箱工作流](https://workspace.google.com/intl/en_ca/customers/latinocenter/)
- [Thoughtworks：以作者语气进行 Gmail 草稿生成的公开工作流](https://workspace.google.com/blog/customer-stories/thoughtworks-gemini-google-workspace)
- [Vimeo：公开的 Google Meet 纪要、摘要和行动项工作流](https://workspace.google.com/blog/customer-stories/how-vimeo-uses-gemini-and-google-workspace-help-customers-create-videos-move-needle)
- [Equifax：公开的 Google Meet 转录、摘要和行动项工作流](https://workspace.google.com/blog/customer-stories/equifax-embraces-gemini-for-secure-innovation-across-business-units)
- [Adwise：公开的邮件回复提示和 Meet 摘要使用案例](https://workspace.google.com/customers/adwise/)
- [Google Workspace：Gmail 中的 Gemini](https://workspace.google.com/intl/en/products/gmail/ai/)
- [Google Meet 帮助：为我做笔记](https://support.google.com/meet/answer/14754931?hl=en)
- [Google Workspace：客户服务 AI 提示](https://workspace.google.com/resources/ai/prompts-for-customer-service/)

## 常见问题
### 这是全自动的收件箱清零吗？
通常不是。自动化摘要、路由和草稿生成，但最终发送仍由人工审核。

### 这个工作流必须用 Gmail 吗？
不是。Gmail Pub/Sub 是 OpenClaw 最强的文档化收件箱接入路径，但 AgentMail 也能为智能体提供独立收件箱及 Webhook 通知。

### 会议纪要在通话后如何共享？
Google Meet 可将纪要保存到 Google Doc，将该文档附加到日历事件，并根据主持人的共享设置通过邮件发送访问链接。

### 这可以用于社区管理而非正式支持吗？
有可能，但该案例的公开证据在客户支持、客户成功、非营利组织沟通和内部后续方面更强，而非针对社区管理团队。

### 所有 Gmail 和 Meet AI 功能在每个套餐上都可用吗？
不是。Gmail 和 Meet 中的 Gemini 功能取决于账户可用的 Google Workspace 或 Google AI 套餐，上线前应确认可用性。

### 是否有公开的端到端 OpenClaw 堆栈生产案例？
据我所知没有。本案例是 OpenClaw 收件箱接入能力、AgentMail 草稿工作流和公开 Google Workspace 客户故事的文档化综合整理。
