# 目标驱动自主任务

你的 AI 智能体很强大，但它是被动的——只有在你告诉它做什么时才工作。如果它知道你的目标，并且每天主动生成任务来让你更接近这些目标，而无需你开口呢？

这个工作流将 OpenClaw 变成一个自主员工。你只需把目标倾诉出来，智能体就会自主生成、安排和完成推进这些目标的任务——包括在晚上为你构建惊喜小应用。

## 功能介绍

- 你将所有目标、使命和目的倾诉给 OpenClaw（个人和职业）
- 每天早上，智能体生成 4-5 个它可以自主完成的任务
- 任务不仅限于应用构建：调研、编写脚本、开发功能、创建内容、分析竞争对手
- 智能体自行执行任务，并在它为你构建的自定义看板上追踪进度
- 你还可以让它每晚为你构建一个惊喜小应用——一个新的 SaaS 创意、一个自动化无聊生活的工具，以 MVP 形式交付

## 痛点

大多数人有大目标，但很难将其分解为每日可执行的步骤。即使做到了，执行也会耗费所有时间。这个系统将规划和执行都外包给你的 AI 智能体。你定义目的地；智能体找出每日步骤并一步步执行。

## 所需技能

- Telegram 或 Discord 集成
- `sessions_spawn` / `sessions_send`，用于自主任务执行
- Next.js 或类似框架（用于看板——OpenClaw 为你构建）

## 设置方法

### 第一步：倾诉你的目标

这是最重要的一步。向你的 OpenClaw 发送你想要实现的一切：

```text
Here are my goals and missions. Remember all of this:

Career:
- Grow my YouTube channel to 100k subscribers
- Launch my SaaS product by Q3
- Build a community around AI education

Personal:
- Read 2 books per month
- Learn Spanish

Business:
- Scale revenue to $10k/month
- Build partnerships with 5 companies in my space
- Automate as much of my workflow as possible

Use this context for everything you do going forward.
```

### 第二步：设置自主每日任务

```text
Every morning at 8:00 AM, come up with 4-5 tasks that you can complete
on my computer today that bring me closer to my goals.

Then schedule and complete those tasks yourself. Examples:
- Research competitors and write analysis reports
- Draft video scripts based on trending topics
- Build new features for my apps
- Write and schedule social media content
- Research potential business partnerships
- Build me a surprise mini-app MVP that gets me closer to one of my goals

Track all tasks on a Kanban board. Update the board as you complete them.
```

### 第三步：构建看板（可选）

```text
Build me a Kanban board in Next.js where I can see all the tasks you're
working on. Show columns for To Do, In Progress, and Done. Update it
in real-time as you complete tasks.
```

## 核心洞察

- **倾诉目标是关键**。你给的目标上下文越多，智能体的每日任务就越好。不要有所保留。
- 智能体会发现你想不到的任务。它会在你的目标之间建立联系，发现你可能会错过的机会。
- 看板将智能体变成可追踪的员工。你可以准确看到它做了什么并调整方向。
- 对于夜间应用构建：明确告诉它构建 MVP，不要过度复杂化。你每天早上都会被惊喜到。
- 这会随时间复利——智能体会学习哪些任务最有帮助并自行调整。

## 陷阱与模式（生产环境经验）

### ⚠️ 竞态条件：子智能体编辑共享文件

当你使用子智能体运行此工作流时，主会话和生成的子智能体可能同时尝试更新同一个任务文件（例如你的看板/AUTONOMOUS.md）。这会导致静默失败。

**原因**：OpenClaw 的 `edit` 工具需要精确的 `oldText` 匹配。如果子智能体在主会话读取文件和尝试编辑之间更新了一行，文本就不再匹配——编辑静默失败。

**修复方法：将任务文件分为两个角色：**

1. **`AUTONOMOUS.md`** — 保持小巧整洁。仅包含目标 + 待处理积压。只有主会话触摸它。子智能体永远不编辑它。

2. **`memory/tasks-log.md`** — 仅追加日志。子智能体只**在末尾添加新行**。永远不编辑现有行。

```markdown
# tasks-log.md — Completed Tasks (append-only)
# Sub-agents: always append to the END. Never edit existing lines.

### 2026-02-24
- ✅ TASK-001: Research competitors → research/competitors.md
- ✅ TASK-002: Draft blog post → drafts/post-1.md
```

这个模式借鉴自 Git 的提交日志：你永远不重写历史，只添加新提交。它彻底消除了竞态条件，还有一个额外好处：`AUTONOMOUS.md` 保持小巧，每次心跳加载时消耗更少的 token。

**给智能体的规则**：在子智能体生成指令中始终包含：
> "When done, append a ✅ line to `memory/tasks-log.md`. Never edit `AUTONOMOUS.md` directly."

### 💡 保持 AUTONOMOUS.md token 轻量

任务跟踪文件在每次心跳轮询时都会被加载。如果它随着已完成任务无限增长，你会不必要地浪费 token。

保持 `AUTONOMOUS.md` 在约 50 行以下：目标（一行描述）+ 仅待处理积压。将所有已完成内容归档到仅按需读取的单独文件中。

## 灵感来源

灵感来自 [Alex Finn](https://www.youtube.com/watch?v=UTCi_q6iuCM&t=414s) 和他关于改变生活的 OpenClaw 用例的视频。

## 相关链接

- [OpenClaw 记忆系统](https://github.com/openclaw/openclaw)
- [OpenClaw 子智能体文档](https://github.com/openclaw/openclaw)
