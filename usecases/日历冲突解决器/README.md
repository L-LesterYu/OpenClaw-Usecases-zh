# 12 - 日历冲突解决器

自动发现日程冲突并创建清晰的解决队列。

## 技能栈

```bash
npx clawhub@latest install gog
npx clawhub@latest install caldav-calendar
npx clawhub@latest install summarize
npx clawhub@latest install todoist
```

## 功能说明

- 扫描未来日程中的所有日历事件
- 检测时间重叠和不可能的连续安排
- 提供重新预约建议并追踪未解决事项

## 配置

```bash
export LOOKAHEAD_DAYS='14'
export MIN_BUFFER_MINUTES='15'
export DELIVERY_CHANNEL='slack'
export DELIVERY_TARGET='channel:C1234567890'
export CRON_EXPR='15 7 * * 1-5'
export CRON_NAME='Calendar Conflict Resolver'
```

```bash
bash examples/runnable/12-calendar-conflict-resolver/scripts/check_prereqs.sh
bash examples/runnable/12-calendar-conflict-resolver/scripts/install_cron.sh
```

## 冒烟测试

- 运行一次并验证至少检测到以下情况之一：时间重叠、无缓冲连续会议或重复预约。
- 确认每个冲突都有具体的解决建议。

## 关键指标

- 每周日历冲突数量
- 冲突平均解决时间
- 准时参会率

## 安全注意事项

- 将日历访问权限限制在所需的范围/日历内。
- 个人事件详情仅在私有频道中处理。

## 回滚

```bash
openclaw cron delete <job-id>
```
