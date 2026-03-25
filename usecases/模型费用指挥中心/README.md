# 10 - 模型费用指挥中心

每日模型用量与费用异常监控。

## 技能栈

```bash
npx clawhub@latest install model-usage
npx clawhub@latest install summarize
npx clawhub@latest install slack
```

## 功能说明

- 拉取最新模型用量指标
- 按模型/供应商拆解费用
- 标记异常费用飙升及可能的驱动因素

## 安装配置

```bash
export COST_WINDOW='24h'
export ANOMALY_THRESHOLD_PERCENT='25'
export DELIVERY_CHANNEL='slack'
export DELIVERY_TARGET='channel:C1234567890'
export CRON_EXPR='0 8 * * 1-5'
export CRON_NAME='Model Cost Command Center'
```

```bash
bash examples/runnable/10-model-cost-command-center/scripts/check_prereqs.sh
bash examples/runnable/10-model-cost-command-center/scripts/install_cron.sh
```

## 冒烟测试

- 触发一次运行，验证用量汇总和模型分项数据存在。
- 确认输出中至少包含一条异常规则评估结果。

## KPI

- 周环比费用变化
- 每次成功工作流的成本
- 前2个模型占总费用的比例

## 安全注意事项

- 将用量数据视为内部运营遥测数据。
- 将摘要发送到受限频道。

## 回滚

```bash
openclaw cron delete <job-id>
```
