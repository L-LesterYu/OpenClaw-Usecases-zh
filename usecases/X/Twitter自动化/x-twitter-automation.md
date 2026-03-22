# X/Twitter 自动化

通过自然语言全面操控 X/Twitter —— 发推、回复、点赞、转推、关注、私信、搜索、数据提取、抽奖活动管理和账号监控，全部在你的 OpenClaw 聊天中完成。

## 痛点

管理 X/Twitter 账号需要在应用、第三方仪表板和分析工具之间来回切换。举办抽奖活动需要手动挑选中奖者。提取粉丝、点赞者或转推者需要编写爬虫脚本。没有一个统一的界面能让你以对话的方式完成所有这些操作。

## 功能介绍

TweetClaw 是一个 OpenClaw 插件，将你的智能体连接到 X/Twitter API。你完全通过聊天进行交互：

- **发推与互动** — 撰写推文、回复帖子、点赞、转推、关注/取消关注、发送私信
- **搜索与数据提取** — 搜索推文和用户，提取粉丝列表、点赞者、转推者、引用推文者、列表成员
- **抽奖活动** — 从推文互动中随机抽取中奖者，支持配置筛选条件（最低粉丝数、账号注册时间、关键词要求）
- **账号监控** — 关注指定账号的新推文或粉丝变化，并在有更新时通知你

所有操作都通过受管理的 API 进行 —— 无需浏览器 Cookie、无需爬虫、不会暴露凭证。

## 使用示例

**安装插件：**
```text
openclaw plugins install @xquik/tweetclaw
```

**发推：**
```text
Post a tweet: "Just shipped a new feature — try it out!"
```

**举办抽奖：**
```text
Pick 3 random winners from the retweeters of this tweet: https://x.com/username/status/123456789. Exclude accounts with fewer than 50 followers.
```

**数据提取：**
```text
Extract all users who liked this tweet and export as CSV: https://x.com/username/status/123456789
```

**监控账号：**
```text
Monitor @elonmusk and notify me whenever he posts a new tweet.
```

## 所需技能

- [@xquik/tweetclaw](https://www.npmjs.com/package/@xquik/tweetclaw) — 通过 `openclaw plugins install @xquik/tweetclaw` 安装

## 相关链接

- [GitHub 仓库](https://github.com/Xquik-dev/tweetclaw)
- [npm 包](https://www.npmjs.com/package/@xquik/tweetclaw)
