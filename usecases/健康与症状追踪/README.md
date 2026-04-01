# 健康与症状追踪

识别食物过敏源需要持续记录饮食和身体反应，这往往难以坚持。你需要提醒来记录，也需要分析来发现规律。

这个工作流会自动追踪你的饮食和症状：

• 在专属 Telegram 话题中发送你的饮食和症状，OpenClaw 会自动带上时间戳记录一切
• 每日 3 次提醒（早、中、晚）提示你记录餐食
• 随着时间推移，自动分析规律，识别潜在的诱因

## 所需技能

- 定时任务（Cron）用于提醒
- Telegram 话题用于记录
- 文件存储（Markdown 日志文件）

## 如何设置

1. 创建一个名为 "health-tracker"（或类似名称）的 Telegram 话题。
2. 创建日志文件：`~/clawd/memory/health-log.md`
3. 向 OpenClaw 发送以下提示：
```text
When I message in the "health-tracker" topic:
1. Parse the message for food items and symptoms
2. Log to ~/clawd/memory/health-log.md with timestamp
3. Confirm what was logged

Set up 3 daily reminders:
- 8 AM: "🍳 Log your breakfast"
- 1 PM: "🥗 Log your lunch"
- 7 PM: "🍽️ Log your dinner and any symptoms"

Every Sunday, analyze the past week's log and identify patterns:
- Which foods correlate with symptoms?
- Are there time-of-day patterns?
- Any clear triggers?

Post the analysis to the health-tracker topic.
```

4. 可选：添加一个记忆文件，让 OpenClaw 追踪已知的诱因，并在规律出现时持续更新。
