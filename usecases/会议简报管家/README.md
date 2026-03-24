# 04 - 会议简报管家

在预定会议开始前自动生成上下文简报。

## 技能依赖

```bash
npx clawhub@latest install gog
npx clawhub@latest install summarize
npx clawhub@latest install notion
```

## 功能说明

- 读取日历中的即将召开的会议
- 拉取相关邮件、文档和笔记
- 为每场会议生成一页式简报

## 配置

```bash
export LOOKAHEAD_HOURS='24'
export DELIVERY_CHANNEL='slack'
export DELIVERY_TARGET='channel:C1234567890'
export CRON_EXPR='0 * * * 1-5'
export CRON_NAME='Meeting Briefing Concierge'
```

```bash
bash examples/runnable/04-meeting-briefing-concierge/scripts/check_prereqs.sh
bash examples/runnable/04-meeting-briefing-concierge/scripts/install_cron.sh
```

## 冒烟测试

- 触发一次运行，验证简报是否包含会议目标、参会人员、前置上下文和待解决问题。

## KPI

- 会议准备时间
- 会议后决策闭环率

## 安全注意事项

- 将简报投递限制在私有频道内。
- 避免将敏感会议笔记发送到广泛群组。

## 回滚

```bash
openclaw cron delete <job-id>
```
