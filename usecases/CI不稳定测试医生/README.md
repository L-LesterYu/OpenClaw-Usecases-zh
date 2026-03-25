# CI 不稳定测试医生

定期检测 CI 不稳定测试并构建修复队列。

## 技能栈

```bash
npx clawhub@latest install github
npx clawhub@latest install summarize
npx clawhub@latest install todoist
```

## 功能说明

- 扫描近期失败的 CI 运行记录
- 按测试路径/签名对失败进行聚类分析
- 通过重复频率和间歇性特征识别可能的不稳定测试
- 创建优先级修复任务并发布摘要报告

## 配置

```bash
export REPO='owner/repo'
export LOOKBACK_DAYS='7'
export DELIVERY_CHANNEL='slack'
export DELIVERY_TARGET='channel:C1234567890'
export CRON_EXPR='15 9 * * 1-5'
export CRON_NAME='CI Flake Doctor'
```

```bash
bash examples/runnable/07-ci-flake-doctor/scripts/check_prereqs.sh
bash examples/runnable/07-ci-flake-doctor/scripts/install_cron.sh
```

## 冒烟测试

- 手动触发一次运行，验证重复失败是否按签名正确分组。
- 确认输出至少包含一条具体的修复建议。

## 关键指标

- 每周不稳定测试失败数量
- CI 重跑率
- 不稳定问题平均修复时间

## 安全注意事项

- 首次部署时，GitHub 访问权限建议保持只读。
- 创建高优先级任务前需经过人工审核。

## 回滚

```bash
openclaw cron delete <job-id>
```
