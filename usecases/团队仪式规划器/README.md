# 100 - 团队仪式规划器

基于团队仪式、会议卫生和运营节奏信号，构建周期性团队仪式数据包。

## 技能栈

```bash
npx clawhub@latest install caldav-calendar
npx clawhub@latest install gog
npx clawhub@latest install summarize
npx clawhub@latest install slack
```

## 功能说明

- 从人员工作流中收集团队仪式、会议卫生和运营节奏信号
- 标记延迟、就绪缺口和协调风险
- 生成团队仪式数据包，供招聘或人事负责人使用

## 配置

```bash
export TEAM_SCOPE='team cadence'
export MAX_ITEMS='20'
export DELIVERY_CHANNEL='slack'
export DELIVERY_TARGET='channel:C1234567890'
export CRON_EXPR='40 12 * * 1'
export CRON_NAME='Team Ritual Planner'
```

```bash
bash examples/runnable/100-team-ritual-planner/scripts/check_prereqs.sh
bash examples/runnable/100-team-ritual-planner/scripts/install_cron.sh
```

## 冒烟测试

- 运行一次并验证团队仪式数据包包含有证据支撑的优先级排序。
- 确认不会自动执行任何外部操作，所有草稿输出均可审查。

## 关键指标

- 仪式出席一致性
- 周期耗时
- 完成率

## 安全注意事项

- 将候选人和员工数据的访问权限限制在已批准的人事运营空间内。
- 避免在广泛分发的渠道中存储敏感的招聘或人事详细信息。

## 失败模式

- 不完整的笔记或评分卡可能削弱优先级排序效果。
- 敏感的人事数据绝不应发送到广泛分发的渠道。

## 回滚

```bash
openclaw cron delete <job-id>
```
