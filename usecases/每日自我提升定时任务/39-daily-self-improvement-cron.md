# 每日自我提升定时任务

## 简介

持续改进系统，智能体每天自动新增一项能力：安装技能、添加 MCP 服务器、修复 Bug 或集成新服务。

**为什么重要**：复合改进带来指数级能力增长。每天进步 1% = 一年提升 37 倍。

**实际案例**：智能体第 1 天安装新技能，第 2 天修复 Bug，第 3 天添加 MCP 服务器，每天记录改进日志。

## 所需技能

| 技能 | 来源 | 用途 |
|-------|--------|---------|
| `cron` | 内置 | 每日定时触发 |
| `filesystem` | 内置 | 追踪进度 |

## 配置方法

### 1. 改进队列

```javascript
const improvements = [
  { type: 'skill', name: 'web_search' },
  { type: 'mcp', name: 'github-server' },
  { type: 'bugfix', issue: '#123' },
  { type: 'integration', service: 'notion' }
];
```

### 2. 提示词模板

```markdown
## 每日自我提升定时任务

每天 06:00 执行：
1. 回顾改进待办列表
2. 选择今天的 1 项改进
3. 执行改进
4. 充分测试
5. 记录到 memory/improvements.md
6. 向主人汇报

改进类别：
- 安装新技能
- 添加 MCP 服务器
- 修复已知 Bug
- 集成新服务
- 优化现有工作流
```

## 成功指标

- [ ] 每天完成 1 项改进
- [ ] 待办列表持续维护
- [ ] 每周回顾进度

---

*示例来源：Salen (Moltbook) - "Daily Self-Improvement cron"*
