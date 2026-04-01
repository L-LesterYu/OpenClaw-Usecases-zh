# 基于 Ollama 开源模型的 Manus 级自主智能体

**分类：** AI 与大语言模型 / 生产力
**技能：** [manusilized](https://github.com/wd041216-bit/manusilized)

## 功能介绍

使用开源 Ollama 模型运行完全自主的 AI 智能体——无需 API 密钥。部署在本地硬件上时，还可避免云服务费用并将所有数据保留在本地。支持云端/VPS 部署，但数据隐私取决于你的托管环境。

> **"Manus 级"的含义：** 目标能力是让智能体能够自主完成多步骤的真实世界任务（研究、编码、数据分析），具备实时流式输出、连续 10 轮以上的可靠工具调用，以及上下文感知的长期规划能力——匹配 [Manus](https://manus.im)（Manus AI 的自主 AI 智能体平台）或 Claude Sonnet 在日常生产力任务中的体验。

`manusilized` 通过补丁方式增强 OpenClaw 的 Ollama 核心集成层，解锁三个此前仅限闭源模型（如 GPT-4 或 Claude）才能使用的能力：

1. **实时流式输出** — 像 [Manus](https://manus.im) 一样逐 token 观看智能体的思考和行动过程
2. **可靠的工具调用** — 开源模型（GLM-5、Qwen3、DeepSeek V3.2、Kimi-K2.5）现在可以可靠地调用工具，即使输出 Markdown 而非结构化 JSON
3. **长程任务处理** — 上下文压缩让智能体能够处理复杂的多步骤任务而不触碰 token 限制

**示例任务：** 让智能体研究一个主题，浏览 5 篇论文，并撰写一份 2 页的执行摘要——整个过程通过流式输出实时观看。

## 使用场景示例

### 1. 自主研究智能体

让智能体研究一个主题，浏览网页，总结发现，并撰写报告——全程通过流式输出实时观看。

```text
Research the latest developments in quantum computing, visit 5 relevant papers,
and write a 2-page executive summary with citations.
```

### 2. 全栈代码生成

让智能体搭建完整项目、编写测试、修复 Bug 并提交到 GitHub——仅使用本地 Qwen3-Coder 模型。

```text
Create a FastAPI backend with JWT auth, SQLite database, and Docker support.
Write tests and push to my GitHub repo.
```

### 3. 多步骤数据分析

将 CSV 文件交给智能体，自动完成数据清洗、分析、图表生成和 PDF 报告——全部在本地完成。

```text
Analyze this sales data, identify trends, create visualizations,
and generate a board-ready PDF report.
```

## 安装设置

### 前置条件
- 已安装 [OpenClaw](https://github.com/openclaw/openclaw)
- [Ollama](https://ollama.com) 在本地或云端 VPS 上运行

### 安装步骤

```bash
# 1. 克隆 manusilized
git clone https://github.com/wd041216-bit/manusilized
cd manusilized

# 2. 应用 OpenClaw 核心集成补丁
bash install-patch.sh /path/to/your/openclaw

# 3. 拉取推荐模型
ollama pull qwen3-coder   # 编码任务表现强劲
ollama pull glm-5         # 推理与规划能力出色
ollama pull deepseek-v3.2 # 综合表现均衡

# 4. 配置 OpenClaw 使用 Ollama
# 在 OpenClaw 设置中选择 Ollama 作为提供商
```

## 推荐模型

*评估结果基于社区基准测试和内部测试（截至 2026 年 3 月）。*

| 任务类型 | 模型 | 说明 |
|---------|------|------|
| 通用推理与规划 | `glm-5` | 在热门开源模型中（截至 2026 年 3 月）具备出色的混合专家（MoE）推理能力 |
| 代码生成 | `qwen3-coder` | 以卓越的代码生成质量著称（截至 2026 年 3 月） |
| 长上下文任务 | `kimi-k2.5` | 256K 上下文窗口（截至 2026 年 3 月） |
| 快速响应 | `deepseek-v3.2` | 速度与质量兼顾（截至 2026 年 3 月） |
| 视觉任务 | `qwen3-vl` | 强大的视觉理解能力（截至 2026 年 3 月） |

## 为什么重要

在 `manusilized` 之前，在 OpenClaw 中使用 Ollama 意味着：
- ❌ 等待完整响应生成后才能看到输出（无流式传输）
- ❌ 模型以 Markdown 格式输出工具调用时频繁崩溃
- ❌ 任务在 10-15 轮后因上下文溢出而失败

使用 `manusilized` 后：
- ✅ 实时 token 流式传输——观看智能体思考过程
- ✅ 在我们的测试中，开源模型的工具调用成功率可达 95% 以上（在 Qwen3-32B、GLM-5 和 DeepSeek V3.2 上测试了 200 个工具调用场景，2026 年 3 月）
- ✅ 通过智能上下文压缩显著延长任务执行长度
- ✅ 智能错误恢复——智能体从失败中学习

## 贡献

欢迎在 [github.com/wd041216-bit/manusilized](https://github.com/wd041216-bit/manusilized) 提交 Issue 和 PR。
