# 项目状态管理系统：看板的替代方案（事件驱动）

传统看板是静态的，需要手动更新。你忘记移动卡片，在会话之间丢失上下文，无法追踪状态变化背后的"原因"。项目在缺乏清晰可见性的情况下偏离轨道。

这个工作流用事件驱动系统替代看板，自动追踪项目状态：

• 在数据库中存储项目状态，包含完整历史
• 捕获上下文：决策、阻碍、下一步、关键洞察
• 事件驱动更新："刚完成了 X，被 Y 阻塞了" → 自动状态转换
• 自然语言查询："[项目] 的状态是什么？"、"我们为什么在 [功能] 上转向了？"
• 每日站会摘要：昨天发生了什么，今天计划做什么，什么被阻塞了
• Git 集成：将提交链接到项目事件以实现可追溯性

## 痛点

看板会过时。你花时间更新卡片而不是做实际工作。上下文会丢失——三个月后你不记得为什么要做一个关键决策。代码变更和项目进度之间没有自动关联。

## 功能介绍

你不再拖拽卡片，而是与助手对话："完成了认证流程，开始做仪表盘。"系统记录事件，更新项目状态，并保存上下文。当你问"仪表盘做到哪了？"它会给你完整的故事：完成了什么，下一步是什么，什么阻塞了你，以及为什么。

Git 提交会被自动扫描并链接到项目。你的每日站会摘要自动生成。

## 所需技能

- `postgres` 或 SQLite，用于项目状态数据库
- `github`（gh CLI），用于提交追踪
- Discord 或 Telegram，用于更新和查询
- Cron 定时任务，用于每日摘要
- 子智能体，用于并行项目分析

## 设置方法

1. 设置项目状态数据库：
```sql
CREATE TABLE projects (
  id SERIAL PRIMARY KEY,
  name TEXT UNIQUE,
  status TEXT, -- e.g., "active", "blocked", "completed"
  current_phase TEXT,
  last_update TIMESTAMPTZ DEFAULT NOW()
);

CREATE TABLE events (
  id SERIAL PRIMARY KEY,
  project_id INTEGER REFERENCES projects(id),
  event_type TEXT, -- e.g., "progress", "blocker", "decision", "pivot"
  description TEXT,
  context TEXT,
  timestamp TIMESTAMPTZ DEFAULT NOW()
);

CREATE TABLE blockers (
  id SERIAL PRIMARY KEY,
  project_id INTEGER REFERENCES projects(id),
  blocker_text TEXT,
  status TEXT DEFAULT 'open', -- "open", "resolved"
  created_at TIMESTAMPTZ DEFAULT NOW(),
  resolved_at TIMESTAMPTZ
);
```

2. 创建一个 Discord 频道用于项目更新（例如 #project-state）。

3. 向 OpenClaw 发送指令：
```text
You are my project state manager. Instead of Kanban, I'll tell you what I'm working on conversationally.

When I say things like:
- "Finished [task]" → log a "progress" event, update project state
- "Blocked on [issue]" → create a blocker entry, update project status to "blocked"
- "Starting [new task]" → log a "progress" event, update current phase
- "Decided to [decision]" → log a "decision" event with full context
- "Pivoting to [new approach]" → log a "pivot" event with reasoning

When I ask:
- "What's the status of [project]?" → fetch latest events, blockers, and current phase
- "Why did we decide [X]?" → search events for decision context
- "What's blocking us?" → list all open blockers across projects

Every morning at 9 AM, run a cron job to:
1. Scan git commits from the past 24 hours (via gh CLI)
2. Link commits to projects based on branch names or commit messages
3. Post a daily standup summary to Discord #project-state:
   - What happened yesterday (events + commits)
   - What's planned today (based on current phase and recent conversations)
   - What's blocked (open blockers)

When I'm planning a sprint, spawn a sub-agent to analyze each project's state and suggest priorities.
```

4. 融入你的工作流：只需自然地与助手交谈你在做什么。系统会自动捕获一切。

## 相关链接

- [事件溯源模式](https://martinfowler.com/eaaDev/EventSourcing.html)
- [为什么看板对独立开发者不适用](https://blog.nuclino.com/why-kanban-doesnt-work-for-me)
