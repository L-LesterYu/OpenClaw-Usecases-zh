# 31 - 依赖漂移监控塔

基于依赖更新和未解决的包漂移，构建周期性的优先级依赖风险队列。

## 技能栈

```bash
npx clawhub@latest install github
npx clawhub@latest install summarize
npx clawhub@latest install todoist
```

## 功能说明

- 扫描已配置工程工具中的依赖更新和未解决的包漂移
- 按风险、重复率和交付影响对问题进行排序
- 生成优先级依赖风险队列供运维人员审查

## 安装配置

```bash
export TARGET_SCOPE='core services'
export LOOKBACK_DAYS='7'
export DELIVERY_CHANNEL='slack'
export DELIVERY_TARGET='channel:C1234567890'
export CRON_EXPR='37 15 * * 1-5'
export CRON_NAME='Dependency Drift Watchtower'
```

```bash
bash examples/runnable/31-dependency-drift-watchtower/scripts/check_prereqs.sh
bash examples/runnable/31-dependency-drift-watchtower/scripts/install_cron.sh
```

## 冒烟测试

- 运行一次并验证优先级依赖风险队列包含有证据支撑的优先级排序。
- 确认不会自动执行任何外部操作，且所有草稿输出均可供审查。

## 关键指标

- 超过 SLA 的漏洞项
- 分诊延迟
- 重复问题漏检率

## 安全说明

- 首次部署时使用只读仓库或分析作用域。
- 仅向可信工程渠道推送结果，后续写入操作需人工审查。

## 失败模式

- 缺少仓库作用域可能隐藏关键上下文。
- 噪声数据可能导致低价值问题排名过高，需调整阈值。

## 回滚

```bash
openclaw cron delete <job-id>
```
