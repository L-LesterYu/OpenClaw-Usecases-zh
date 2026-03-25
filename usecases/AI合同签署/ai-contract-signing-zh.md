# 能签单的AI员工

你的智能体负责调研线索、撰写提案、发送邮件——但当客户说"把合同发给我"的那一刻……你还得手动介入。现在不用了。

本用例将 OpenClaw 变成一个成交高手。它能用 Markdown 起草合同、保密协议（NDA）或提案，并通过电子签名发送——全程无需你动手。双方签署后，双方都能收到一份 SHA-256 认证的安全 PDF。就这么简单。

## 痛点

每个 AI 销售工作流都有同样的断层：智能体能做所有事情，*唯独*没法把签名落到纸上。Stripe 处理支付，AgentMail 处理邮件，但签署？那还是手动步骤——直到现在。

## 功能介绍

1. 你告诉 OpenClaw 一笔交易、客户或协议的详情
2. 它用 Markdown 起草文档（NDA、合同、提案、工作说明书——什么都可以）
3. 通过 Signbee 发送文档进行双方电子签署
4. 发送方签署 → 收件方收到邮件 → 收件方签署
5. 双方都能收到一份带 SHA-256 证书的防篡改签署 PDF

整个流程自动运行。你醒来就能在收件箱里看到已签署的合同。

## 所需技能

[Signbee MCP 服务器](https://github.com/signbee/mcp) —— 通过 npm 安装：

```json
{
  "mcpServers": {
    "signbee": {
      "command": "npx",
      "args": ["-y", "signbee-mcp"],
      "env": {
        "SIGNBEE_API_KEY": "your-api-key-from-signb.ee"
      }
    }
  }
}
```

在 [signb.ee](https://signb.ee) 获取免费 API 密钥（每月 5 份文档免费）。

## 如何配置

1. 安装 Signbee MCP 服务器（配置如上）
2. 指示 OpenClaw：

```txt
你是我的 AI 商务成交助手。当我告诉你一笔交易时，你需要：

1. 用简洁的 Markdown 起草合适的文档（NDA、合同、提案或工作说明书）
2. 包含所有相关条款、日期和双方信息
3. 使用 send_document 工具发送文档进行电子签署
4. 汇报文档状态

起草时，保持专业但简洁。使用规范的标题、编号条款和清晰的语言。务必包含生效日期、双方名称和终止条款。

如果我给你的是一个 PDF，请使用 send_document_pdf 并传入 URL。
```

## 示例提示

**促成自由职业交易：**
> "向 acme.com 的 Sarah（sarah@acme.com）发送一份 NDA。我们即将开始一项咨询合作。我的名字是 Michael Beckett，邮箱 michael@company.com。"

**以 PDF 形式发送提案：**
> "我有一份提案 PDF 在 https://example.com/proposal.pdf ——请发送给 james@client.com 的 James 进行签署。"

**自主交易流程：**
> "为 DataCorp 起草一份 6 个月的服务协议，每月 $5,000（联系人：lisa@datacorp.com）。包含付款条款、知识产权归属和保密条款，并发送签署。"

## 为什么与众不同

大多数"AI 员工"方案止步于对话。这个方案能成交。你的智能体从线索 → 提案 → 已签署合同，全程无需你动手。搭配邮件（AgentMail）、支付（Stripe）和日程安排（Cal.com），就能打造一个全自动销售机器。

## 相关链接

- [Signbee](https://signb.ee) —— 面向 AI 智能体的文档签署 API
- [signbee-mcp on npm](https://www.npmjs.com/package/signbee-mcp) —— MCP 服务器包
- [GitHub](https://github.com/signbee/mcp) —— 源代码
