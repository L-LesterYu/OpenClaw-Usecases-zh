# 05 - 内容创意挖掘器

每周内容流水线，将最新的网页和视频信号转化为可直接用于生产的内容创意简报。

## 技能栈

```bash
npx clawhub@latest install tavily-search
npx clawhub@latest install youtube-watcher
npx clawhub@latest install summarize
npx clawhub@latest install notion
```

## 功能说明

- 从网页和 YouTube 采集最新信号
- 过滤重复内容和低质量创意
- 生成带来源佐证的高质量创意排名列表

## 安装配置

```bash
export TOPIC='openclaw automation'
export DELIVERY_CHANNEL='slack'
export DELIVERY_TARGET='channel:C1234567890'
export CRON_EXPR='0 9 * * 1'
export CRON_NAME='Content Idea Miner'
```

```bash
bash examples/runnable/05-content-idea-miner/scripts/check_prereqs.sh
bash examples/runnable/05-content-idea-miner/scripts/install_cron.sh
```

## 冒烟测试

- 手动运行应输出 5-10 个带来源和建议标题的排名创意。

## KPI 指标

- 创意到发布的转化率
- 从创意到初稿的平均耗时

## 安全注意事项

- API 密钥请存储在环境变量中，切勿写入提示文本。
- 除非已获得明确的内部授权，否则仅保存公开来源链接。

## 回滚

```bash
openclaw cron delete <job-id>
```
