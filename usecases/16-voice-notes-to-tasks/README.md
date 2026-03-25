# 16 - 语音笔记转任务

将新的语音笔记自动转化为可执行的、带优先级的任务队列。

## 技能栈

```bash
npx clawhub@latest install openai-whisper
npx clawhub@latest install summarize
npx clawhub@latest install todoist
```

## 功能说明

- 扫描音频收件箱中的新笔记
- 转录并摘要每条笔记
- 提取任务，包含负责人、截止日期和置信度标签

## 配置

```bash
export SOURCE_DIR="$PWD/voice-inbox"
export MAX_FILES='10'
export TRANSCRIPT_LANGUAGE='en'
export DELIVERY_CHANNEL='slack'
export DELIVERY_TARGET='channel:C1234567890'
export CRON_EXPR='*/30 8-20 * * 1-5'
export CRON_NAME='Voice Notes to Tasks'
```

```bash
bash examples/runnable/16-voice-notes-to-tasks/scripts/check_prereqs.sh
bash examples/runnable/16-voice-notes-to-tasks/scripts/install_cron.sh
```

## 冒烟测试

1. 将一个简短的 `.m4a` 或 `.wav` 文件放入 `SOURCE_DIR`。
2. 手动运行一次定时任务。
3. 确认转录内容和提取的任务已输出，且来源映射清晰。

## KPI

- 笔记转任务转化率
- 音频衍生任务的完成率
- 笔记处理节省的时间

## 安全提示

- 仅处理受信任的本地文件。
- 将转录内容保留在私有频道/工作空间中。

## 回滚

```bash
openclaw cron delete <job-id>
```
