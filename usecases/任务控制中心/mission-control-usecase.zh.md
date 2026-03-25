# 任务控制中心：OpenClaw 多智能体任务编排

## 概述

任务控制中心（Mission Control）是 OpenClaw 团队的实用运营层。它能自动扫描看板和聊天室来源的任务，根据能力矩阵将工作路由到合适的智能体，跟踪生命周期状态，并通过事件驱动的收件箱通知保持所有人步调一致。

## 问题

当多个智能体协作时，团队常常遇到：

- **权责不清**：没人知道哪个智能体负责哪个任务
- **任务状态不一致**：任务状态在各渠道间失去同步
- **交接上下文缺失**：一个智能体完成后，下一个不知道发生了什么
- **缺乏统一进度视图**：需要检查多个渠道才能了解整体进展

## 解决方案

任务控制中心结合了：

- **任务生命周期跟踪** — 从创建到完成的完整审计轨迹
- **事件总线与智能体收件箱** — 智能体通过结构化消息通信
- **编排计划** — 带依赖关系的多阶段工作流
- **状态与历史报告** — 实时运营可视化

这为多智能体执行创建了一个轻量级控制平面，无需复杂基础设施。

## 核心组件

```
Mission Control/
├── coordinator.py          # 编排与调度入口
├── tracker.py             # 任务生命周期持久化与统计
├── mission_control_events.py  # 事件总线 + 收件箱消息
├── orchestrator.py        # 多阶段计划模板与执行
└── state.json            # 持久化状态
```

### 核心功能

| 组件 | 功能 |
|------|------|
| **coordinator.py** | 扫描看板/聊天室，分配任务，运行定时任务 |
| **tracker.py** | 记录任务生命周期，计算统计数据，生成报告 |
| **mission_control_events.py** | 智能体间事件驱动消息传递 |
| **orchestrator.py** | 多阶段工作流模板（研究、代码审查、内容） |

## 工作流程

1. **创建/扫描任务**
   - 自动扫描 `Mission-Control-Kanban.md` 中的新任务
   - 监控聊天室消息中的任务请求

2. **分配任务**
   - 根据能力矩阵匹配任务到智能体（健康度、记忆、工具、能力、性能、问题）
   - 路由到合适的智能体（@coder、@vision、@fast、@main）

3. **跟踪生命周期**
   - 发出事件：`created` → `assigned` → `started` → `progress` → `completed` / `failed`
   - 在 `task_lifecycles.json` 中存储完整历史

4. **通知智能体**
   - 将通知投递到各智能体收件箱
   - 向事件总线发布事件供订阅者消费

5. **报告状态**
   - 生成每日简报
   - 跟踪指标（完成时间、失败率、智能体工作量）

## 为什么有效

- **事件驱动更新** 消除隐藏的状态变更
- **生命周期历史** 提供问责和可审计性
- **计划模板** 强制执行可重复的执行模式
- **智能体专属收件箱** 减少协调噪音

## 使用场景示例

### 1. 日常维护与可靠性检查

```
任务："运行系统健康检查"
→ 分配给：@main
→ 阶段：collect_metrics → analyze → report
→ 状态自动跟踪
```

### 2. 多智能体研究流水线

```
任务："研究 AI Agent 趋势"
→ 分配给：@fast（快速扫描）
→ 然后：@vision（深度分析）
→ 然后：@main（综合建议）
```

### 3. 跨智能体代码审查

```
任务："审查新功能代码"
→ 分配给：@coder（Codex 审查）
→ 然后：@coder2（Claude 审查）
→ 然后：@main（合并见解）
```

### 4. 自动化待办事项分类

```
任务："对 TODO 项进行优先级排序"
→ 自动扫描看板
→ 按优先级标签评分
→ 根据容量分配给智能体
```

## 所需技能

- `sessions_spawn` / `sessions_send` 用于多智能体编排
- 定时任务用于计划扫描（参见 `HEARTBEAT.md`）
- 文件系统访问用于读取看板/记忆
- Discord 或飞书用于通知

## 如何设置

### 1. 项目结构

```bash
mkdir -p ~/.openclaw/workspace/subagents/mission-control
cd ~/.openclaw/workspace/subagents/mission-control

# 核心文件
touch coordinator.py tracker.py mission_control_events.py orchestrator.py
mkdir events logs
```

### 2. 定义智能体能力

编辑 `coordinator.py` 配置智能体矩阵：

```python
AGENT_CAPABILITIES = {
    "@coder": ["code", "performance", "tool"],
    "@vision": ["analysis", "research", "creative"],
    "@fast": ["quick", "simple", "routine"],
    "@main": ["coordination", "decision", "reporting"]
}
```

### 3. 设置定时扫描

添加到 `HEARTBEAT.md`：

```markdown
## 任务控制中心扫描

每 15 分钟：
- 扫描 Mission-Control-Kanban.md
- 检查新任务
- 根据优先级分配给智能体
```

### 4. 启动协调器

```bash
python3 coordinator.py scan      # 手动扫描
python3 coordinator.py status  # 查看任务状态
python3 coordinator.py briefing # 生成每日报告
```

## 运营收益

- **更快的交接** — 智能体明确知道下一步该做什么
- **更好的可观测性** — 实时查看所有智能体的活跃工作
- **更少的遗漏任务** — 从创建到完成的自动跟踪
- **更清晰的事后复盘** — 完整生命周期历史用于调试

## 技术改进（最新）

近期对系统的优化：

- **原子化 JSON 持久化** — 防止写入中断导致的数据损坏
- **安全 JSON 加载** — 状态文件损坏时优雅降级
- **模板不可变性** — 工作流模板在重复使用后不会被污染
- **可移植路径** — 使用相对路径替代硬编码绝对路径
- **准确的状态语义** — 正确区分 `assigned` 与 `started`

## 相关链接

- [OpenClaw 子智能体文档](https://github.com/openclaw/openclaw)
- [多智能体内容工厂](usecases/content-factory.md)
- [多智能体专业团队](usecases/multi-agent-team.md)
- [自主项目管理](usecases/autonomous-project-management.md)

---

*适用于 OpenClaw v2026.02+*
