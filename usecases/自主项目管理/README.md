# 基于子智能体的自主项目管理

管理包含多个并行工作流的复杂项目令人疲惫。你最终会在不同工具间不断切换上下文、跟踪状态，并手动协调交接。

本用例实现了一种去中心化的项目管理模式，子智能体自主执行任务，通过共享状态文件进行协调，而非依赖中央调度器。

## 痛点

传统的调度器模式会造成瓶颈——主智能体变成了交通警察。对于复杂项目（多仓库重构、研究冲刺、内容流水线），你需要能够并行工作而无需持续监督的智能体。

## 功能概述

- **去中心化协调**：智能体通过共享的 `STATE.yaml` 文件进行读写
- **并行执行**：多个子智能体同时处理独立任务
- **无调度器开销**：主会话保持精简（CEO模式——仅负责战略）
- **自文档化**：所有任务状态持久保存在版本控制文件中

## 核心模式：STATE.yaml

每个项目维护一个 `STATE.yaml` 文件作为唯一事实来源：

```yaml
# STATE.yaml - 项目协调文件
project: website-redesign
updated: 2026-02-10T14:30:00Z

tasks:
  - id: homepage-hero
    status: in_progress
    owner: pm-frontend
    started: 2026-02-10T12:00:00Z
    notes: "正在处理响应式布局"
    
  - id: api-auth
    status: done
    owner: pm-backend
    completed: 2026-02-10T14:00:00Z
    output: "src/api/auth.ts"
    
  - id: content-migration
    status: blocked
    owner: pm-content
    blocked_by: api-auth
    notes: "等待新的端点模式定义"

next_actions:
  - "pm-content: api-auth 已完成，恢复迁移工作"
  - "pm-frontend: 与设计团队评审首页主图"
```

## 工作原理

1. **主智能体接收任务** → 以明确范围启动子智能体
2. **子智能体读取 STATE.yaml** → 找到分配的任务
3. **子智能体自主执行** → 更新 STATE.yaml 进度
4. **其他智能体轮询 STATE.yaml** → 获取已解除阻塞的工作
5. **主智能体定期检查** → 审视状态，调整优先级

## 所需技能

- `sessions_spawn` / `sessions_send` 用于子智能体管理
- 文件系统访问权限用于 STATE.yaml
- Git 用于状态版本控制（可选但推荐）

## 配置：AGENTS.md

```text
## PM 委派模式

主会话 = 仅负责协调。所有执行工作交给子智能体。

工作流：
1. 新任务到达
2. 检查 PROJECT_REGISTRY.md 中是否已有对应的 PM
3. 如果 PM 已存在 → sessions_send(label="pm-xxx", message="[任务]")
4. 如果是新项目 → sessions_spawn(label="pm-xxx", task="[任务]")
5. PM 执行任务，更新 STATE.yaml，并向主会话汇报
6. 主智能体向用户总结结果

规则：
- 主会话：最多 0-2 次工具调用（仅 spawn/send）
- PM 拥有各自独立的 STATE.yaml 文件
- PM 可以为并行子任务启动下级子智能体
- 所有状态变更均提交到 git
```

## 示例：启动一个 PM

```text
用户："重构认证模块并更新文档"

主智能体：
1. 检查注册表 → 没有活跃的 pm-auth
2. 启动：sessions_spawn(
     label="pm-auth-refactor",
     task="重构认证模块，更新文档。在 STATE.yaml 中跟踪进度"
   )
3. 回复："已启动 pm-auth-refactor。完成后我会向你汇报。"

PM 子智能体：
1. 创建 STATE.yaml 并分解任务
2. 逐步执行任务，更新状态
3. 提交变更
4. 向主会话报告完成情况
```

## 核心洞察

- **STATE.yaml > 调度器**：基于文件的协调比消息传递更具扩展性
- **Git 作为审计日志**：提交 STATE.yaml 变更以保留完整历史
- **标签命名规范很重要**：使用 `pm-{项目}-{范围}` 便于跟踪
- **精简主会话**：主智能体做得越少，响应越快

## 灵感来源

本模式受 [Nicholas Carlini 的方法](https://nicholas.carlini.com/)启发——让智能体自我组织而非微观管理。

## 相关链接

- [OpenClaw 子智能体文档](https://github.com/openclaw/openclaw)
- [Anthropic：构建高效智能体](https://www.anthropic.com/research/building-effective-agents)
