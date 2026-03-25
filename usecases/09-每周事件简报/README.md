# 09 - 每周事件简报

面向工程管理层的周五事件摘要与事后复盘跟进。

## 技能栈

```bash
npx clawhub@latest install github
npx clawhub@latest install summarize
npx clawhub@latest install slack
```

## 功能说明

- 拉取带有事件标签的 Issue/PR
- 汇总未关闭与已关闭事件的状态
- 标记缺失的事后复盘和过期的跟进任务

## 配置

```bash
export REPO='owner/repo'
export INCIDENT_LABELS='incident,sev1,sev2'
export SINCE_WINDOW='7 days ago'
export DELIVERY_CHANNEL='slack'
export DELIVERY_TARGET='channel:C1234567890'
export CRON_EXPR='0 16 * * 5'
export CRON_NAME='每周事件简报'
```

```bash
bash examples/runnable/09-weekly-incident-brief/scripts/check_prereqs.sh
bash examples/runnable/09-weekly-incident-brief/scripts/install_cron.sh
```

## 冒烟测试

- 运行一次并验证事件链接、负责人和未解决行动项是否列出。
- 确认缺失事后复盘的项目被明确指出。

## KPI

- 事后复盘完成率
- 事件跟进老化天数
- 重复事件比率

## 安全注意事项

- 将报告保留在私有工程频道中。
- 避免包含客户敏感负载信息。

## 回滚

```bash
openclaw cron delete <job-id>
```
