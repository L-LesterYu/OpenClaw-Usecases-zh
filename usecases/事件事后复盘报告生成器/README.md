# 35 - 事件事后复盘报告生成器

从事件时间线、Issue 链接和运维人员笔记中自动生成周期性事件事后复盘报告草稿。

## 技能栈

```bash
npx clawhub@latest install github
npx clawhub@latest install summarize
npx clawhub@latest install notion
```

## 功能说明

- 扫描已配置的工程工具中的事件时间线、Issue 链接和运维人员笔记
- 按风险等级、复发频率和交付影响对问题进行优先级排序
- 生成事件事后复盘报告草稿，供运维人员审阅

## 配置

```bash
export TARGET_SCOPE='production incidents'
export LOOKBACK_DAYS='7'
export DELIVERY_CHANNEL='slack'
export DELIVERY_TARGET='channel:C1234567890'
export CRON_EXPR='5 11 * * 1'
export CRON_NAME='Incident Postmortem Drafter'
```

```bash
bash examples/runnable/35-incident-postmortem-drafter/scripts/check_prereqs.sh
bash examples/runnable/35-incident-postmortem-drafter/scripts/install_cron.sh
```

## 冒烟测试

- 运行一次并验证事件事后复盘报告草稿包含基于证据的优先级排序。
- 确认未自动执行任何外部操作，所有草稿输出均可审阅。

## KPI 指标

- 从事件关闭到生成草稿的时间
- 分拣延迟
- 重复问题遗漏率

## 安全注意事项

- 首次部署时使用只读仓库或分析范围。
- 仅发送到受信任的工程频道，后续写入操作需人工审核。

## 失败模式

- 缺少仓库权限可能导致关键上下文缺失。
- 噪音数据可能导致低价值问题被高估排名，需调整阈值。

## 回滚

```bash
openclaw cron delete <job-id>
```
