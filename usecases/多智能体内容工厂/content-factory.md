# 多智能体内容工厂

你是一位内容创作者，同时兼顾调研、写作和设计，覆盖多个平台。每一个步骤——寻找热门话题、撰写脚本、生成缩略图——都要耗费大量时间。如果有一支专业智能体团队在夜间替你完成所有工作呢？

这个工作流在 Discord 内部搭建一个多智能体内容工厂，不同的智能体在各自的专属频道中负责调研、写作和视觉素材。

## 功能概述

- **调研智能体**每天早晨扫描热门故事、竞品内容和社交媒体，寻找最佳内容机会
- **写作智能体**接收最佳选题，撰写完整脚本、推文串或邮件通讯草稿
- **缩略图智能体**为内容生成 AI 缩略图或封面图
- 每个智能体在各自的 Discord 频道中工作，保持一切井然有序且便于审查
- 按计划自动运行（例如每天早上 8 点），让你醒来就能看到成品内容

## 痛点

内容创作有三个阶段——调研、写作和设计——大多数创作者都是手动完成全部三步。即使使用了 AI 写作工具，你仍然需要逐一发出提示词。这个系统将智能体串联成一条流水线，一个智能体的输出直接作为下一个的输入，全程无需人工干预。

## 所需技能

- Discord 多频道集成
- `sessions_spawn` / `sessions_send` 多智能体编排
- [x-research-v2](https://clawhub.ai) 或类似工具，用于社交媒体调研
- 本地图像生成（如 Nano Banana）或图像生成 API
- [knowledge-base](https://clawhub.ai) 技能（可选，用于 RAG 驱动的调研）

## 设置步骤

1. 搭建一个 Discord 服务器（或者让 OpenClaw 帮你搭建——直接说"帮我创建一个 Discord 服务器"即可）。

2. 为每个智能体创建频道：
   - `#research` — 热门话题和内容机会
   - `#scripts` — 文字草稿和大纲
   - `#thumbnails` — 生成的图片和封面

3. 向 OpenClaw 发送提示词：
```text
I want you to build me a content factory inside of Discord.
Set up channels for different agents:

1. Research Agent (#research): Every morning at 8 AM, research top trending
   stories, competitor content, and what's performing well on social media
   in my niche. Post the top 5 content opportunities with sources.

2. Writing Agent (#scripts): Take the best idea from the research agent
   and write a full script/thread/newsletter draft. Post it in #scripts.

3. Thumbnail Agent (#thumbnails): Generate AI thumbnails or cover images
   for the content. Post them in #thumbnails.

Have all their work organized in different channels.
Run this pipeline automatically every morning.
```

4. 根据你的平台进行定制：
```text
I focus on X/Twitter threads, not YouTube. Change the writing agent
to produce tweet threads instead of video scripts.
```

## 核心要点

- 核心优势在于**链式智能体**——调研输出发送给写作，写作输出发送给缩略图生成。你无需为每个步骤单独发出提示词。
- Discord 频道让你可以方便地分别审查每个智能体的工作成果，并给出反馈，比如"脚本太长了"或"多关注 AI 新闻"。
- 你可以将其适配到任何内容格式：推文、邮件通讯、LinkedIn 帖文、播客大纲、博客文章。
- 使用本地模型生成图片（如在 Mac Studio 上运行 Nano Banana）可以降低成本，并提供更多控制。

## 灵感来源

受 [Alex Finn 关于改变生活的 OpenClaw 用例的视频](https://www.youtube.com/watch?v=41_TNGDDnfQ) 启发。

## 相关链接

- [OpenClaw 子智能体文档](https://github.com/openclaw/openclaw)
- [Discord 机器人设置](https://discord.com/developers/docs)
