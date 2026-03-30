# 能签单的 AI 员工

你的 AI 智能体能做调研、写方案、发邮件——但当客户说"把合同发给我"时……你还得手动介入。现在不用了。

这个用例将 OpenClaw 变成一个成交高手。它能用 Markdown 起草合同、保密协议（NDA）或方案书，并通过电子签名发送——全部自动完成。双方签署后，各自会收到一份经过 SHA-256 认证的安全 PDF。就这么简单。

## 痛点

每个 AI 销售工作流都有同一个缺口：智能体能做所有事情，*唯独*拿不到纸面上的签名。Stripe 处理付款，AgentMail 处理邮件，但签名呢？那一直是手动的——直到现在。

## 工作原理

1. 你告诉 OpenClaw 关于一笔交易、客户或协议的信息
2. 它用 Markdown 起草文档（NDA、合同、方案书、工作说明书（SOW）——任何类型）
3. 通过 Signbee 发送文档进行电子签名
4. 发送方签名 → 收件方收到邮件 → 收件方签名
5. 双方都会收到带有 SHA-256 认证的防篡改已签署 PDF

整个过程自动运行。你醒来时就会发现已签署的合同躺在收件箱里。

## 所需技能

[Signbee MCP Server](https://github.com/signbee/mcp) — 通过 npm 安装：

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

在 [signb.ee](https://signb.ee) 获取免费 API 密钥（每月免费 5 份文档）。

## 设置

1. 安装 Signbee MCP Server（配置如上）
2. 指示 OpenClaw：

```txt
你是我的 AI 成交助手。当我告诉你一笔交易时，你需要：

1. 用规范的 Markdown 起草适当的文档（NDA、合同、方案书或工作说明书）
2. 包含所有相关条款、日期和当事方信息
3. 使用 send_document 工具发送进行电子签名
4. 报告文档状态

起草时，保持专业但简洁。使用规范的标题、编号条款和清晰的语言。始终包含生效日期、当事方名称和终止条款。

如果我给你的是 PDF，请使用 send_document_pdf 配合 URL。
```

## 示例提示词

**完成一笔自由职业交易：**
> "给 acme.com 的 Sarah 发一份 NDA（邮箱 sarah@acme.com）。我们即将开始咨询合作。我的名字是 Michael Beckett，邮箱 michael@company.com。"

**以 PDF 形式发送方案书：**
> "我有一份方案书 PDF，地址是 https://example.com/proposal.pdf — 请发送给 James（james@client.com）进行签署。"

**自主处理交易：**
> "为 DataCorp 起草一份为期 6 个月的服务协议，费用 $5,000/月（联系人：lisa@datacorp.com）。包含付款条款、知识产权归属和保密条款，然后发送签署。"

## 有什么不同

大多数"AI 员工"方案止步于对话。这个方案能签单。你的 AI 从线索 → 方案 → 已签署合同，全程自动完成。结合邮件（AgentMail）、支付（Stripe）和日程安排（Cal.com），你就拥有了一台全自动的销售机器。

## 相关链接

- [Signbee](https://signb.ee) — 面向 AI 智能体的文档签名 API
- [signbee-mcp on npm](https://www.npmjs.com/package/signbee-mcp) — MCP 服务端包
- [GitHub](https://github.com/signbee/mcp) — 源代码
