# YouTube 内容制作流水线

作为日更 YouTube 创作者，在网上和 X/Twitter 上寻找新鲜、及时的视频创意非常耗时。追踪已制作的内容可以防止重复选题，帮助你保持领先趋势。

这个工作流自动化了整个内容侦察和研究流水线：

• 每小时定时任务扫描突发 AI 新闻（网页 + X/Twitter），将视频创意推送到 Telegram
• 维护 90 天视频目录，包含观看量和主题分析，避免重复选题
• 将所有创意存储在 SQLite 数据库中，附带向量嵌入用于语义去重（确保永远不会收到重复的创意）
• 当你在 Slack 中分享链接时，OpenClaw 会自动研究主题、搜索 X 上的相关帖子、查询知识库，并创建包含完整大纲的 Asana 任务卡片

## 所需技能

- `web_search`（内置）
- [x-research-v2](https://clawhub.ai) 或自定义 X/Twitter 搜索技能
- [knowledge-base](https://clawhub.ai) 技能，用于 RAG
- Asana 集成（或 Todoist）
- `gog` CLI，用于 YouTube Analytics
- 用于接收创意的 Telegram 话题

## 设置方法

1. 设置一个 Telegram 话题用于视频创意，并在 OpenClaw 中配置。
2. 安装 `knowledge-base` 技能和 `x-research` 技能。
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
每小时运行一次定时任务：
1. 搜索网页和 X/Twitter 上的突发 AI 新闻
2. 与我的 90 天 YouTube 目录进行对比（通过 gog 从 YouTube Analytics 获取）
3. 与数据库中所有历史创意进行语义相似度比对
4. 如果是新创意，将创意连同来源推送到我的 Telegram "video ideas" 话题

另外：当我在 Slack #ai_trends 中分享链接时，自动执行：
1. 研究该主题
2. 搜索 X 上的相关帖子
3. 查询我的知识库
4. 在 Video Pipeline 项目中创建一张包含完整大纲的 Asana 卡片
```
