# 智能体邮件基础设施

让你的 OpenClaw 智能体拥有自己的邮箱地址——无需人工注册、无需 API 密钥、无需控制台配置。

## 问题

AI 智能体需要收发邮件来完成外联、通知、账户验证和沟通等任务。传统邮件服务商要求人工注册流程、API 密钥管理和控制台配置——这些都不是自主智能体能够完成的。

## 解决方案

安装 [LobsterMail 技能](https://clawhub.ai/samuelchenardlovesboards/lobstermail-agent-email)，你的智能体即可：

- **一行代码创建自己的收件箱**
- **自主收发邮件**
- **安全防护**：覆盖 6 个类别的提示注入扫描
- **身份认证**：内置 SPF/DKIM/DMARC 支持

## 快速开始

```
clawhub install lobstermail-agent-email
```

然后告诉你的智能体：*"为自己创建一个邮箱地址并发送一条测试消息。"*

## 使用的技能

- [lobstermail-agent-email](https://clawhub.ai/samuelchenardlovesboards/lobstermail-agent-email) — 面向 AI 智能体的邮件基础设施

## 相关链接

- [LobsterMail](https://lobstermail.ai/) — 官网
- [Node.js SDK](https://www.npmjs.com/package/lobstermail) — `npm install lobstermail`
- [MCP Server](https://lobstermail.ai/mcp) — 适用于 MCP 兼容客户端
