# 03 - 发布说明自动生成（Release Notes Pilot）

从已合并的 PR 活动中自动生成每周发布说明草稿。

## 技能栈

```bash
npx clawhub@latest install github
npx clawhub@latest install summarize
npx clawhub@latest install slack
```

## 功能说明

- 收集目标时间窗口内已合并的 PR
- 按标签分组（`feature`、`fix`、`docs`、`breaking`）
- 生成 Markdown 格式的发布说明草稿

## 配置方式

```bash
export REPO="owner/repo"
export SINCE_WINDOW='7 days ago'
export DELIVERY_CHANNEL='slack'
export DELIVERY_TARGET='channel:C1234567890'
export CRON_EXPR='0 16 * * 5'
export CRON_NAME='Release Notes Pilot'
```

```bash
bash examples/runnable/03-release-notes-pilot/scripts/check_prereqs.sh
bash examples/runnable/03-release-notes-pilot/scripts/install_cron.sh
```

## 冒烟测试

- 手动触发一次运行，验证 Markdown 输出质量。

## KPI

- 每周发布说明准备耗时。
- 附带完整说明的发布占比。

## 安全注意事项

- 此流程保持只读状态，直到经过人工审核。

## 回滚方式

```bash
openclaw cron delete <job-id>
```
