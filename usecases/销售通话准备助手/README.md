# 17 - 销售通话准备助手

基于账户历史、日历上下文和待处理事项，自动生成简明的通话前简报。

## 技能栈

```bash
npx clawhub@latest install gog
npx clawhub@latest install summarize
npx clawhub@latest install notion
```

## 功能说明

- 拉取即将到来的外部会议
- 收集相关邮件和笔记上下文
- 生成结构化通话前简报，包含风险和目标

## 配置

```bash
export LOOKAHEAD_HOURS='48'
export TARGET_SEGMENT='enterprise'
export DELIVERY_CHANNEL='slack'
export DELIVERY_TARGET='channel:C1234567890'
export CRON_EXPR='0 7 * * 1-5'
export CRON_NAME='Sales Call Prep Bot'
```

```bash
bash examples/runnable/17-sales-call-prep-bot/scripts/check_prereqs.sh
bash examples/runnable/17-sales-call-prep-bot/scripts/install_cron.sh
```

## 冒烟测试

- 触发一次运行，确认简报包含目标、利益相关者上下文和待处理商机。
- 确认缺失的上下文被明确标注。

## KPI

- 每次通话的准备时间
- 有准备 vs 无准备通话的转化率
- 后续跟进完成率

## 安全注意事项

- 客户数据仅发送到私有频道。
- 邮件/日历访问使用最小权限范围。

## 回滚

```bash
openclaw cron delete <job-id>
```
