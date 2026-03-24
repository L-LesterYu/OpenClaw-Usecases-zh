# 61. 阅读清单策展人

## 简介

你每周都会遇到有趣的文章、视频和链接，但总是没时间去看。你的 AI 智能体可以帮你收集这些链接，按主题分类整理，并在每周五推送一份精选的"周末阅读清单"。

随时给智能体发一条链接并附上"收藏这个"——它会自动归档。周五下午，你会收到一份干净的摘要，包含你保存的所有内容，附带简介，帮你快速挑选值得花时间阅读的。

再也不用面对那些堆成山的"稍后阅读"书签了。

## 所需技能

- Web Fetch — 从 URL 中提取内容
- [Memory Management](https://clawhub.ai/skills/mem) — 存储和组织链接

## 如何设置

### 前置条件
- Telegram 或 Signal 已连接 OpenClaw

### 提示词模板
```
You are my reading list curator.

When I send you a URL with "save this" or "read later":
1. Fetch the article title and first paragraph
2. Categorize it (Tech, Business, Health, Culture, Fun, Other)
3. Save to memory/reading-list.md with date and category

Every Friday at 3 PM, send me my Weekly Reading List:

📚 Weekend Reading | [Date Range]

🤖 Tech (3 articles)
• [Title] — [2-sentence summary]
  [URL]

💼 Business (2 articles)  
• [Title] — [2-sentence summary]
  [URL]

[...other categories...]

⭐ Editor's Pick: [The one article I'd recommend most]

After sending, archive the list to memory/reading-archive/YYYY-WXX.md
and clear the active reading list.
```

### 配置
- 持续运行：随时保存你发送的链接
- 每周摘要：Cron 定时每周五下午 3 点

## 成功指标
- 不再有被遗忘的书签
- 每周实际阅读 3-5 篇文章，而不是 0 篇
- 随时间发现你的兴趣模式
