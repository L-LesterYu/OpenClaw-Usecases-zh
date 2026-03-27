# 11 - 收件箱转行动项

将重要收件箱邮件自动转化为可执行任务队列。

## 技能栈

```bash
npx clawhub@latest install gog
npx clawhub@latest install summarize
npx clawhub@latest install todoist
```

## 功能说明

- 扫描指定的收件箱查询
- 提取行动项、截止日期和依赖关系
- 创建带置信度排序的行动队列

## 配置

```bash
export INBOX_QUERY='in:inbox newer_than:2d -category:promotions -from:me'
export MAX_TASKS='15'
export DELIVERY_CHANNEL='slack'
export DELIVERY_TARGET='channel:C1234567890'
export CRON_EXPR='0 */2 * * 1-5'
export CRON_NAME='Inbox to Action'
```

```bash
bash examples/runnable/11-inbox-to-action/scripts/check_prereqs.sh
bash examples/runnable/11-inbox-to-action/scripts/install_cron.sh
```

## 冒烟测试

- 运行一次并确认提取的行动项对应真实邮件。
- 验证截止日期为明确标注或已清楚标记为不确定。

## KPI

- 邮件转任务转换延迟
- 未处理重要邮件积压数量
- 收件箱来源任务的完成率

## 安全注意事项

- 使用最小权限的 Gmail 范围。
- 此流程中切勿自动发送外发邮件。

## 回滚

```bash
openclaw cron delete <job-id>
```
