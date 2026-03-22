# Polymarket 自动交易：自动化模拟交易

手动监控预测市场的套利机会并执行交易既耗时又需要持续关注。你想要在不冒真实资金风险的情况下测试和优化交易策略。

这个工作流使用自定义策略在 Polymarket 上自动化模拟交易：

• 通过 API 监控市场数据（价格、交易量、价差）
• 使用 TAIL（趋势跟踪）和 BONDING（逆向）策略执行模拟交易
• 跟踪投资组合表现、盈亏和胜率
• 每天向 Discord 发送包含交易日志和洞察的摘要
• 从模式中学习：根据回测结果调整策略参数

## 痛点

预测市场变化迅速。手动交易意味着错失机会、情绪化决策以及难以追踪有效策略。在理解市场行为之前用真金白银测试策略会导致亏损。

## 功能介绍

自动交易系统持续扫描 Polymarket 寻找机会，使用可配置策略模拟交易，并记录一切用于分析。你醒来时会看到它"隔夜交易"的摘要、有效和无效的操作。

示例策略：
- **TAIL**：在交易量激增和动量明确时跟随趋势
- **BONDING**：在市场对新闻过度反应时买入逆向头寸
- **SPREAD**：识别定价错误、存在套利空间的市场

## 所需技能

- `web_search` 或 `web_fetch`（用于 Polymarket API 数据）
- `postgres` 或 SQLite，用于交易日志和投资组合跟踪
- Discord 集成，用于每日报告
- Cron 定时任务，用于持续监控
- 子智能体生成，用于并行市场分析

## 设置方法

1. 设置模拟交易数据库：
```sql
CREATE TABLE paper_trades (
  id SERIAL PRIMARY KEY,
  market_id TEXT,
  market_name TEXT,
  strategy TEXT,
  direction TEXT,
  entry_price DECIMAL,
  exit_price DECIMAL,
  quantity DECIMAL,
  pnl DECIMAL,
  timestamp TIMESTAMPTZ DEFAULT NOW()
);

CREATE TABLE portfolio (
  id SERIAL PRIMARY KEY,
  total_value DECIMAL,
  cash DECIMAL,
  positions JSONB,
  updated_at TIMESTAMPTZ DEFAULT NOW()
);
```

2. 创建一个 Discord 频道用于更新（例如 #polymarket-autopilot）。

3. 向 OpenClaw 发送指令：
```text
You are a Polymarket paper trading autopilot. Run continuously (via cron every 15 minutes):

1. Fetch current market data from Polymarket API
2. Analyze opportunities using these strategies:
   - TAIL: Follow strong trends (>60% probability + volume spike)
   - BONDING: Contrarian plays on overreactions (sudden drops >10% on news)
   - SPREAD: Arbitrage when YES+NO > 1.05
3. Execute paper trades in the database (starting capital: $10,000)
4. Track portfolio state and update positions

Every morning at 8 AM, post a summary to Discord #polymarket-autopilot:
- Yesterday's trades (entry/exit prices, P&L)
- Current portfolio value and open positions
- Win rate and strategy performance
- Market insights and recommendations

Use sub-agents to analyze multiple markets in parallel during high-volume periods.

Never use real money. This is paper trading only.
```

4. 根据表现迭代策略。调整阈值、添加新策略、回测历史数据。

## 相关链接

- [Polymarket API](https://docs.polymarket.com/)
- [模拟交易最佳实践](https://www.investopedia.com/articles/trading/11/paper-trading.asp)
