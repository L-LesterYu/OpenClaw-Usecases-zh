# 播客制作流水线

你有播客创意，甚至可能有一个待录的节目主题库。但在研究嘉宾、撰写大纲、起草开场白、生成节目笔记和编写社交媒体推广文案之间——制作开销扼杀了你的动力。如果只需提交一个主题，就能获得完整的制作包呢？

这个用例将智能体串联起来处理从主题到发布就绪素材的整个播客制作工作流。

## 痛点

独立播客创作者和小团队花在制作上的时间比实际录音还多。研究需要数小时，节目笔记事后的才想起来写，社交媒体推广是最先被跳过的。创意部分——对话——可能只占总工作量的 30%。这个智能体处理剩下的 70%。

## 功能介绍

- **节目研究** — 给定主题或嘉宾姓名，整理背景研究、谈话要点和建议问题
- **大纲与脚本** — 生成结构化节目大纲，包含开场脚本、段落过渡和结束语
- **节目笔记** — 录制后，将转录文本处理为带时间戳的节目笔记，包含所有提及内容的链接
- **社交媒体素材包** — 为 X、LinkedIn 和 Instagram 创建推广帖子，包含节目亮点和金句
- **节目描述** — 编写针对 Spotify、Apple Podcasts 和 YouTube 优化的 SEO 节目描述

## 所需技能

- 网页搜索/研究技能（用于嘉宾研究和主题深入）
- 文件系统访问（用于读取转录文本和写入输出文件）
- Slack、Discord 或 Telegram 集成（用于交付素材）
- 可选：`sessions_spawn`，用于并行运行研究和写作智能体
- 可选：RSS feed 技能（用于监控竞品播客）

## 设置方法

1. 录制前——生成研究和大纲：
```text
I'm recording a podcast episode about [TOPIC]. My guest is [NAME].

Please:
1. Research the guest — their background, recent work, hot takes, and
   anything controversial or interesting they've said publicly.
2. Research the topic — key trends, recent news, common misconceptions,
   and what the audience likely already knows vs. what would surprise them.
3. Generate an episode outline:
   - Cold open hook (1-2 sentences to grab attention)
   - Intro script (30 seconds, casual tone)
   - 5-7 interview questions, ordered from easy/rapport-building to deep/provocative
   - 2-3 "back pocket" questions in case the conversation stalls
   - Closing segment with call-to-action

Save everything to ~/podcast/episodes/[episode-number]/prep/
```

2. 录制后——生成节目笔记和推广素材：
```text
Here's the transcript for Episode [NUMBER]: [paste or point to file]

Please:
1. Write timestamped show notes — every major topic shift gets a timestamp
   and one-line summary. Include links to anything mentioned (tools, books,
   articles, people).
2. Write an episode description (max 200 words) optimized for podcast
   search. Include 3-5 relevant keywords naturally.
3. Create social media posts:
   - X/Twitter: 3 tweets — one pull quote, one key insight, one question
     to spark discussion. Each under 280 chars.
   - LinkedIn: 1 post, professional tone, 100-150 words.
   - Instagram caption: 1 post with emoji, casual tone, include relevant hashtags.
4. Extract a "highlights" list — the 3 most interesting/surprising moments
   with timestamps.

Save everything to ~/podcast/episodes/[episode-number]/publish/
```

3. 可选——竞品监控：
```text
Monitor these podcast RSS feeds daily:
- [feed URL 1]
- [feed URL 2]

When a new episode drops that covers a topic relevant to my podcast,
send me a Telegram message with:
- Episode title and link
- One-sentence summary
- Whether this is something I should respond to or cover from my angle
```

## 核心洞察

- **录制前研究**是价值最大的部分。带着深入的嘉宾研究走进采访，能让对话显著提升——这是后期制作无法伪造的。
- 带时间戳的节目笔记是巨大的听众留存工具。大多数播客创作者跳过它们因为太繁琐。这个智能体让它们变得毫不费力。
- 社交媒体素材包节省了最多的**周期性**时间。每集都需要推广，而且结构总是相同的——非常适合自动化。
- 与 [多智能体内容工厂](content-factory.md) 搭配使用效果很好，如果你想把播客内容重新加工成博客文章、通讯或视频片段。

## 相关链接

- [播客 RSS Feed 规范](https://podcasters.apple.com/support/823-podcast-requirements)
- [Spotify for Podcasters](https://podcasters.spotify.com/)
- [Whisper (OpenAI)](https://github.com/openai/whisper) — 用于本地转录生成
