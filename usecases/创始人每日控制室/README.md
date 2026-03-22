# 30 - 创始人每日控制室

每日跨产品、运营和日程的高管运营简报。

## 技能栈

```bash
npx clawhub@latest install gog
npx clawhub@latest install github
npx clawhub@latest install todoist
npx clawhub@latest install weather
```

## 功能说明

- 聚合来自邮件、日历、代码仓库和任务系统的首要优先事项
- 高亮战略风险、阻塞项和截止日期
- 生成精简的每日控制室简报

## 安装配置

```bash
export PRIORITY_FOCUS='product launch'
export LOCATION='San Francisco, CA'
export DELIVERY_CHANNEL='slack'
export DELIVERY_TARGET='channel:C1234567890'
export CRON_EXPR='0 7 * * 1-5'
export CRON_NAME='Founder Daily Control Room'
```

```bash
bash examples/runnable/30-founder-daily-control-room/scripts/check_prereqs.sh
bash examples/runnable/30-founder-daily-control-room/scripts/install_cron.sh
```

## 冒烟测试

- 运行一次，验证简报包含优先事项、风险、日历冲突和任务聚焦。
- 确认建议保持简洁且可操作。

## KPI 指标

- 每日优先事项完成率
- 汇编高管上下文所花时间
- 遗漏的高优先级事项

## 安全注意事项

- 创始人简报仅限私有频道。
- 最小化共享综合运营上下文的范围。

## 回滚

```bash
openclaw cron delete <job-id>
```
