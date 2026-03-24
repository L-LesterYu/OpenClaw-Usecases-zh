# 06 - PDF文档处理工作台

面向PDF/音频重度处理场景的自动化文档接收与处理流程。

## 技能栈

```bash
npx clawhub@latest install nano-pdf
npx clawhub@latest install summarize
npx clawhub@latest install openai-whisper
```

## 功能说明

- 扫描工作目录中的新增PDF/音频文件
- 自动摘要新增文档内容
- 为PDF文件建议编辑操作
- 转录音频笔记并提取行动项

## 安装配置

```bash
export SOURCE_DIR="$PWD/inbox"
export DELIVERY_CHANNEL='slack'
export DELIVERY_TARGET='channel:C1234567890'
export CRON_EXPR='0 10 * * 1-5'
export CRON_NAME='PDF Ops Desk'
```

```bash
bash examples/runnable/06-pdf-ops-desk/scripts/check_prereqs.sh
bash examples/runnable/06-pdf-ops-desk/scripts/install_cron.sh
```

## 冒烟测试

1. 在 `SOURCE_DIR` 中放置一个PDF文件。
2. 手动触发定时任务运行。
3. 确认生成了摘要和建议的编辑指令。

## 关键指标

- 文件到达后生成摘要的时间
- 每份文档所需的人工编辑工作量

## 安全提示

- 仅处理受控目录中的可信文件。
- 如文档包含敏感数据，请将摘要保留在私有频道中。

## 回滚

```bash
openclaw cron delete <job-id>
```
