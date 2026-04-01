# 微信公众号自动发布

## 痛点

每次手动在浏览器中将长篇 Markdown 文章发布到微信公众号，既重复又容易出错。

## 功能说明

本方案让 OpenClaw 通过 `publish_wechat` 技能和 Gateway 服务，从聊天频道（飞书/Telegram/Web UI）将 Markdown 文章直接发布到微信公众号。

- OpenClaw 将原始 Markdown 发送给 Gateway（OpenClaw 侧不做 Markdown 转 HTML）
- Gateway 创建发布任务并返回状态
- 如需登录，OpenClaw 显示微信公众号登录二维码图片
- 用户扫码确认登录后，OpenClaw 继续完成发布流程

## 提示词

自然语言触发：

```text
帮我把这篇文章发到微信公众号上去
```

技能命令示例：

```text
/publish_wechat
/publish_wechat status <task_id>
/publish_wechat confirm <task_id>
/publish_wechat relogin
```

操作流程示例：

1. 在聊天中粘贴 Markdown 文章
2. 发送 `帮我把这篇文章发到微信公众号上去`（或 `/publish_wechat`）
3. 如果状态为 `waiting_login`，扫描二维码图片
4. 发送 `/publish_wechat confirm <task_id>` 确认登录
5. 使用 `/publish_wechat status <task_id>` 查看最终发布状态

## 所需技能

- 自定义 OpenClaw 技能：`publish_wechat`
  - 支持操作：publish（发布）、status（状态查询）、confirm（确认登录）、relogin（重新登录）

## 相关链接

- OpenClaw：https://github.com/openclaw/openclaw
- 微信公众号发布 Gateway 实现：https://github.com/xu75/openclaw-wechat-gateway
