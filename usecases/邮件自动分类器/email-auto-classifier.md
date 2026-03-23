---
title: 'OpenClaw 邮件自动分类器：在收件箱过载前优先处理紧急消息'
slug: email-auto-classifier
summary: 将收件邮件自动分类为紧急、常规和垃圾邮件，仅推送时间敏感的消息，帮助你更快响应高优先级事项。
whatItDoes: 基于规则的邮件分拣与紧急优先告警，让用户专注于高优先级消息。
category: support-success
difficulty: intermediate
tags:
  - email-triage
  - urgent-alerting
  - inbox-automation
  - priority-routing
targetUser:
  - 工程经理
  - 客户支持负责人
skillsUsed:
  - name: AgentMail Wrapper
    href: https://clawhub.ai/skills/agentmail-wrapper
updatedAt: '2026-03-12'
published: true
---

## 功能说明
- 按固定间隔检查收件箱新消息。
- 使用透明规则将邮件分类为紧急、常规和垃圾邮件。
- 优先推送紧急通知，非紧急消息路由至低优先级分类。

## 所需技能
- [AgentMail Wrapper](https://clawhub.ai/skills/agentmail-wrapper)

## 痛点
当收件箱量激增时，重要邮件往往被埋没在订阅邮件和低价值更新之中。手动分类不仅效率低下，还容易遗漏或延迟处理需要即时回复的关键消息。

## 核心价值
本案例在人工审阅之前创建了一层可重复使用的邮件分拣机制。它减少了注意力碎片化，提升了紧急通信的响应速度，并在高邮件量下保持收件箱操作的稳定性。

## 典型场景
- 清晨收件箱分拣，处理隔夜累积的邮件。
- 需要快速升级会议变更或截止日期敏感请求的团队。
- 希望将常规订阅与需处理的通信分离的个人用户。

## 设置指南
1. 定义分类规则（关键词、发件人优先级、回复截止信号）。
2. 运行定期收件箱扫描（例如每 15 分钟一次）。
3. 将输出路由至对应文件夹，并为高优先级匹配触发紧急告警。

## 相关链接
- [OpenClaw 文档：Gmail Pub/Sub](https://docs.openclaw.ai/automation/gmail-pubsub.md)

## 常见问题
### 仅支持 Gmail 吗？
不是。分拣逻辑与邮件服务商无关；Gmail 只是其中一个文档化的集成路径。

### 是否应该完全自动化？
对于边缘情况通常不建议完全自动化。保持紧急标准明确，并定期审查误报情况。

### 如何减少误触发的紧急告警？
从严格的紧急模式和可信发件人开始，然后根据审查反馈逐步扩展规则。
