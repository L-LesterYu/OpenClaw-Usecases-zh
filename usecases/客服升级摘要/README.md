# 19 - 客服升级摘要

检测未解决的客服工单，并生成按紧急程度排序的升级摘要。

## 技能栈

```bash
npx clawhub@latest install slack
npx clawhub@latest install summarize
npx clawhub@latest install todoist
```

## 功能说明

- 扫描客服频道中未回复/高摩擦的工单线程
- 按创建时间、情感倾向和客户影响指标对紧急程度进行评分
- 输出升级摘要，包含负责人和下一步行动

## 配置

```bash
export SUPPORT_CHANNELS='support,urgent-support,vip-support'
export WINDOW_HOURS='48'
export MAX_ESCALATIONS='20'
export DELIVERY_CHANNEL='slack'
export DELIVERY_TARGET='channel:C1234567890'
export CRON_EXPR='*/30 8-20 * * 1-5'
export CRON_NAME='Support Escalation Digest'
```

```bash
bash examples/runnable/19-support-escalation-digest/scripts/check_prereqs.sh
bash examples/runnable/19-support-escalation-digest/scripts/install_cron.sh
```

## 冒烟测试

- 触发一次运行，确认升级摘要包含链接、等待时间和已分配的后续行动。
- 确认低优先级的已解决工单被排除。

## KPI 指标

- SLA 违约率
- 升级响应中位时间
- 未解决的紧急工单老化数量

## 安全注意事项

- 将涉及客户敏感信息的上下文保留在私有频道中。
- 将扫描范围限制在所需的客服频道内。

## 回滚

```bash
openclaw cron delete <job-id>
```
