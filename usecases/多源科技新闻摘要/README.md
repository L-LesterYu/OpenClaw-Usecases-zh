# 多源科技新闻摘要

自动聚合、评分并推送来自 109+ 信源的科技新闻，涵盖 RSS、Twitter/X、GitHub 发布和网页搜索——全部通过自然语言管理。

## 痛点

想要持续关注 AI、开源和前沿科技动态，每天需要在数十个 RSS 订阅源、Twitter 账号、GitHub 仓库和新闻网站之间来回切换。人工整理耗时费力，而现有工具要么缺乏质量过滤，要么需要复杂的配置。

## 功能说明

一套按计划运行的四层数据处理管线：

1. **RSS 订阅源**（46 个来源）— OpenAI、Hacker News、MIT 科技评论等
2. **Twitter/X KOL**（44 个账号）— @karpathy、@sama、@VitalikButerin 等
3. **GitHub 发布**（19 个仓库）— vLLM、LangChain、Ollama、Dify 等
4. **网页搜索**（4 个主题搜索）— 通过 Brave Search API

所有文章经过合并、基于标题相似度去重，并进行质量评分（优先来源 +3、多来源覆盖 +5、时效性 +2、互动量 +1）。最终摘要推送到 Discord、邮件或 Telegram。

该框架完全可定制——30 秒即可添加你自己的 RSS 订阅源、Twitter 账号、GitHub 仓库或搜索关键词。

## 提示词

**安装并设置每日摘要：**
```text
Install tech-news-digest from ClawHub. Set up a daily tech digest at 9am to Discord #tech-news channel. Also send it to my email at myemail@example.com.
```

**添加自定义来源：**
```text
Add these to my tech digest sources:
- RSS: https://my-company-blog.com/feed
- Twitter: @myFavResearcher
- GitHub: my-org/my-framework
```

**按需生成：**
```text
Generate a tech digest for the past 24 hours and send it here.
```

## 所需技能

- [tech-news-digest](https://clawhub.ai/skills/tech-news-digest) — 通过 `clawhub install tech-news-digest` 安装
- [gog](https://clawhub.ai/skills/gog)（可选）— 通过 Gmail 发送邮件

## 环境变量（可选）

- `X_BEARER_TOKEN` — Twitter/X API bearer token，用于 KOL 监控
- `BRAVE_API_KEY` — Brave Search API 密钥，用于网页搜索层
- `GITHUB_TOKEN` — GitHub token，用于提高 API 速率限制

## 相关链接

- [GitHub 仓库](https://github.com/draco-agent/tech-news-digest)
- [ClawHub 页面](https://clawhub.ai/skills/tech-news-digest)
