# Polymarket 自动交易：自动化模拟盘交易

手动监控预测市场寻找套利机会并执行交易既耗时又需要持续关注。你希望在不动用真实资金的情况下测试和优化交易策略。

此工作流通过自定义策略实现 Polymarket 上的自动化模拟盘交易：

• 通过 API 监控市场数据（价格、成交量、价差）
• 使用 TAIL（趋势跟踪）和 BONDING（逆向操作）策略执行模拟交易
• 跟踪投资组合表现、盈亏和胜率
• 将每日摘要推送到 Discord，包含交易日志和洞察
• 从模式中学习：根据回测结果调整策略参数

## 痛点

预测市场变化迅速。手动交易意味着错过机会、情绪化决策，且难以追踪有效策略。在理解市场行为之前用真金白银测试策略，会面临亏损风险。

## 功能说明

自动交易系统持续扫描 Polymarket 寻找机会，使用可配置策略模拟交易，并记录所有数据供分析。你醒来时就能看到它隔夜"交易"的摘要——哪些策略奏效了，哪些没有。

示例策略：
- **TAIL**：当成交量激增且趋势明确时跟随趋势
- **BONDING**：当市场对消息过度反应时买入逆向头寸
- **SPREAD**：识别定价偏差市场中的套利机会

## 所需技能

- `web_search` 或 `web_fetch`（用于获取 Polymarket API 数据）
- `postgres` 或 SQLite 用于交易日志和投资组合跟踪
- Discord 集成用于每日报告
- 定时任务用于持续监控
- 子智能体生成用于并行市场分析

## 设置方法

1. 创建模拟盘交易数据库：
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

2. 创建一个 Discord 频道用于接收更新（例如 #polymarket-autopilot）。

3. 配置 OpenClaw 提示词：
```text
你是一个 Polymarket 模拟盘自动交易系统。持续运行（通过定时任务每15分钟执行一次）：

1. 从 Polymarket API 获取当前市场数据
2. 使用以下策略分析机会：
   - TAIL：跟随强趋势（>60% 概率 + 成交量激增）
   - BONDING：对过度反应进行逆向操作（消息引发突然下跌 >10%）
   - SPREAD：当 YES+NO > 1.05 时执行套利
3. 在数据库中执行模拟交易（初始资金：$10,000）
4. 跟踪投资组合状态并更新持仓

每天早上 8 点，向 Discord #polymarket-autopilot 频道发送摘要：
- 昨日交易（入场/出场价格、盈亏）
- 当前投资组合价值和持仓情况
- 胜率和策略表现
- 市场洞察和建议

使用子智能体在高成交量时段并行分析多个市场。

绝不使用真实资金。这仅限模拟盘交易。
```

4. 根据表现迭代优化策略。调整阈值、添加新策略、对历史数据进行回测。

## 相关链接

- [Polymarket API](https://docs.polymarket.com/)
- [模拟盘交易最佳实践](https://www.investopedia.com/articles/trading/11/paper-trading.asp)
