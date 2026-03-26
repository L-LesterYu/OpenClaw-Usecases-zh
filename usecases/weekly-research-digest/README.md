# 14 - 每周研究摘要

通过网络搜索创建高信号每周摘要，附带简明的趋势洞察。

## 技能栈

```bash
npx clawhub@latest install tavily-search
npx clawhub@latest install summarize
npx clawhub@latest install slack
```

## 功能说明

- 为你追踪的主题收集最新信息源
- 按信号强度和新颖度对发现进行排序
- 生成包含趋势洞察和后续行动的简报

## 配置

```bash
export TOPIC_QUERY='openclaw automation trends'
export RESULT_LIMIT='20'
export DELIVERY_CHANNEL='slack'
export DELIVERY_TARGET='channel:C1234567890'
export CRON_EXPR='0 9 * * 1'
export CRON_NAME='Weekly Research Digest'
```

```bash
bash examples/runnable/14-weekly-research-digest/scripts/check_prereqs.sh
bash examples/runnable/14-weekly-research-digest/scripts/install_cron.sh
```

## 冒烟测试

- 运行一次，验证链接有效且无重复。
- 确认每条核心发现包含一条实践建议。

## KPI

- 摘要打开/阅读率
- 市场扫描节省的时间
- 每期摘要生成的行动项数量

## 安全注意事项

- API 密钥请保存在环境变量中。
- 除非明确允许，否则不要包含私有文档。

## 回滚

```bash
openclaw cron delete <job-id>
```
