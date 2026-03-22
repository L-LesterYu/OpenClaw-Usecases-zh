# 活动嘉宾确认

你正在筹办一场活动——晚宴、婚礼、公司团建——需要逐一确认嘉宾出席情况。手动拨打 20 多个电话既繁琐又低效：你可能在电话捉迷藏中浪费时间，忘记谁说了什么，还可能遗漏饮食禁忌或携带同伴等细节。发短信虽然方便，但人们经常忽略消息。而一通真实的电话往往能获得更高的回复率。

本用例通过 [SuperCall](https://clawhub.ai/xonder/supercall) 插件让 OpenClaw 逐一拨打嘉宾电话，确认出席情况，收集备注信息，并为你汇总整理所有结果。

## 功能说明

- 遍历嘉宾名单（姓名 + 电话号码）并逐一拨打电话
- AI 以友好的人设身份自我介绍，担任你的活动协调员
- 与嘉宾确认活动的日期、时间和地点
- 询问对方是否出席，并收集备注信息（饮食需求、携带同伴、到达时间等）
- 所有电话完成后，生成汇总报告：已确认名单、已婉拒名单、未接听名单，以及各项备注

## 为什么选择 SuperCall

本用例专门配合 [SuperCall](https://clawhub.ai/xonder/supercall) 插件使用——而非内置的 `voice_call` 插件。关键区别在于：SuperCall 是一个完全独立的语音智能体。通话中的 AI 角色仅拥有你提供的上下文信息（角色名称、目标和开场白）。它无法访问你的 Gateway 智能体、文件、工具或其他任何资源。

对于嘉宾确认场景，这一点尤为重要：

- **安全性**：电话另一端的人无法通过对话操纵或访问你的智能体。不存在提示注入或数据泄露的风险。
- **更好的对话体验**：由于 AI 的职责被限定为单一聚焦任务（确认出席），它比通用语音智能体更能保持话题集中，对话也更自然流畅。
- **批量友好**：你需要拨打多个不同对象的电话。每次通话都独立重置的沙盒化角色正是你所需要的——对话之间不会有任何信息串扰。

## 所需技能

- [SuperCall](https://clawhub.ai/xonder/supercall) — 通过 `openclaw plugins install @xonder/supercall` 安装
- Twilio 账号及电话号码（用于拨打外呼电话）
- OpenAI API 密钥（用于 GPT-4o 实时语音 AI）
- ngrok（用于 Webhook 隧道——免费版即可）

完整配置说明请参阅 [SuperCall README](https://github.com/xonder/supercall)。

## 配置步骤

1. 按照 [配置指南](https://github.com/xonder/supercall#configuration) 安装并配置 SuperCall。确保你的 OpenClaw 配置中已启用 Hooks。

2. 准备嘉宾名单。你可以直接粘贴到聊天中，也可以保存在文件里：

```text
Guest List — Summer BBQ, Saturday June 14th, 4 PM, 23 Oak Street

- Sarah Johnson: +15551234567
- Mike Chen: +15559876543
- Rachel Torres: +15555551234
- David Kim: +15558887777
```

3. 向 OpenClaw 发送提示：

```text
我需要你帮我确认活动的嘉宾出席情况。以下是活动详情：

活动：夏季烧烤派对
日期：6月14日（星期六）下午4点
地点：23 Oak Street

以下是我的嘉宾名单：
<paste your guest list here>

请使用 supercall 逐一拨打每位嘉宾的电话。通话角色设定为"Jamie，[你的名字]的活动协调员"。
每次通话的目标是确认对方是否出席，并记录饮食禁忌、携带同伴或其他备注。

每次通话结束后，记录结果。所有电话完成后，请给我一份完整的汇总：
- 已确认出席的嘉宾
- 已婉拒的嘉宾
- 未接听的嘉宾
- 每位嘉宾的备注或特殊要求
```

4. OpenClaw 将使用 SuperCall 逐一拨打嘉宾电话，然后汇总结果。你可以随时询问进度更新。

## 要点提示

- **先从小规模测试开始**：先用 2-3 位嘉宾测试，确保角色设定和开场白听起来合适。在拨打完整名单之前调整语气和措辞。
- **注意拨打电话的时段**：不要在太早或太晚的时间拨打电话。你可以告诉 OpenClaw 只在特定时间段内拨打。
- **查看通话记录**：SuperCall 会将通话记录保存到 `~/clawd/supercall-logs`。第一批电话完成后，浏览一下记录，了解对话效果如何。
- **未接听处理**：如果对方没有接听，OpenClaw 会记录下来，你可以决定稍后重拨还是通过短信跟进。
- **真实电话会产生费用**：每通电话都会消耗 Twilio 通话时长。请在 Twilio 账号中设置适当的额度限制，尤其是嘉宾名单较大时。

## 相关链接

- [SuperCall on ClawHub](https://clawhub.ai/xonder/supercall)
- [SuperCall on GitHub](https://github.com/xonder/supercall)
- [Twilio Console](https://console.twilio.com)
- [OpenAI Realtime API](https://platform.openai.com/docs/guides/realtime)
- [ngrok](https://ngrok.com)
