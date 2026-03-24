# 文档漂移哨兵

在代码/文档漂移演变为技术债务之前，自动检测并预警。

## 技能栈

```bash
npx clawhub@latest install github
npx clawhub@latest install notion
```

## 功能说明

- 审查关键代码路径中近期合并的 PR
- 标记可能需要更新文档的代码变更
- 生成带排名的漂移队列，并建议文档负责人

## 配置

```bash
export REPO='owner/repo'
export CODE_PATHS='src/,api/,sdk/'
export DOCS_PATH='docs/'
export WINDOW_DAYS='7'
export DELIVERY_CHANNEL='slack'
export DELIVERY_TARGET='channel:C1234567890'
export CRON_EXPR='30 10 * * 1-5'
export CRON_NAME='文档漂移哨兵'
```

```bash
bash examples/runnable/08-docs-drift-sentinel/scripts/check_prereqs.sh
bash examples/runnable/08-docs-drift-sentinel/scripts/install_cron.sh
```

## 冒烟测试

- 运行一次并确认输出包含带证据的漂移候选项。
- 确认每个候选项都有具体的文档操作建议。

## KPI

- 漂移告警在 7 天内解决的比例
- 与过时文档相关的支持工单数
- 从代码合并到文档更新的时间间隔

## 安全说明

- 保持 GitHub 访问权限为只读。
- 将报告发送到私有团队频道。

## 回滚

```bash
openclaw cron delete <job-id>
```
