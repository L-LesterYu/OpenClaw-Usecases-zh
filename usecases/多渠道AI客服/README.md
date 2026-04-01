# 多渠道 AI 客服平台

小企业需要在多个应用间管理 WhatsApp、Instagram DM、邮件和 Google 评论。客户期望 24/7 即时响应，但雇佣全天候覆盖的员工成本高昂。

这个用例将所有客户触点整合到一个 AI 驱动的收件箱中，代表你智能回复。

## 功能介绍

- **统一收件箱**：WhatsApp Business、Instagram DM、Gmail 和 Google 评论集中在一处
- **AI 自动回复**：自动处理常见问题、预约请求和常规咨询
- **人工转接**：将复杂问题升级或标记为待审核
- **测试模式**：在不影响真实客户的情况下向客户演示系统
- **业务上下文**：基于你的服务、定价和政策进行训练

## 真实业务案例

在 Futurist Systems，我们为本地服务企业（餐厅、诊所、美容院）部署此方案。一家餐厅将响应时间从 4 小时以上缩短到 2 分钟以内，80% 的咨询由系统自动处理。

## 所需技能

- WhatsApp Business API 集成
- Instagram Graph API（通过 Meta Business）
- `gog` CLI，用于 Gmail
- Google Business Profile API，用于评论
- AGENTS.md 中的消息路由逻辑

## 设置方法

1. **连接渠道**，通过 OpenClaw 配置：
   - WhatsApp Business API（通过 360dialog 或官方 API）
   - Instagram 通过 Meta Business Suite
   - Gmail 通过 `gog` OAuth
   - Google Business Profile API token

2. **创建业务知识库**：
   - 服务和定价
   - 营业时间和地址
   - FAQ 回复
   - 升级触发条件（例如，投诉、退款请求）

3. **在 AGENTS.md 中配置**路由逻辑：

```text
## Customer Service Mode

When receiving customer messages:

1. Identify channel (WhatsApp/Instagram/Email/Review)
2. Check if test mode is enabled for this client
3. Classify intent:
   - FAQ → respond from knowledge base
   - Appointment → check availability, confirm booking
   - Complaint → flag for human review, acknowledge receipt
   - Review → thank for feedback, address concerns

Response style:
- Friendly, professional, concise
- Match the customer's language (ES/EN/UA)
- Never invent information not in knowledge base
- Sign off with business name

Test mode:
- Prefix responses with [TEST]
- Log but don't send to real channels
```

4. **设置心跳检查**，用于响应监控：

```text
## Heartbeat: Customer Service Check

Every 30 minutes:
- Check for unanswered messages > 5 min old
- Alert if response queue is backing up
- Log daily response metrics
```

## 核心洞察

- **语言检测很重要**：自动检测并使用客户的语言回复
- **测试模式是必须的**：客户需要在上线前看到系统运行效果
- **转接规则**：定义清晰的升级触发条件，避免 AI 越界
- **回复模板**：为敏感话题（退款、投诉）准备预先批准的模板

## 相关链接

- [WhatsApp Business API](https://developers.facebook.com/docs/whatsapp)
- [Instagram Messaging API](https://developers.facebook.com/docs/instagram-api/guides/messaging)
- [Google Business Profile API](https://developers.google.com/my-business)
