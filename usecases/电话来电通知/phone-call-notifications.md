# 电话来电通知

你的智能体已经在替你监控各种信息——股票、邮件、智能家居、日历——但通知很容易被忽视。推送通知堆积如山，聊天消息被淹没。对于那些真正重要的事情，你需要一种无法轻易划掉的通知方式。

这个用例赋予智能体一个电话通知通道。当事情足够紧急时，智能体会直接拨打你的真实电话号码，告诉你发生了什么，而且你可以实时回复。这是一次双向通话，不是机器人骚扰电话。

## 功能说明

- 智能体判断某件事值得你关注（价格警报、紧急邮件、日程提醒等）
- 智能体通过 [clawr.ing](https://clawr.ing)（一个托管式通话服务）拨打你的电话——无需配置 Twilio，无需设置 API 密钥
- 你接听电话，收听通知内容，并可以实时追问
- 对话结束后通话自动挂断

核心理念：**智能体主动打给你**，而不是你打给智能体。这可以配合心跳检测、定时任务（cron）或任何触发条件——智能体会自行判断是否值得打电话，并据此行动。

## 为什么这样设计有效

OpenClaw 智能体已经具备主动性——心跳检测、定时任务、事件触发。但它们的输出通道局限于你可能没在看的聊天平台。电话是唯一能可靠引起你注意的通知方式，尤其是当你不在电脑前的时候。

clawr.ing 负责处理通话基础设施。你只需粘贴一条设置提示，智能体就获得了拨打电话的能力。无需 Twilio 账号，无需申请电话号码，无需配置 Webhook。该服务覆盖 100+ 个国家，使用真实的 PSTN 通话（而非 VoIP 覆盖层）。

## 所需技能

- [clawr.ing](https://clawhub.ai/marcospgp/clawring) — 将 [clawr.ing 控制面板](https://clawr.ing)中的设置提示粘贴到你的 OpenClaw 聊天中即可完成安装。无需命令行安装。

仅此一项，没有其他依赖。设置提示中包含 API 密钥和技能文档链接——智能体读取后会自行理解并配置。

## 示例：晨间简报来电

设置一个定时任务，每天早上给你打电话发送个性化简报：

```
Every weekday at 7:30 AM, call me with a morning briefing. Include:
- Weather forecast for my city
- My calendar for today
- Any urgent emails that came in overnight
- Top 3 news headlines relevant to my interests

Keep it concise — aim for under 2 minutes. If I ask questions, answer them.
If I don't pick up, don't retry.
```

## 示例：价格警报

告诉智能体监控什么，以及何时打电话：

```
Monitor NVDA stock price. If it drops more than 5% in a single day,
call me immediately and tell me what happened. Include any relevant
news that might explain the drop.
```

## 示例：紧急邮件过滤

```
During business hours, check my inbox every 15 minutes.
If you see an email from my boss or any email marked urgent,
call me with a summary. For everything else, just send a chat message.
```

## 核心要点

- **不要滥用。** 电话通知的意义就在于"这件事真的很重要"。如果你的智能体每天给你打 10 次电话，你会开始无视它。明确设定什么情况值得打电话，什么情况用聊天就够了。
- **配合心跳检测或定时任务使用。** clawr.ing 是投递通道——你仍然需要一个触发器。心跳检测（每 30 分钟一次）适合监控任务，定时任务适合定时简报。
- **双向通话。** 与推送通知不同，你可以在通话中追问。"等等，是哪封邮件？" 或 "现在价格是多少？"——智能体会实时回答。
- **为通话选择快速模型。** 电话对话需要快速响应。如果你的 OpenClaw 支持技能级别的模型路由，建议将 clawr.ing 分配给快速模型（如 Haiku 级别）。提示音可以掩盖延迟，但越快越好。
- **隐私保护。** clawr.ing 不会存储录音或通话记录。音频在传输过程中加密，处理完成后立即丢弃。

## 相关链接

- [clawr.ing](https://clawr.ing)
- [clawr.ing on ClawHub](https://clawhub.ai/marcospgp/clawring)
- [OpenClaw](https://github.com/openclaw/openclaw)
