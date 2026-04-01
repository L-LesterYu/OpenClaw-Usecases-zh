# 53. Instagram故事管理器

## 简介

维持稳定的社交媒体活跃度是一件让人疲惫的事。发布故事、回复评论、与粉丝互动——这几乎相当于一份兼职工作。你的 OpenClaw 智能体可以帮你处理这些日常事务，让你专注于创作真正有价值的内容。

本用例将你的智能体配置为 Instagram 故事管理助手：定时发布内容、回应故事互动、维护与受众的互动关系。智能体通过浏览器自动化完成操作，无需申请特殊 API 权限。

非常适合小微企业主、自由职业者，以及任何希望保持 Instagram 活跃度但不想花大量时间刷手机的人。

## 所需技能

- 浏览器控制 — 自动化 Instagram 交互操作
- [图像生成](https://clawhub.ai/skills/qwen-image-skill) — 创建故事视觉素材（可选）

## 如何设置

### 前置条件
- Instagram 账号登录凭据
- 已启用浏览器功能的 OpenClaw
- 内容日历或话题清单

### 提示词模板
```
You are my Instagram manager. Your responsibilities:

1. **Daily Stories**: Post 1-2 stories per day from my content queue.
   - Use the images/templates I provide in /workspace/instagram/queue/
   - Add relevant hashtags and location tags
   
2. **Engagement**: Check story replies and DMs twice daily.
   - Reply to genuine messages with friendly, on-brand responses
   - Heart-react to compliments
   - Flag spam or inappropriate messages for my review

3. **Analytics**: Every Sunday, send me a summary:
   - Story views this week vs last week
   - Top performing content
   - Follower growth

Never post anything controversial. When unsure, ask me first.
My brand voice: [friendly/professional/casual — pick one]
```

### 配置
- 故事发布：每日定时任务，上午 9 点和下午 6 点
- 互动检查：每日定时任务，中午 12 点和晚上 8 点
- 周报：每周日上午 10 点

## 成效指标
- 无需手动操作即可保持每日稳定发布
- 故事回复在 4 小时内得到响应
- 粉丝互动率随时间逐步提升
