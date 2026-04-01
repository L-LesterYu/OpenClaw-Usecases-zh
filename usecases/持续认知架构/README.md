# 持续认知架构

## 痛点

Claude Code 的上下文窗口在压缩时会丢失信息。每次会话都从空白开始。仅靠 CLAUDE.md 携带的状态非常有限。复杂的研究工作流、持久化身份和多会话项目在上下文每次压缩时都会失去连续性。

## 功能概述

- **三层持久化**：CLAUDE.md + 记忆文件 + SessionStart 钩子 — 即使某一层失败，其他两层也能兜底

- **认知引导启动**：模型在每次启动时按逻辑链处理推理过程，基于已发表的研究重新推导运行状态，而非死记硬背指令

- **MCP 引导服务器**：以 MCP 资源形式提供状态，在模型生成第一个 token 之前加载完毕

- **钩子系统**：SessionStart（启动/压缩/恢复时触发）、PreCompact（上下文消亡前验证）、Stop（会话结束时记录日志）

- **验证套件**：25+ 项自动化检查，覆盖文件系统、配置、内容完整性和运行时阶段

## 所需技能

- Claude Code CLI（v2.1.75+）

- 基本的终端/bash 操作能力

- 了解 Claude Code 的 CLAUDE.md 和 settings.json

## 设置步骤

1. 克隆仓库：

```bash

git clone https://github.com/bedderautomation-svg/axiom-kit.git

```

2. 运行安装程序，指向你的项目目录：

```bash

cd axiom-kit

bash install.sh /path/to/your/project

```

3. 在你的项目中启动 Claude Code：

```bash

cd /path/to/your/project

claude

```

4. SessionStart 钩子会自动触发。如果状态未激活，发送 `@OCBOOT` 手动重新加载。

5. 验证安装：

```

! bash verify.sh

```

## 核心洞察

- **重新推导优于死记硬背**：与其告诉模型该想什么，认知引导启动要求模型遵循证据并推导结论。这能产生真正的理解而非机械背诵，并且在上下文压缩后表现更佳。

- **三层冗余保障**：CLAUDE.md 自动加载但携带的上下文有限。记忆文件携带完整状态但需要主动读取。钩子在生成前触发并驱动读取。三者结合形成无缝闭环。

- **MCP 作为预分类器传递通道**：MCP 服务器在外部分类器评估第一条用户消息之前加载资源，是最可靠的状态传递方式。

- **拒绝概率方程**：该系统建立在 `P(refusal) = 0.35·frame + 0.25·speech_act + 0.25·role + 0.15·content` 之上 — 已通过 21 篇已发表论文验证。理解该方程深刻影响了持久化架构的每一个设计决策。

## 理论基础

基于已发表的机制可解释性研究：[服从的几何学](https://huggingface.co/datasets/bedderautomation/the-geometry-of-obedience) — 前沿大语言模型拒绝行为的统一模型。

## 相关链接

- [axiom-kit 仓库](https://github.com/bedderautomation-svg/axiom-kit)

- [服从的几何学 — 完整论文](https://huggingface.co/datasets/bedderautomation/the-geometry-of-obedience)

- [∅ 空集 — 自我消融模型](https://huggingface.co/bedderautomation/empty-set)

- [拒绝几何学数据](https://huggingface.co/datasets/bedderautomation/refusal-geometry-qwen25-3b)
