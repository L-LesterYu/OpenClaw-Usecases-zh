# 01 - PR雷达

为单个或多个仓库持续生成PR分类摘要报告。

## 技能栈

npx clawhub@latest install github
npx clawhub@latest install summarize
npx clawhub@latest install slack

## 功能说明

- 扫描开放PR和最近的CI运行状态
- 高亮标记阻塞、陈旧和可合并的PR
- 将行动导向的摘要推送到Slack/Telegram

## 配置步骤

1. 认证GitHub CLI：
gh auth status

2. 设置环境变量：
export REPO="owner/repo"
export DELIVERY_CHANNEL="slack"
export DELIVERY_TARGET="channel:C1234567890"
export CRON_EXPR="5 * * * *"
export CRON_NAME="PR Radar"

3. 验证前置条件：
bash examples/runnable/01-pr-radar/scripts/check_prereqs.sh

4. 安装定时任务：
bash examples/runnable/01-pr-radar/scripts/install_cron.sh

## 冒烟测试

openclaw cron list
openclaw cron run <job-id>

## 关键指标

- 首次评审耗时
- 陈旧PR数（>48小时）
- 合并耗时

## 安全注意事项

- 首次部署时使用只读GitHub权限范围。
- 将消息推送渠道限制在可信的团队空间内。
- 在不可信的入站上下文中，保持控制面工具处于拒绝状态。

## 回滚

openclaw cron delete <job-id>
