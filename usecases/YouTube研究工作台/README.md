# 15 - YouTube 研究工作台

将 YouTube 定向监控转化为结构化的、可执行的研究笔记。

## 技能栈

```bash
npx clawhub@latest install youtube-watcher
npx clawhub@latest install summarize
npx clawhub@latest install notion
npx clawhub@latest install slack
```

## 功能说明

- 监控已跟踪的频道/主题的新视频
- 基于字幕生成洞见摘要
- 发布结构化笔记，包含关键要点和行动建议

## 配置

```bash
export YOUTUBE_TOPIC='agentic automation'
export LOOKBACK_DAYS='7'
export MAX_VIDEOS='12'
export DELIVERY_CHANNEL='slack'
export DELIVERY_TARGET='channel:C1234567890'
export CRON_EXPR='30 9 * * 1'
export CRON_NAME='YouTube Research Desk'
```

```bash
bash examples/runnable/15-youtube-research-desk/scripts/check_prereqs.sh
bash examples/runnable/15-youtube-research-desk/scripts/install_cron.sh
```

## 冒烟测试

- 运行一次，验证每条摘要都引用了真实的视频链接。
- 确认输出区分了事实、观点和推测性声明。

## KPI

- 研究综合耗时
- 高价值洞见捕获率
- 从监控视频中生成的内容创意数量

## 安全注意事项

- 除非获得授权，否则仅使用公开视频。
- 将内部解读笔记保存在私有工作区中。

## 回滚

```bash
openclaw cron delete <job-id>
```
