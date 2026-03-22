# YouTube 内容流水线

作为日更 YouTube 创作者，在网上和 X/Twitter 上寻找新鲜、及时的视频创意非常耗时。追踪已制作的内容可以防止重复选题，帮助你保持领先趋势。

这个工作流自动化了整个内容侦察和研究流水线：

• 每小时定时任务扫描突发 AI 新闻（网页 + X/Twitter），将视频创意推送到 Telegram
• 维护 90 天视频目录，包含观看量和主题分析，避免重复选题
• 将所有创意存储在 SQLite 数据库中，附带向量嵌入用于语义去重（你永远不会收到重复的创意）
• 当你在 Slack 中分享链接时，OpenClaw 研究主题、搜索 X 上的相关帖子、查询知识库，并创建包含完整大纲的 Asana 卡片

## 所需技能

- `web_search`（内置）
- [x-research-v2](https://clawhub.ai) 或自定义 X/Twitter 搜索技能
- [knowledge-base](https://clawhub.ai) 技能，用于 RAG
- Asana 集成（或 Todoist）
- `gog` CLI，用于 YouTube Analytics
- 用于接收创意的 Telegram 话题

## 设置方法

1. 设置一个 Telegram 话题用于视频创意，并在 OpenClaw 中配置。
2. 安装 knowledge-base 技能和 x-research 技能。
3. 创建 SQLite 数据库用于创意跟踪：
```sql
CREATE TABLE pitches (
  id INTEGER PRIMARY KEY,
  timestamp TEXT,
  topic TEXT,
  embedding BLOB,
  sources TEXT
);
```
4. 向 OpenClaw 发送指令：
```text
Run an hourly cron job to:
1. Search web and X/Twitter for breaking AI news
2. Check against my 90-day YouTube catalog (fetch from YouTube Analytics via gog)
3. Check semantic similarity against all past pitches in the database
4. If novel, pitch the idea to my Telegram "video ideas" topic with sources

Also: when I share a link in Slack #ai_trends, automatically:
1. Research the topic
2. Search X for related posts
3. Query my knowledge base
4. Create an Asana card in Video Pipeline with a full outline
```
