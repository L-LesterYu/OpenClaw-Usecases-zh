# 市场调研与产品工厂

你想做一个产品，但不知道做什么。或者你有一个业务，需要了解客户正在面临什么困难。这个工作流使用 Last 30 Days 技能从 Reddit 和 X 上挖掘真实痛点，然后让 OpenClaw 为这些问题构建解决方案。

## 功能介绍

- 使用 [Last 30 Days](https://github.com/mvanhorn/last30days-skill/) 技能在过去 30 天内跨 Reddit 和 X 研究任意主题
- 提取人们发布的相关挑战、抱怨和功能需求
- 帮助你从真实的用户痛点中识别产品机会
- 更进一步：让 OpenClaw 构建一个 MVP 来解决其中某个挑战
- 创建从调研到产品的完整流水线，无需你编写任何代码

## 解决的痛点

大多数创业者都在为"做什么"这个问题而苦恼。传统的市场调研意味着要在论坛、社交媒体和评论网站中花费数小时手动浏览。这个方案将整个从发现到原型构建的流水线完全自动化。

## 所需技能

- [Last 30 Days](https://github.com/mvanhorn/last30days-skill/) 技能（作者：Matt Van Horde）
- Telegram 或 Discord 集成，用于接收研究报告

## 如何设置

1. 安装 Last 30 Days 技能：
```text
Install this skill: https://github.com/mvanhorn/last30days-skill/
```

2. 对任意主题进行研究：
```text
Please use the Last 30 Days skill to research challenges people are
having with [your topic here].

Organize the findings into:
- Top pain points (ranked by frequency)
- Specific complaints and feature requests
- Gaps in existing solutions
- Opportunities for a new product
```

3. 选择一个痛点，让 OpenClaw 构建解决方案：
```text
Build me an MVP that solves [pain point from research].
Keep it simple — just the core functionality.
Ship it as a web app I can share with people.
```

4. 持续获取市场情报，设置定期研究：
```text
Every Monday morning, use the Last 30 Days skill to research what
people are saying about [your niche] on Reddit and X. Summarize the
top opportunities and send them to my Telegram.
```

## 实际案例

```text
"Use the Last 30 Days skill to research challenges people are having with OpenClaw."

Results:
- Setup difficulty: Many users struggle with initial configuration
- Skill discovery: People can't find skills that do what they need
- Cost concerns: Users want cheaper model alternatives

→ "Build me a simple web app that makes OpenClaw setup easier with a guided wizard."

OpenClaw builds the app. You ship it. You have a product.
```

## 核心洞察

- 这是**自动驾驶式的创业方式**：发现问题 → 验证需求 → 构建解决方案，全程通过文字消息完成。
- Last 30 Days 技能为你提供真实、未经过滤的用户反馈——而非经过粉饰的调研数据。
- 你不需要懂技术。OpenClaw 既负责调研，也负责构建。
- 设置每周定期研究，持续掌握市场中不断变化的痛点。

## 灵感来源

灵感来自 [Alex Finn 关于改变生活的 OpenClaw 用例的视频](https://www.youtube.com/watch?v=41_TNGDDnfQ) 以及 Matt Van Horde 的 [Last 30 Days 技能](https://github.com/mvanhorn/last30days-skill/)。

## 相关链接

- [Last 30 Days 技能](https://github.com/mvanhorn/last30days-skill/)
- [OpenClaw 技能目录](https://github.com/openclaw/skills)
