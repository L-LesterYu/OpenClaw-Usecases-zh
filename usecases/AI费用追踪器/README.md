# 💸 AI费用追踪器

> 精确掌握你的AI开支。拒绝意外账单，只做优化。

---

## 问题背景

AI API 费用增长快且难以预测。你在不同工具和项目中使用 Claude、GPT-4、Gemini 等多个模型。账单到了却不知道费用飙升的原因，也不知道如何优化。

---

## 解决方案

OpenClaw 跨所有服务商追踪你的 AI 用量，对异常支出发出告警，识别费用优化机会，并帮助你为每个任务选择最合适的模型。

---

## 设置指南

### 步骤一：安装追踪技能

```bash
openclaw skill install claude-code-usage
openclaw skill install codex-quota
openclaw skill install minimax-usage
```

### 步骤二：配置服务商

创建 `~/openclaw/ai-costs/providers.json`：

```json
{
  "providers": [
    {
      "name": "Anthropic",
      "budgetMonthly": 100,
      "alertThreshold": 80
    },
    {
      "name": "OpenAI",
      "budgetMonthly": 50,
      "alertThreshold": 80
    },
    {
      "name": "Google",
      "budgetMonthly": 30,
      "alertThreshold": 80
    }
  ],
  "totalBudget": 200
}
```

### 步骤三：设置费用规则

创建 `~/openclaw/ai-costs/rules.md`：

```markdown
# AI 费用优化规则

## 模型选择
- 简单任务：使用最便宜的模型（GPT-3.5、Claude Instant）
- 复杂推理：使用最强模型
- 批量处理：有批处理 API 时优先使用

## 告警
- 日支出 > $10：警告
- 周支出 > $40：告警
- 接近预算 80%：告警

## 每周回顾
- 最高费用任务
- 潜在的模型降级机会
- 未使用的订阅
```

---

## 所需技能

| 技能 | 用途 |
|------|------|
| `claude-code-usage` | Claude/Anthropic 用量 |
| `codex-quota` | OpenAI Codex 用量 |
| `minimax-usage` | MiniMax 用量 |

---

## 示例提示词

**每日检查：**
```
我今天所有服务商的 AI 支出是多少？有没有异常飙升？
```

**优化分析：**
```
分析我这周的 AI 用量。我在哪些地方超支了？哪些任务可以用更便宜的模型？
```

**预算规划：**
```
根据我的使用模式，我的月度 AI 预算应该是多少？每个任务是否使用了最合适的模型？
```

**服务商对比：**
```
对于 [任务类型]，比较 Claude、GPT-4 和 Gemini 的费用。哪个性价比最高？
```

---

## 定时任务

```
0 20 * * *     # 晚上8点 - 每日支出摘要
0 9 * * 1      # 周一上午9点 - 每周费用报告
0 0 1 * *      # 每月1号 - 月度分析
*/30 * * * *   # 每30分钟 - 预算告警检查
```

---

## 预期效果

**第一周：**
- AI 支出全面可视化
- 预算告警配置完成

**第一个月：**
- 通过优化实现 20-30% 的费用降低
- 不再有意外账单
- 清晰的按项目费用归因

**持续运行：**
- AI 费用可预测
- 模型选择有依据
- 预算始终可控
