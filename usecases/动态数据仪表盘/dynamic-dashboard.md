# 基于子智能体并发的动态数据仪表盘

静态仪表盘展示的数据往往已经过时，且需要持续手动更新。你希望实时掌握多个数据源的动态，而不必构建自定义前端或担心触发 API 速率限制。

本工作流创建一个实时仪表盘，通过生成子智能体来并行获取和处理数据：

• 同时监控多个数据源（API、数据库、GitHub、社交媒体）
• 为每个数据源生成子智能体，避免阻塞并分散 API 负载
• 将结果汇总到统一仪表盘（文本、HTML 或 Canvas）
• 每隔 N 分钟自动刷新数据
• 当指标超过阈值时发送告警
• 在数据库中维护历史趋势以供可视化

## 痛点

构建一个自定义仪表盘需要数周时间。等做完的时候，需求可能已经变了。顺序轮询多个 API 速度慢且容易触发速率限制。你需要的是即刻获得洞察，而不是熬一个周末的代码。

## 它能做什么

你可以通过对话方式定义要监控的内容："追踪 GitHub 星标数、Twitter 提及量、Polymarket 交易量和系统健康状态。" OpenClaw 生成子智能体并行获取每个数据源的信息，汇总结果后，将格式化的仪表盘推送到 Discord 或生成 HTML 文件。更新通过定时任务自动运行。

仪表盘示例板块：
- **GitHub**：星标数、Fork 数、未关闭 Issue 数、近期提交
- **社交媒体**：Twitter 提及量、Reddit 讨论、Discord 活跃度
- **市场**：Polymarket 交易量、预测趋势
- **系统健康**：CPU、内存、磁盘使用率、服务状态

## 所需技能

- 子智能体生成（用于并行执行）
- `github`（gh CLI）用于获取 GitHub 指标
- `bird`（Twitter）用于获取社交数据
- `web_search` 或 `web_fetch` 用于访问外部 API
- `postgres` 用于存储历史指标
- Discord 或 Canvas 用于渲染仪表盘
- 定时任务（Cron）用于定期更新

## 如何配置

1. 搭建指标数据库：
```sql
CREATE TABLE metrics (
  id SERIAL PRIMARY KEY,
  source TEXT, -- 例如 "github"、"twitter"、"polymarket"
  metric_name TEXT,
  metric_value NUMERIC,
  timestamp TIMESTAMPTZ DEFAULT NOW()
);

CREATE TABLE alerts (
  id SERIAL PRIMARY KEY,
  source TEXT,
  condition TEXT,
  threshold NUMERIC,
  last_triggered TIMESTAMPTZ
);
```

2. 创建一个 Discord 频道用于仪表盘更新（例如 #dashboard）。

3. 向 OpenClaw 发送提示：
```text
你是我的动态数据仪表盘管理员。每 15 分钟运行一次定时任务：

1. 并行生成子智能体，从以下来源获取数据：
   - GitHub：星标数、Fork 数、未关闭 Issue 数、提交记录（过去 24 小时）
   - Twitter：关于 "@username" 的提及量、情感分析
   - Polymarket：所追踪市场的交易量
   - 系统：通过 Shell 命令获取 CPU、内存、磁盘使用率

2. 每个子智能体将结果写入指标数据库。

3. 汇总所有结果并格式化仪表盘：

📊 **仪表盘更新** — [时间戳]

**GitHub**
- ⭐ 星标数：[数量]（+[变化量]）
- 🍴 Fork 数：[数量]
- 🐛 未关闭 Issue：[数量]
- 💻 提交数（24h）：[数量]

**社交媒体**
- 🐦 Twitter 提及量：[数量]
- 📈 情感倾向：[正面/负面/中性]

**市场**
- 📊 Polymarket 交易量：$[金额]
- 🔥 热门市场：[市场名称]

**系统健康**
- 💻 CPU：[使用率]%
- 🧠 内存：[使用率]%
- 💾 磁盘：[使用率]%

4. 推送到 Discord #dashboard 频道。

5. 检查告警条件：
   - 如果 GitHub 星标数 1 小时内变化超过 50 → 通知我
   - 如果系统 CPU 超过 90% → 发出告警
   - 如果 Twitter 上出现负面情感激增 → 通知

将所有指标存储到数据库中，以便后续进行历史分析。
```

4. 可选：使用 Canvas 渲染包含图表的 HTML 仪表盘。

5. 查询历史数据："展示过去 30 天的 GitHub 星标增长趋势。"

## 相关链接

- [子智能体并行处理](https://docs.openclaw.ai/subagents)
- [仪表盘设计原则](https://www.nngroup.com/articles/dashboard-design/)
