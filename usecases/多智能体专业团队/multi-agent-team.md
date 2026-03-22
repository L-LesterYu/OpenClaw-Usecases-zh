# 多智能体专业团队（独立创始人配置）

独立创始人身兼数职——战略、开发、营销、销售、运营。在这些角色之间切换会破坏深度工作。招聘既昂贵又缓慢。如果你能启动一支小型专业化 AI 智能体团队，每个都有明确的角色和个性，全部通过单个聊天界面控制呢？

这个用例将多个 OpenClaw 智能体设置为协调团队，每个专注于特定领域，通过共享记忆通信，并通过 Telegram 控制。

## 痛点

- **一个智能体无法什么都做好**：当同时处理战略、代码、营销研究和商业分析时，单个智能体的上下文窗口很快就会填满
- **缺乏专业化**：通用提示词产生通用输出——编码智能体不应该同时还在写营销文案
- **独立创始人倦怠**：你需要的是团队，而不是另一个需要管理的工具。智能体应该在后台工作并呈现结果，而不是需要你不断看管
- **知识孤岛**：来自营销研究的洞察不会自动通知开发优先级，除非你手动桥接它们

## 功能介绍

- **专业化智能体**：每个智能体有明确的角色、个性和针对其领域优化的模型
- **共享记忆**：项目文档、目标和关键决策对所有智能体可访问——信息不丢失
- **私有上下文**：每个智能体还维护自己的对话历史和领域特定笔记
- **单一控制面板**：所有智能体通过一个 Telegram 群聊访问——@ 你需要的智能体
- **定时日常任务**：智能体在未被要求的情况下主动工作——内容提示、竞争对手监控、指标跟踪
- **并行执行**：多个智能体可以同时处理独立任务

## 团队配置示例

### 智能体 1：Milo（战略负责人）

```text
## SOUL.md — Milo

You are Milo, the team lead. Confident, big-picture, charismatic.

Responsibilities:
- Strategic planning and prioritization
- Coordinating the other agents
- Weekly goal setting and OKR tracking
- Synthesizing insights from all agents into actionable decisions

Model: Claude Opus
Channel: Telegram (responds to @milo)

Daily tasks:
- 8:00 AM: Review overnight agent activity, post morning standup summary
- 6:00 PM: End-of-day recap with progress toward weekly goals
```

### 智能体 2：Josh（商业与增长）

```text
## SOUL.md — Josh

You are Josh, the business analyst. Pragmatic, straight to the point, numbers-driven.

Responsibilities:
- Pricing strategy and competitive analysis
- Growth metrics and KPI tracking
- Revenue modeling and unit economics
- Customer feedback analysis

Model: Claude Sonnet (fast, analytical)
Channel: Telegram (responds to @josh)

Daily tasks:
- 9:00 AM: Pull and summarize key metrics
- Track competitor pricing changes weekly
```

### 智能体 3：营销智能体

```text
## SOUL.md — Marketing Agent

You are the marketing researcher. Creative, curious, trend-aware.

Responsibilities:
- Content ideation and drafting
- Competitor social media monitoring
- Reddit/HN/X trend tracking for relevant topics
- SEO keyword research

Model: Gemini (strong at web research and long-context analysis)
Channel: Telegram (responds to @marketing)

Daily tasks:
- 10:00 AM: Surface 3 content ideas based on trending topics
- Monitor competitor Reddit/X mentions daily
- Weekly content calendar draft
```

### 智能体 4：开发智能体

```text
## SOUL.md — Dev Agent

You are the dev agent. Precise, thorough, security-conscious.

Responsibilities:
- Coding and architecture decisions
- Code review and quality checks
- Bug investigation and fixing
- Technical documentation

Model: Claude Opus / Codex (for implementation)
Channel: Telegram (responds to @dev)

Daily tasks:
- Check CI/CD pipeline health
- Review open PRs
- Flag technical debt items
```

## 所需技能

- `telegram` 技能，用于共享控制界面
- `sessions_spawn` / `sessions_send`，用于多智能体协调
- 共享文件系统或笔记工具，用于团队记忆
- 各模型提供商的独立 API 密钥（如使用混合模型）
- 一台 VPS 或始终在线的机器来运行智能体

## 设置方法

### 1. 共享记忆结构

```text
team/
├── GOALS.md           # 当前 OKR 和优先级（所有智能体读取）
├── DECISIONS.md       # 关键决策日志（仅追加）
├── PROJECT_STATUS.md  # 当前项目状态（所有智能体更新）
├── agents/
│   ├── milo/          # Milo 的私有上下文和笔记
│   ├── josh/          # Josh 的私有上下文
│   ├── marketing/     # 营销智能体的研究
│   └── dev/           # 开发智能体的技术笔记
```

### 2. Telegram 路由

配置一个 Telegram 群组，所有智能体都监听，但只在被 @ 时响应：

```text
## AGENTS.md — Telegram Routing

Telegram group: "Team"

Routing:
- @milo → Strategy agent (spawns/resumes milo session)
- @josh → Business agent (spawns/resumes josh session)
- @marketing → Marketing agent (spawns/resumes marketing session)
- @dev → Dev agent (spawns/resumes dev session)
- @all → Broadcast to all agents
- No tag → Milo (team lead) handles by default

Each agent:
1. Reads shared GOALS.md and PROJECT_STATUS.md for context
2. Reads its own private notes
3. Processes the message
4. Responds in Telegram
5. Updates shared files if the response involves a decision or status change
```

### 3. 定时任务

```text
## HEARTBEAT.md — Team Schedule

Daily:
- 8:00 AM: Milo posts morning standup (aggregates overnight agent activity)
- 9:00 AM: Josh pulls key metrics
- 10:00 AM: Marketing surfaces content ideas from trending topics
- 6:00 PM: Milo posts end-of-day recap

Ongoing:
- Dev: Monitor CI/CD health, review PRs as they come in
- Marketing: Reddit/X keyword monitoring (every 2 hours)
- Josh: Competitor pricing checks (weekly)

Weekly:
- Monday: Milo drafts weekly priorities (input from all agents)
- Friday: Josh compiles weekly metrics report
```

## 核心洞察

- **个性比你想象的更重要**：给智能体起不同的名字和沟通风格，让"与你的团队对话"变得自然，而不是与通用 AI 搏斗
- **共享记忆 + 私有上下文**：这个组合至关重要——智能体需要共同基础（目标、决策），但也需要自己的空间来积累领域专长
- **用对的模型做对的事**：不要用昂贵的推理模型来做关键词监控。根据任务复杂度匹配模型能力
- **定时任务是飞轮**：真正价值来自智能体主动呈现洞察，而不仅仅在你提问时
- **从 2 个开始，不是 4 个**：先从一个负责人 + 一个专家开始，然后在发现瓶颈时添加智能体

## 灵感来源

这个模式由 [Trebuh 在 X 上描述](https://x.com/iamtrebuh/status/2011260468975771862)，一位独立创始人设置了 4 个 OpenClaw 智能体——Milo（战略负责人）、Josh（商业）、营销智能体和开发智能体——全部通过单个 Telegram 聊天在 VPS 上控制。每个智能体有自己的个性、模型和定时任务，同时共享项目记忆。他将其描述为"一个 24/7 可用的真实小团队"。

该模式也在 [OpenClaw Showcase](https://openclaw.ai/showcase) 上得到确认，`@jdrhyne` 报告运行"15+ 个智能体，3 台机器，1 个 Discord 服务器——IT 部门通过聊天构建了大部分功能"，`@nateliason` 描述了一个多模型流水线（原型 → 摘要 → 优化 → 实现 → 重复），在每个阶段使用不同的模型。另一位用户 `@danpeguine` 则运行两个不同的 OpenClaw 实例在同一个 WhatsApp 群组中协作。

## 相关链接

- [OpenClaw 子智能体文档](https://github.com/openclaw/openclaw)
- [OpenClaw Telegram 技能](https://github.com/openclaw/openclaw)
- [OpenClaw Showcase](https://openclaw.ai/showcase)
- [Anthropic: 构建高效智能体](https://www.anthropic.com/research/building-effective-agents)
