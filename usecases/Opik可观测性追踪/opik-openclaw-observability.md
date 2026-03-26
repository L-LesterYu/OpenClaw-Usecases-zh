# OpenClaw + Opik 可观测性追踪与成本监控

在生产环境中运行 OpenClaw 很快就会产生一个可观测性缺口：故障可能发生在 LLM 调用、工具执行和子智能体编排等多个层面，但调试上下文往往散落在各处日志中。

本用例展示如何通过 `@opik/opik-openclaw` 为 OpenClaw 添加端到端追踪，让你在一个面板中集中查看追踪链路、Span、错误和成本/用量数据。

## 痛点

- **智能体运行全链路可追踪性差**：很难将一个用户请求与所有下游的 LLM/工具/子智能体活动关联起来。
- **故障排查速度慢**：定位根因需要在网关日志和各供应商仪表盘之间来回跳转。
- **成本盲区**：按工作流或项目维度监控 Token/成本趋势非常困难。

## 功能说明

- 将 OpenClaw 事件以结构化追踪链路和 Span 的形式发送到 Opik
- 采集内容包括：
  - LLM 请求/响应 Span
  - 工具调用 Span（输入/输出/错误）
  - 子智能体生命周期 Span
  - 运行完成元数据
  - 用量和成本元数据
- 提供 CLI 设置/状态检查流程，便于快速部署运维

## 提示词

安装完成后，你可以让 OpenClaw 执行轻量级运维检查：

```text
运行一次网关健康检查，发送一条测试消息，然后汇总今天 Opik 追踪中所有失败的工具调用。
```

```text
查看过去 24 小时内按 Token 用量和成本排名前 5 的工作流（从 Opik 追踪数据中获取），并为每个工作流提出一项优化建议。
```

## 所需技能

- OpenClaw CLI 基础使用
- 无需额外 OpenClaw 技能

## 设置步骤

1. 安装插件：

```bash
openclaw plugins install @opik/opik-openclaw
```

2. 配置：

```bash
openclaw opik configure
```

3. 验证有效配置：

```bash
openclaw opik status
```

4. 生成一条测试追踪：

```bash
openclaw gateway run
openclaw message send "hello from openclaw"
```

5. 打开 Opik 并确认追踪链路和 Span 数据已成功写入。

## 相关链接

- [opik-openclaw 仓库](https://github.com/comet-ml/opik-openclaw)
- [Opik 文档](https://www.comet.com/docs/opik/)
- [OpenClaw 插件文档](https://docs.openclaw.ai/plugin)
