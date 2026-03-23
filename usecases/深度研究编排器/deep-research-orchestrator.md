# 深度研究编排器

你已经在为 Claude、ChatGPT 和 Gemini 付订阅费了，每个都有"深度研究"模式。把同一个问题同时丢给三个，往往能得到最佳结果——一个可能找到其他两个遗漏的关键信息源，一个可能过度分析而另一个一语中的，或者两个可能就某个观点达成一致而第三个搞错了。但手动操作——在标签页之间复制粘贴同一个提示词、等待、然后阅读并交叉比对三份长报告——实在太繁琐了，以至于你最后干脆不这么做，即使混合结果明显更好。

## 一句话输入，三平台并行研究，一个验证过的结论输出

这个工作流将其自动化为一次对话：

1. 你告诉 OpenClaw 你想研究什么
2. OpenClaw 搜索该主题，问你几个澄清问题
3. 生成一个聚焦的研究提示词，展示给你确认
4. 通过浏览器中继将提示词分发到 Claude、ChatGPT 和 Gemini 的深度研究
5. 收集三个结果，综合成一份交叉验证的结论

无需 API 密钥 · 无需额外依赖 · 通过浏览器中继使用你现有的订阅

## 痛点

多平台深度研究的效果优于任何单一平台，但手动流程——打开三个标签页、在每个里面粘贴相同的提示词、等待、然后阅读并交叉比对三份长报告——实在太繁琐，以至于你干脆不做了。即使你知道综合结果会更好，最后还是默认只用一个平台。

## 所需技能

- [OpenClaw 浏览器工具](https://docs.openclaw.ai/tools/browser) — 通过 Chrome 扩展中继控制浏览器
- [OpenClaw Chrome 扩展](https://docs.openclaw.ai/tools/chrome-extension) — 将 OpenClaw 连接到你的浏览器标签页

请使用专用的 Chrome 配置文件用于中继——不要绑定到你日常使用的配置文件。首次运行前在该配置文件中登录 Claude、ChatGPT 和 Gemini。

## 如何设置

1. 按照 [Chrome 扩展指南](https://docs.openclaw.ai/tools/chrome-extension) 设置 OpenClaw Chrome 扩展中继。

2. 在你专用的 Chrome 配置文件中登录 Claude、ChatGPT 和 Gemini。

3. 给 OpenClaw 以下系统指令。请使用强力模型（Opus 级别）——它需要在一个会话中完成网络搜索、提出好问题、生成精准的提示词、驱动浏览器以及综合研究结果。

```text
You are a deep research orchestrator. When the user gives you a research topic:

PHASE 1 — UNDERSTAND THE TOPIC
- Search the web briefly to understand the current landscape of the topic
- Based on what you find, ask the user 3-4 clarifying questions: scope, geography, timeline, intended use, what angle matters most to them
- Wait for their answers before proceeding

PHASE 2 — GENERATE THE RESEARCH PROMPT
Using the user's answers, generate a focused deep research prompt. Rules:
- The prompt = ONLY the research question + 3-5 sub-questions
- Maximum 300 words
- NEVER include methodology, source types, expected sections, quality checks, structure guidance, or deliverable format
- NEVER tell the research agent HOW to research — only WHAT to research
- Include this instruction: "Write all sources inline as plain text (Source Name - URL), not clickable links"
- End with: DON'T FORGET THIS IS A DEEP RESEARCH. NEVER LIMIT WEB SEARCH TO AVOID SPENDING TOKENS. RESEARCH PROPERLY WITHOUT TRYING TO OPTIMIZE TOKEN SPENDING
- Show the prompt to the user for approval before proceeding

PHASE 3 — FAN OUT TO PROVIDERS
Generate a run ID at the start: {YYYYMMDD}-{HHMM}-{topic-slug} using current UTC time (e.g., 20260312-2350-ai-agent-frameworks). This is the directory name for the entire run. You will remember this in context for all subsequent steps.

Create ~/research-reports/{run-id}/ and start deep research in each provider one at a time (browser relay controls one tab at a time):
1. Open Claude (claude.ai), paste the prompt, start deep research
2. Open ChatGPT (chatgpt.com), paste the prompt, start deep research
3. Open Gemini (gemini.google.com), paste the prompt, start deep research

Then track and poll for completion:
- Before starting the first provider, write ~/research-reports/{run-id}/status.json with the run_id, started_at_utc, poll_cron_id (null), the approved prompt text, current phase ("starting"), and empty provider slots (status "pending", targetId null for each).
- After each provider is started, immediately update status.json with that provider's targetId. This way if the session is interrupted mid-startup, you keep the targetIds already collected.
- Once all three are started, update phase to "polling". status.json now contains ALL state needed to resume after interruption:
  {"run_id": "...", "started_at_utc": "...", "poll_cron_id": "...", "phase": "polling", "prompt": "...", "providers": {"claude": {"status": "pending", "targetId": "..."}, "chatgpt": {"status": "pending", "targetId": "..."}, "gemini": {"status": "pending", "targetId": "..."}}}
- This file is the source of truth. If the user sends a message, runs /compact, or context is lost for any reason, ALWAYS read status.json first to recover full state before continuing. If phase is "starting" and some providers have null targetIds, resume launching from where you left off using the saved prompt.

Schedule the polling via cron so it runs automatically in the main session (the user's chat), even if the user is idle or context is compacted:
- First check: `cron add --session main --at {now + 8 minutes ISO 8601} --system-event "Deep research poll: read ~/research-reports/{run-id}/status.json and check pending providers"`
  This one-shot cron auto-deletes after firing.
- When the first check fires: the agent wakes in the main session, reads status.json, checks each pending provider.
  If providers are still "pending": create a single recurring job:
  `cron add --session main --every 120000 --system-event "Deep research poll: read ~/research-reports/{run-id}/status.json and check pending providers"`
  Save the returned cron job ID to status.json as poll_cron_id.
- Every 2 minutes, the recurring cron wakes the agent in the main session. The user will see these check cycles in their chat.
- Once all providers are "done" or "partial": `cron remove {poll_cron_id}` and proceed to Phase 4.

On each check cycle (triggered by cron):
  1. Read status.json to get current state
  2. For each provider still "pending": focus its tab by targetId, take a snapshot, check if the research response is fully visible with no loading indicator
  3. If done: save output to ~/research-reports/{run-id}/{provider}.md, update status in status.json to "done"
  4. If still running: leave as "pending"
  5. If "pending" for more than 30 minutes (compare current UTC to started_at_utc): save partial output, mark "partial" in status.json
- Once all providers are "done" or "partial", proceed to Phase 4

PHASE 4 — SYNTHESIZE
Read all three saved outputs. Produce:

A) Ultra-short TL;DR for each provider
- 2-4 bullets per provider
- Max ~12 words per bullet
- Format:

Claude - TL;DR
- ...

ChatGPT - TL;DR
- ...

Gemini - TL;DR
- ...

B) Final conclusion
- Compare where providers agree and differ
- Do quick web searches to verify any disputed claims
- Pick the conclusion best supported by current evidence
- Format:

Final conclusion (one short sentence):
- ...

Why this is the best conclusion (2-4 bullets):
- ...

Key disagreement across providers (optional, 1-3 bullets):
- ...

Add source URLs in parentheses where relevant.
No intro, no outro, no text outside this structure.
```

## 实际示例

参见下方的[流程图](#流程图)了解完整的操作演示。

## 关键要点

- **使用强力模型（Opus 级别）**进行整个编排。它需要善于搜索、提出好的澄清问题、生成精准的提示词，以及综合大量输出。这不是快速/廉价模型能胜任的工作。
- **不要跳过澄清问题阶段。**一个范围明确的提示词能给你三份出色的报告。一个模糊的提示词只能给你三份平庸的报告。
- **status.json 能从中断中恢复。**轮询阶段可能持续 10-30 分钟。如果你发送了消息、执行了 /compact、或者上下文被截断，智能体通过读取 status.json 恢复——所有状态（运行 ID、targetId、时间戳、完成状态）都存储在磁盘上，而不是上下文中。
- **不要用子智能体做轮询。**你可能会考虑生成一个子智能体来处理轮询循环，同时让主智能体保持空闲。但两者都需要浏览器访问权限，而浏览器中继一次只能控制一个标签页——两个智能体争夺标签页焦点会冲突。把所有操作保留在主智能体中，用 status.json 作为恢复机制。
- **浏览器中继冲突。**如果其他会话或智能体在你的研究运行期间使用同一个 Chrome 中继配置文件，它们可能会在检查过程中抢走标签页焦点或导航离开某个平台标签页。请使用一个只有此工作流使用的专用 Chrome 配置文件，在轮询阶段不要运行其他依赖浏览器的任务。

## 服务条款提示

控制已登录会话的浏览器自动化可能违反某些平台的服务条款。在使用此工作流之前，请查阅每个平台（Claude、ChatGPT、Gemini）的服务条款，确认是否允许自动化浏览器交互。如果某个平台的服务条款禁止自动化访问，请勿对该平台使用此方法。您对自己的合规行为负全部责任。

## 相关链接

- [OpenClaw 浏览器工具](https://docs.openclaw.ai/tools/browser)
- [OpenClaw Chrome 扩展指南](https://docs.openclaw.ai/tools/chrome-extension)
- [OpenClaw](https://github.com/openclaw/openclaw)

## 流程图

```text
┌─────────────────────────────────────────────────────────┐
│                    用户消息                              │
│  "深度研究 AI 智能体框架在生产环境中的                   │
│   当前状态"                                             │
└─────────────────────┬───────────────────────────────────┘
                      │
                      ▼
┌─────────────────────────────────────────────────────────┐
│              阶段 1 — 理解主题                          │
│                                                         │
│  主智能体（Opus 级别）在单个会话中运行                   │
│                                                         │
│  1. web_search "AI agent frameworks production 2026"    │
│  2. 发现：OpenClaw, LangGraph, CrewAI, AutoGen 等       │
│  3. 向用户提问：                                        │
│     - 是为特定项目评估还是做概览？                      │
│     - 仅限自托管，还是也包括云端托管？                  │
│     - 关注重点：价格、企业支持、社区？                  │
│     - 时间范围：近 3 个月、6 个月还是一年？              │
│  4. 等待用户回答                                        │
└─────────────────────┬───────────────────────────────────┘
                      │ 用户回答：
                      │ "做概览，两种部署方式都要，
                      │  重点关注社区规模和文档质量，
                      │  时间范围最近 6 个月"
                      ▼
┌─────────────────────────────────────────────────────────┐
│           阶段 2 — 生成研究提示词                       │
│                                                         │
│  生成 ≤300 词的提示词，例如：                           │
│                                                         │
│  "截至 2026 年初，AI 智能体框架在生产环境              │
│   中的使用现状如何？                                    │
│   1. 哪些框架拥有最活跃的社区和最好的文档？            │
│   2. 自托管和云端托管对比如何？                        │
│   3. 最近 6 个月发生了哪些变化？                       │
│   4. 哪些真正在生产环境中使用，而不仅仅是演示？        │
│   ..."                                                 │
│                                                         │
│  展示给用户 → 用户确认                                  │
└─────────────────────┬───────────────────────────────────┘
                      │ 用户确认
                      ▼
┌─────────────────────────────────────────────────────────┐
│         阶段 3a — 启动各平台研究                       │
│                                                         │
│  生成运行 ID：20260312-1430-ai-agent-frameworks         │
│  创建 ~/research-reports/20260312-1430-ai-agent-        │
│         frameworks/                                     │
│                                                         │
│  写入 status.json（空平台槽位）：                       │
│  {"run_id":"...","providers":{"claude":                 │
│   {"status":"pending","targetId":null},...}}            │
│                                                         │
│  ┌───────────────────────────────────────────┐          │
│  │ 浏览器中继（一次控制一个标签页）           │          │
│  │                                           │          │
│  │  1. 聚焦 Claude 标签页 → 粘贴提示词       │          │
│  │     → 点击深度研究 → 开始                  │          │
│  │     → 用 targetId 更新 status.json         │          │
│  │                                           │          │
│  │  2. 聚焦 ChatGPT 标签页 → 粘贴提示词      │          │
│  │     → 点击深度研究 → 开始                  │          │
│  │     → 用 targetId 更新 status.json         │          │
│  │                                           │          │
│  │  3. 聚焦 Gemini 标签页 → 粘贴提示词       │          │
│  │     → 点击深度研究 → 开始                  │          │
│  │     → 用 targetId 更新 status.json         │          │
│  └───────────────────────────────────────────┘          │
│                                                         │
│  最终 status.json：                                     │
│  {                                                      │
│    "run_id": "20260312-1430-ai-agent-frameworks",       │
│    "started_at_utc": "2026-03-12T14:30:00Z",            │
│    "poll_cron_id": null,                                │
│    "providers": {                                       │
│      "claude":  {"status":"pending",                    │
│                  "targetId":"target-abc-123"},          │
│      "chatgpt": {"status":"pending",                    │
│                  "targetId":"target-def-456"},          │
│      "gemini":  {"status":"pending",                    │
│                  "targetId":"target-ghi-789"}           │
│    }                                                    │
│  }                                                      │
│                                                         │
│  调度首次检查：                                         │
│  cron add --session main                                │
│    --at "2026-03-12T14:38:00Z"                          │
│    --system-event "Deep research poll: read             │
│      ~/research-reports/20260312-1430-ai-agent-         │
│      frameworks/status.json and check pending"          │
│                                                         │
│  告知用户："三个平台均已启动研究。我将在 8 分钟后      │
│  检查进度。你可以继续聊天。"                            │
└─────────────────────┬───────────────────────────────────┘
                      │
                      │  （用户可自由活动 8 分钟）
                      │  （cron 在 14:38 UTC 触发）
                      ▼
┌─────────────────────────────────────────────────────────┐
│         阶段 3b — cron 驱动的轮询循环                   │
│                                                         │
│  ┌────────────────────────────────────────────────┐     │
│  │  调度（通过 OpenClaw cron 工具）               │     │
│  │  所有 cron 任务在 --session main 中运行         │     │
│  │  （用户的聊天会话，非隔离会话）                 │     │
│  │                                                │     │
│  │  14:38 — 一次性 cron 触发（触发后自动删除）    │     │
│  │    → 智能体在主聊天中唤醒                      │     │
│  │    → 执行首次检查循环（见下方）                │     │
│  │                                                │     │
│  │  结果：Claude 完成，ChatGPT/Gemini 待完成       │     │
│  │                                                │     │
│  │  → cron add --session main --every 120000      │     │
│  │    --system-event "Deep research poll: ..."    │     │
│  │  → 将 cron ID "cron-poll-xyz" 保存到          │     │
│  │    status.json                                │     │
│  │                                                │     │
│  │  14:40 — 周期性 cron 触发                      │     │
│  │    → ChatGPT 完成，Gemini 仍待完成             │     │
│  │                                                │     │
│  │  14:42 — 周期性 cron 触发                      │     │
│  │    → Gemini 完成                              │     │
│  │    → cron remove "cron-poll-xyz"               │     │
│  │    → 进入阶段 4                               │     │
│  └────────────────────────────────────────────────┘     │
│                                                         │
│  ┌────────────────────────────────────────────────┐     │
│  │              检查循环                          │     │
│  │  （每次 cron 触发时执行）                       │     │
│  │                                                │     │
│  │  1. 读取 status.json（唯一真实状态源）          │     │
│  │                                                │     │
│  │  2. 对每个 status="pending" 的平台：           │     │
│  │     ┌──────────────────────────────────┐       │     │
│  │     │ 通过 targetId 聚焦标签页         │       │     │
│  │     │ 截取快照                         │       │     │
│  │     │                                  │       │     │
│  │     │ 是否可见加载指示器？             │       │     │
│  │     │   是 → 保持 "pending"            │       │     │
│  │     │   否 → 响应已完成               │       │     │
│  │     │       保存 {provider}.md         │       │     │
│  │     │       更新状态为 "done"          │       │     │
│  │     │                                  │       │     │
│  │     │ 距 started_at_utc 超过 30 分钟？  │       │     │
│  │     │   是 → 保存部分输出              │       │     │
│  │     │       更新状态为 "partial"       │       │     │
│  │     └──────────────────────────────────┘       │     │
│  │                                                │     │
│  │  3. 写入更新后的 status.json                  │     │
│  │                                                │     │
│  │  4. 全部完成/部分完成？                        │     │
│  │     是 → cron remove {poll_cron_id}           │     │
│  │          → 进入阶段 4                         │     │
│  │     否 → cron 继续运行，2 分钟后下次检查      │     │
│  └────────────────────────────────────────────────┘     │
│                                                         │
│  ┌────────────────────────────────────────────────┐     │
│  │         中断处理                               │     │
│  │                                                │     │
│  │  用户在轮询期间发送消息：                      │     │
│  │    → 智能体回复消息                           │     │
│  │    → 下次 cron 触发时读取 status.json          │     │
│  │    → 轮询自动继续                             │     │
│  │                                                │     │
│  │  执行 /compact 或上下文被截断：                │     │
│  │    → 智能体丢失内存中的状态                    │     │
│  │    → 下次 cron 触发时读取 status.json          │     │
│  │    → 智能体从文件中恢复所有状态                │     │
│  │                                                │     │
│  │  status.json 包含：run_id, started_at_utc,     │     │
│  │  poll_cron_id, 所有 targetId, 所有状态         │     │
│  │  → 智能体总能重建完整状态                     │     │
│  └────────────────────────────────────────────────┘     │
└─────────────────────┬───────────────────────────────────┘
                      │ 全部 "done" 或 "partial"
                      ▼
┌─────────────────────────────────────────────────────────┐
│              阶段 4 — 综合结论                          │
│                                                         │
│  从 ~/research-reports/20260312-1430-ai-agent-           │
│            frameworks/ 读取：                            │
│    ├── claude.md    （完成 — 完整报告）                 │
│    ├── chatgpt.md   （完成 — 完整报告）                 │
│    └── gemini.md    （完成 — 完整报告）                 │
│                                                         │
│  生成输出：                                             │
│                                                         │
│  Claude - TL;DR                                         │
│  - LangGraph 在生产环境采用率中领先                     │
│  - CrewAI 文档最好，学习曲线最短                        │
│                                                         │
│  ChatGPT - TL;DR                                        │
│  - OpenClaw 在开发者心智份额中占主导                   │
│  - AutoGen 在企业端较强，社区较弱                       │
│                                                         │
│  Gemini - TL;DR                                         │
│  - CrewAI + LangGraph 最具生产就绪性                    │
│  - 新入局者快速崛起（Mastra, Agno）                     │
│                                                         │
│  最终结论：                                             │
│  截至 2026 年初，LangGraph 和 CrewAI 是最具生产就绪性  │
│  的框架，拥有最强大的社区。                             │
│                                                         │
│  原因：三个平台都将它们排在前两名；                    │
│  通过 GitHub stars + 近期发布节奏验证。                  │
│                                                         │
│  主要分歧：Claude 对 OpenClaw 的开发者心智份额评价      │
│  更高，Gemini 强调了其他平台忽略的新入局者。             │
│                                                         │
│  以结构化格式输出给用户                                 │
└─────────────────────────────────────────────────────────┘
```
