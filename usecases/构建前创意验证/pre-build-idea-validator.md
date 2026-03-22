# 构建前创意验证

在 OpenClaw 开始构建任何新东西之前，它会自动检查该创意是否已经在 GitHub、Hacker News、npm、PyPI 和 Product Hunt 上存在——并根据发现的结果调整策略。

## 功能介绍

- 在编写任何代码之前扫描 5 个真实数据源（GitHub、Hacker News、npm、PyPI、Product Hunt）
- 返回一个 `reality_signal` 评分（0-100），指示该领域有多拥挤
- 显示带星标数和描述的顶级竞争对手
- 当该领域饱和时建议转向方向
- 作为构建前关卡：高信号 = 停下来讨论，低信号 = 继续推进

## 痛点

你告诉智能体"帮我做一个 AI 代码审查工具"，它愉快地花了 6 小时写代码。与此同时，GitHub 上已有 143,000+ 个相关仓库——最好的那个有 53,000 颗星。智能体从未检查，因为你从未要求，它也不知道要去看。你在投入大量时间后才发现竞争对手。这个模式在每个新项目创意上反复出现。

## 所需技能

- [idea-reality-mcp](https://github.com/mnemox-ai/idea-reality-mcp) — 扫描真实数据源并返回竞争评分的 MCP 服务器

## 设置方法

1. 安装 idea-reality-mcp：

```bash
uvx idea-reality-mcp
```

2. 将 MCP 服务器添加到你的 OpenClaw 配置中：

```json
{
  "mcpServers": {
    "idea-reality": {
      "command": "uvx",
      "args": ["idea-reality-mcp"]
    }
  }
}
```

3. 在你的 OpenClaw 智能体指令中添加：

```text
Before starting any new project, feature, or tool, always run idea_check first.

Rules:
- If reality_signal > 70: STOP. Report the top 3 competitors with star counts.
  Ask me if I want to proceed, pivot, or abandon.
- If reality_signal 30-70: Show me the results and pivot_hints.
  Suggest a niche angle that existing projects don't cover.
- If reality_signal < 30: Proceed to build.
  Mention that the space is open.
- Always show the reality_signal score and top competitors before writing any code.
```

## 实际案例

**你：** "帮我做一个 AI 代码审查 CLI 工具"

OpenClaw 运行 `idea_check("AI code review tool")` 并回复：

> **reality_signal: 90/100（非常高）**
>
> 顶级竞争对手：
> 1. Gitea — 53,940 颗星
> 2. reviewdog — 9,104 颗星
> 3. Danger (Ruby) — 5,649 颗星
>
> 该领域有 143,000+ 个相关仓库。头部玩家已经成熟且资金充足。
>
> **转向建议：**
> - 聚焦特定语言（仅 Rust/Go 的 AI 代码审查）
> - 瞄准特定框架（React/Vue 组件审查）
> - 瞄准特定行业（金融/医疗代码合规审查）
>
> 我应该以差异化角度继续，还是转向其他方向？

**你：** "构建前创意验证的 MCP 服务器呢？"

> **reality_signal: 8/100（非常低）**
>
> 在 PyPI 或 npm 上找到 0 个直接竞争对手。GitHub 上有一些间接相关的仓库，但没有一个解决这个确切问题。
>
> 该领域完全开放。继续构建。

## 变体用法

- **深度模式用于重大决策**：使用 `depth="deep"` 并行扫描全部 5 个数据源（GitHub + HN + npm + PyPI + Product Hunt），用于重大项目决策。
- **批量验证**：在黑客马拉松前，给 OpenClaw 一个包含 10 个创意的列表，让它按 `reality_signal` 排名——最低分 = 最原创的机会。
- **先试用网页版**：无需安装即可在 [mnemox.ai/check](https://mnemox.ai/check) 试用，看看工作流是否适合你。

## 核心洞察

- 这防止了构建中最昂贵的错误：**解决一个已经被解决的问题**。
- `reality_signal` 基于真实数据（仓库数量、星标分布、HN 讨论量），而非 LLM 猜测。
- 高分不意味着"不要构建"——它意味着"要么差异化，要么别费心"。
- 低分意味着真正存在空白空间。那是独立开发者胜算最大的地方。

## 相关链接

- [idea-reality-mcp GitHub](https://github.com/mnemox-ai/idea-reality-mcp)
- [网页版试用](https://mnemox.ai/check)（无需安装）
- [PyPI](https://pypi.org/project/idea-reality-mcp/)
