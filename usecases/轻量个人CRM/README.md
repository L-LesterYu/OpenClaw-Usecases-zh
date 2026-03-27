# 13 - 轻量个人CRM

基于近期邮件和日历活动构建轻量级联系人记忆系统。

## 技能栈

```bash
npx clawhub@latest install gog
npx clawhub@latest install summarize
npx clawhub@latest install notion
```

## 功能说明

- 拉取关键联系人的近期互动记录
- 汇总关系上下文和未闭环事项
- 为即将到来的会议生成会前简报

## 设置

```bash
export CONTACT_FILTER='from:important@ OR to:important@'
export LOOKBACK_DAYS='30'
export MAX_CONTACTS='20'
export DELIVERY_CHANNEL='slack'
export DELIVERY_TARGET='channel:C1234567890'
export CRON_EXPR='0 7 * * 1-5'
export CRON_NAME='Personal CRM Lite'
```

```bash
bash examples/runnable/13-personal-crm-lite/scripts/check_prereqs.sh
bash examples/runnable/13-personal-crm-lite/scripts/install_cron.sh
```

## 冒烟测试

- 运行一次，确认摘要包含上次互动、未完成承诺和下次跟进建议。
- 验证输出中不包含编造的关系细节。

## KPI

- 会前准备时间
- 跟进完成率
- 每月遗漏承诺数

## 安全注意事项

- 将输出投递限制在私有频道。
- 保持 Gmail 权限范围最小化。

## 回滚

```bash
openclaw cron delete <job-id>
```
