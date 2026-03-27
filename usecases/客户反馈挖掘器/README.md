# 18 - 客户反馈挖掘器

聚合反馈信号，聚类主题，并生成产品级可执行简报。

## 技能栈

```bash
npx clawhub@latest install slack
npx clawhub@latest install summarize
npx clawhub@latest install notion
```

## 功能说明

- 从目标频道/线程拉取反馈
- 聚类重复的痛点和需求
- 生成带证据和建议负责人的优先主题列表

## 配置

```bash
export FEEDBACK_CHANNELS='support,product-feedback,customer-success'
export WINDOW_HOURS='168'
export MIN_MENTIONS='3'
export DELIVERY_CHANNEL='slack'
export DELIVERY_TARGET='channel:C1234567890'
export CRON_EXPR='0 10 * * 1'
export CRON_NAME='Customer Feedback Miner'
```

```bash
bash examples/runnable/18-customer-feedback-miner/scripts/check_prereqs.sh
bash examples/runnable/18-customer-feedback-miner/scripts/install_cron.sh
```

## 冒烟测试

- 运行一次，确认主题包含支持性的消息链接。
- 验证低信号的一次性评论与重复模式已被分离。

## KPI

- 识别主要重复投诉的时间
- 反馈到路线图的映射率
- 主要重复主题的解决进度

## 安全说明

- 不要将私有客户标识符暴露到公开频道。
- 将频道读取权限限制在所需范围内。

## 回滚

```bash
openclaw cron delete <job-id>
```
