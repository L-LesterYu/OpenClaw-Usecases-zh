# 02 - SLA 守护者

针对有 SLA 违约风险的客户对话的升级摘要。

## 技能栈

```bash
npx clawhub@latest install gog
npx clawhub@latest install todoist
npx clawhub@latest install slack
```

## 功能说明

- 按计划扫描客服收件箱查询
- 标记长时间未回复的旧会话
- 创建升级任务并发布摘要

## 安装步骤

1. 配置 `gog` Gmail OAuth。
2. 配置 Todoist Token。
3. 设置环境变量：
```bash
export SUPPORT_QUERY='in:inbox newer_than:2d -from:me'
export DELIVERY_CHANNEL='slack'
export DELIVERY_TARGET='channel:C1234567890'
export CRON_EXPR='*/30 8-20 * * 1-5'
export CRON_NAME='SLA Guardian'
```

4. 运行前置检查：
```bash
bash examples/runnable/02-sla-guardian/scripts/check_prereqs.sh
```

5. 安装定时任务：
```bash
bash examples/runnable/02-sla-guardian/scripts/install_cron.sh
```

## 冒烟测试

运行一次并确认：
- Slack 摘要已发布
- 风险项已列出并附有下一步行动

## 关键指标

- SLA 违约率
- 首次响应时间中位数

## 安全注意事项

- 从草稿/升级模式启动（不自动回复）。
- 保持 OAuth 权限范围最小化。

## 回滚

```bash
openclaw cron delete <job-id>
```
