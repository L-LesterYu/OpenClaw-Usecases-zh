---
title: "OpenClaw AI 营养分析：通过 Haver 记录饮食照片"
slug: food-photo-nutrition-logging
summary: "本案例使用 openclaw-nutrition 技能和 Haver 后端，让用户通过聊天文字或食物照片记录饮食，自动生成每日热量和宏量营养素记录，无需手动填写日记。"
whatItDoes: "使用 openclaw-nutrition 技能配合 Haver 后端，接受文字描述或食物图片，将数据写入按日期归档的每日营养记录。"
category: automation-integration
difficulty: intermediate
tags:
  - food-photo-analysis
  - nutrition-tracking
  - meal-logging
  - calorie-logging
  - health-coaching
targetUser:
  - 营养师
  - 注重健康的用户
  - 健康产品团队
skillsUsed:
  - name: openclaw-nutrition
    href: https://clawhub.ai/Yuvasee/openclaw-nutrition
updatedAt: "2026-03-25"
published: true
---

## 功能说明

`openclaw-nutrition` 使用 Haver 后端接受文字描述或食物照片，记录热量和宏量营养素，并将条目存入按日期归档的每日营养记录中。同一流程还支持体重追踪、每日摘要和 AI 教练功能。

## 所需技能

- [openclaw-nutrition](https://clawhub.ai/Yuvasee/openclaw-nutrition)

## 痛点分析

食物追踪的核心问题不在于营养素查询，而在于记录的摩擦成本。用户每天需要多次打开应用、搜索食物、估算份量并维护饮食日记——正是在这个环节，习惯往往会被打破。

## 核心价值

营养追踪变成了一种自然的 OpenClaw 对话流程，而非独立的日记工作流。用户只需发送一句话或一张餐食照片，系统就会自动记录，并可以直接查看摘要或获取教练建议，无需切换工具。

## 典型场景

- 个人用户用简短文字或餐食照片记录早餐和午餐，稍后查看剩余热量和宏量营养素。
- 营养师为客户提供对话式记录流程，然后直接查看摘要，而无需催促客户提交手动饮食日记。
- 健康产品团队在投入专门移动应用之前，使用此技能快速搭建以摄像头为主的营养教练原型。

## 设置方法

1. 使用 `clawhub install Yuvasee/openclaw-nutrition` 安装技能，或从 ClawHub 添加 `openclaw-nutrition`。
2. 使用 `POST /api/register` 向 Haver 注册，获取以 `hv_` 开头的个人 API 密钥。
3. 完成新手引导：设置时区、个人资料、活动水平和营养目标。
4. 使用 `POST /api/me/nutrition/log` 开始记录饮食；技能文档显示该端点可接受文字和可选的 `images` 参数。
5. 记录完成后，使用 `GET /api/me/nutrition/summary` 获取每日或指定范围的摘要。
6. 你也可以使用 Telegram 机器人 `@haver_sheli_bot` 作为同一后端的托管入口。

## 相关链接

- [Haver](https://haver.dev/)
- [ClawHub: openclaw-nutrition](https://clawhub.ai/Yuvasee/openclaw-nutrition)
- [GitHub: Yuvasee/openclaw-nutrition](https://github.com/Yuvasee/openclaw-nutrition)
- [Telegram: @haver_sheli_bot](https://t.me/haver_sheli_bot)
- [OpenClaw 文档: Skills CLI](https://docs.openclaw.ai/cli/skills)

## 常见问题

### 支持食物照片输入吗？

支持。Haver 明确支持照片识别功能，技能文档显示 `POST /api/me/nutrition/log` 和 `POST /api/me/chat` 均支持可选的 `images` 参数。

### 能自动写入 Google Sheets 或 n8n 吗？

目前没有文档记录的 Google Sheets 或 n8n 集成。文档记录的行为是自动写入 Haver 的营养追踪后端，以及摘要和教练流程。

### 有哪些已知限制？

这不是医疗级营养工具，不支持运动日志、饮水追踪、条码扫描或删除已记录的饮食条目。它更适合日常营养追踪，而非完整的健康记录系统。
