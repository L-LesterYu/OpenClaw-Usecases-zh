# 项目状态管理系统：面向事件驱动的看板替代方案

传统的看板是静态的，需要手动更新。你忘记移动卡片，在会话之间丢失上下文，并且无法跟踪状态变化背后的"原因"。项目在没有清晰可见性的情况下偏离轨道。

此工作流程用事件驱动系统替换看板，自动跟踪项目状态：

• 在数据库中存储项目状态，包含完整历史
• 捕获上下文：决策、阻塞点、下一步、关键洞察
• 事件驱动的更新："刚刚完成X，被Y阻塞" → 自动状态转换
• 自然语言查询："[项目]的状态如何？","我们为什么在[功能]上转向？"
• 每站会摘要：昨天发生了什么，今天计划什么，什么被阻塞
• Git 集成：将提交链接到项目事件，实现可追溯性

## 痛点分析

看板会变得过时。你浪费时间更新卡片而不是做工作。上下文会丢失——三个月后，你记不清为什么做出关键决策。代码更改和项目进展之间没有自动链接。

## 功能特点

不再拖拽卡片，而是与助手聊天对话："完成了认证流程，开始做仪表板。"系统记录事件，更新项目状态，并保存上下文。当你问"仪表板进行到哪一步了？"它会给你完整的故事：完成了什么，下一步是什么，什么阻塞了你，以及为什么。

Git 提交会被自动扫描并链接到项目。你的每日站会摘要自动生成。

## 所需技能

- 用于项目状态数据库的 `postgres` 或 SQLite
- 用于提交跟踪的 `github` (gh CLI)
- 用于更新和查询的 Discord 或 Telegram
- 用于每日摘要的定时任务
- 用于并行项目分析的子智能体

## 设置指南

### 1. 设置项目状态数据库：
```sql
CREATE TABLE projects (
  id SERIAL PRIMARY KEY,
  name TEXT UNIQUE,
  status TEXT, -- 例如 "active", "blocked", "completed"
  current_phase TEXT,
  last_update TIMESTAMPTZ DEFAULT NOW()
);

CREATE TABLE events (
  id SERIAL PRIMARY KEY,
  project_id INTEGER REFERENCES projects(id),
  event_type TEXT, -- 例如 "progress", "blocker", "decision", "pivot"
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

### 2. 为项目更新创建 Discord 频道（例如 #project-state）。

### 3. 提示 OpenClaw：
```text
你是我的项目状态管理员。我不使用看板，而是会话式地告诉你我正在做什么。

当我说类似这样的话时：
- "完成了[任务]" → 记录"progress"事件，更新项目状态
- "被[问题]阻塞" → 创建阻塞条目，将项目状态更新为"blocked"
- "开始[新任务]" → 记录"progress"事件，更新当前阶段
- "决定[决策]" → 记录"decision"事件，包含完整上下文
- "转向[新方法]" → 记录"pivot"事件，包含推理原因

当我问：
- "[项目]的状态如何？" → 获取最新事件、阻塞点和当前阶段
- "我们为什么决定[X]？" → 搜索事件中的决策上下文
- "什么阻塞了我们？" → 列出所有项目的未解决阻塞

每天早上9点，运行定时任务：
1. 扫描过去24小时的 git 提交（通过 gh CLI）
2. 基于分支名称或提交消息将提交链接到项目
3. 向 Discord #project-state 发送每日站会摘要：
   - 昨天发生了什么（事件+提交）
   - 今天计划什么（基于当前阶段和最近对话）
   - 什么被阻塞（未解决的阻塞点）

当我计划冲刺时，启动子智能体分析每个项目的状态并建议优先级。
```

### 4. 集成到你的工作流程：只需自然地与助手对话你在做什么，系统会捕获一切。

## 相关链接

- [事件溯源模式](https://martinfowler.com/eaaDev/EventSourcing.html)
- [为什么看板对独立开发者不起作用](https://blog.nuclino.com/why-kanban-doesnt-work-for-me)