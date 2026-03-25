# 29 - 竞品动态追踪

追踪竞品产品动态，并生成可执行的应对建议。

## 技能栈

```bash
npx clawhub@latest install tavily-search
npx clawhub@latest install summarize
npx clawhub@latest install todoist
```

## 功能说明

- 按选定领域每周采集竞品动态
- 按主题聚类（定价、产品包装、产品功能、走向市场策略）
- 以置信度和紧急程度评估，推荐可执行的应对措施

## 配置

```bash
export COMPETITOR_QUERY='agent automation platform pricing launch'
export LOOKBACK_DAYS='7'
export MAX_SIGNALS='40'
export DELIVERY_CHANNEL='slack'
export DELIVERY_TARGET='channel:C1234567890'
export CRON_EXPR='0 8 * * 1'
export CRON_NAME='Competitive Monitor'
```

```bash
bash examples/runnable/29-competitive-monitor/scripts/check_prereqs.sh
bash examples/runnable/29-competitive-monitor/scripts/install_cron.sh
```

## 冒烟测试

- 运行一次，确认分组主题包含来源链接和时间戳。
- 确认低置信度传言与高置信度动态已分开展示。

## 关键指标

- 从市场信号到内部响应的耗时
- 误报率
- 每份报告生成的战略行动建议数量

## 安全注意事项

- 除非获得明确授权，仅使用公开来源的信息。
- 响应策划方案保持内部保密。

## 回滚

```bash
openclaw cron delete <job-id>
```
