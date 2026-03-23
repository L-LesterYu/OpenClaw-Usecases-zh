# 基于 FinClaw 的 AI 智能股票分析

## 概述
使用 OpenClaw + [FinClaw](https://github.com/NeuZhou/finclaw) 对美股、A股和港股进行股票分析，8 种 AI 驱动的交易策略作为独立智能体并行运行。

## 功能特性
- **多策略分析**：动量、均值回归、情绪、因子投资、技术面、基本面、事件驱动、风险平价
- **多智能体架构**：每个策略独立运行，元智能体汇总信号
- **多市场覆盖**：美股、A股、港股
- **历史回测**：2020-2025 年年化 Alpha +29.1%

## 安装
```bash
git clone https://github.com/NeuZhou/finclaw.git
cd finclaw && npm install
```

## 使用方式
让 OpenClaw 分析任意股票：
```
"用全部8种策略分析AAPL，给我买入/持有/卖出建议"
"对比TSLA和NVDA近3个月的动量信号"
"对我的投资组合做风险平价回测：40% SPY, 30% QQQ, 30% TLT"
```

## 为什么值得关注
大多数量化工具要么过于学术化（论文出色但代码不可用），要么价格高昂（如彭博终端）。FinClaw 是生产级质量、多策略、免费开源的方案。

## 相关链接
- [GitHub](https://github.com/NeuZhou/finclaw)
- [作者](https://github.com/NeuZhou)
