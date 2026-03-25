# AI 驱动的学习流水线

将 OpenClaw 变成你的私人导师，每天教你一个跨学科的新概念——自动管理课程体系、追踪学习进度，并支持间隔重复。

## 痛点

你想深入学习一个新领域（机器学习论文、生物学等），但是：
- 阅读清单越堆越多，从未动过
- 坚持几天就失去动力
- 没有人能用你的理解水平来讲解
- 在"找资料"和"实际学习"之间来回切换，严重打断专注

如果你的智能体能直接*教你*呢——每天一小课，根据你已有的知识量体裁衣？

## 功能介绍

- 维护多个学习方向的课程体系（如"伊利亚·苏斯克维推荐的 30 篇必读论文"、"生物学 × AI 基础"）
- 每天按计划时间通过 Telegram 推送一节课
- 每节课：从问题切入、用类比解释核心概念、链接原始资料、并与你已有知识建立联系
- 用 JSON 文件追踪进度（当前索引、完成日期）
- 搜索并链接真实的 YouTube 讲座和讲解视频（经网络搜索验证）
- 可选集成 NotebookLM 进行源资料管理

## 示例：每日论文精读

一个定时任务每天中午运行。智能体：

1. 读取 `memory/ilya-30-papers.json` → 找到下一篇论文
2. 获取原始论文，在 `~/second-brain/ilya-30/` 中撰写详细学习笔记
3. 发送 Telegram 消息：

```
📄 第14/30篇 — "Attention Is All You Need" (Vaswani et al., 2017)

为什么重要：在 Transformer 出现之前，序列建模由 RNN 主导……

核心思想：
- 自注意力机制让每个位置可以同时关注所有其他位置
- 位置编码保留了顺序信息
- 多头注意力同时捕捉多种关系

对现代 AI 的影响：GPT、BERT，以及正在给你发消息的这个智能体……

📓 详细学习笔记：~/second-brain/ilya-30/14-attention-is-all-you-need.md

有问题随时回复——我会记住上下文，下次继续深入。
```

## 示例：多学科并行课程

你可以同时运行多个学习方向：

| 学习方向 | 计划时间 | 教学内容 |
|---------|---------|---------|
| 伊利亚 30 篇论文 | 每天 12:00 | AI/ML 基础论文 |
| 生物 × AI | 每天 13:00 | 与 AI 相关的生物学概念（DNA→蛋白质、进化、神经科学） |
| 法律 AI 监控 | 每天 09:00 | 计算法与 AI 监管的最新进展 |

每个方向有独立的课程文件、进度追踪器和推送计划。

## 提示词

### 搭建论文阅读方向

```text
I want to study Ilya Sutskever's recommended 30 papers, one per day.

Create a JSON file at memory/ilya-30-papers.json with all 30 papers 
(title, authors, year, url) and a current_index starting at 0.

Every day at noon, pick the next paper and send me a lesson via Telegram:
- Why this paper matters (historical context)
- Core ideas explained for a non-specialist
- How it connects to modern AI
- Link to the original paper
- A detailed study note saved to ~/second-brain/ilya-30/

After sending, increment current_index.
```

### 搭建基于课程的学习方向

```text
I want to learn biology fundamentals relevant to AI — DNA, proteins, 
evolution, neuroscience, longevity research.

Create a 30-lesson curriculum in memory/bio-ai-curriculum.md.
Track progress in memory/bio-ai-progress.json.

Every day at 1pm, teach me the next lesson:
- Start with a problem or question
- Explain in 3-5 sentences, use analogies
- Include 1-2 verified YouTube links
- Connect to what I already know (information theory, law, previous lessons)
- End with "curious about anything? ask me"

Keep it under 2000 chars — one Telegram message.
```

### 集成 NotebookLM 进行源资料管理

```text
For each learning track, create a NotebookLM notebook and load 
the source papers/textbooks. Use it for deeper Q&A when I ask 
follow-up questions about a lesson.
```

## 所需技能

- **Cron** — 定时推送每日课程
- **Web Search** — 搜索和验证 YouTube 讲座、论文链接
- **Telegram**（或任何消息渠道）— 推送课程
- **File management** — 追踪进度、存储学习笔记
- **NotebookLM**（可选）— 通过 CLI 进行深度源资料管理

## 使用建议

- 先从一个方向开始。养成习惯后再添加更多。
- 对课程内容回复提问——智能体会记住上下文，可以继续深入。
- 保持课程简短（2000 字以内）。你随时可以要求更详细的讲解。
- 智能体在发送前会通过网络搜索验证所有 YouTube 链接——不会出现失效链接。
- JSON 进度文件让暂停、恢复或跳过都变得非常简单。

## 适合谁用

任何想系统学习一个新领域但难以坚持的人。尤其适用于：
- 进入新领域的研究者
- 转型者构建基础知识
- 任何有一份永远读不完的阅读清单的人
