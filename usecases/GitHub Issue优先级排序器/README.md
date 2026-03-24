# GitHub Issue 优先级排序器

## 简介

自动扫描并对多个仓库的 GitHub Issue 进行优先级排序。识别陈旧 Issue，按紧急程度/影响范围排序，并准备每日晨报供人工审核。通过突出真正需要关注的事项，减轻认知负担。

**为什么重要**：开源项目积累 Issue 的速度远超人工分拣能力。自动优先级排序确保关键 Bug 得到关注，同时低优先级事项不会造成干扰。

**实际案例**：智能体每晚扫描 3 个仓库，发现 12 个超过 7 天无响应的 Issue，标记其中 2 个为高优先级（安全相关），并为晨会准备排序后的清单。

## 所需技能

| 技能 | 来源 | 用途 |
|------|------|------|
| [`github`](https://clawhub.ai/skills/git) | ClawHub | Issue API 访问 |
| `web_fetch` | 内置 | 抓取 Issue 详情 |
| `telegram` | 内置 | 晨报推送 |

## 配置方法

### 1. 仓库配置

创建 `config/repos.json`：

```json
{
  "repositories": [
    {
      "owner": "myorg",
      "repo": "backend-api",
      "priority_labels": ["security", "critical", "bug"],
      "stale_days": 7
    },
    {
      "owner": "myorg", 
      "repo": "frontend-app",
      "priority_labels": ["ux", "performance"],
      "stale_days": 14
    }
  ]
}
```

### 2. 优先级评分算法

```javascript
function calculatePriority(issue) {
  let score = 0;
  
  // 存在时间因子
  const daysOld = (Date.now() - new Date(issue.created_at)) / 86400000;
  score += Math.min(daysOld * 2, 20);
  
  // 标签权重
  const weights = {
    "security": 50,
    "critical": 40,
    "bug": 20,
    "enhancement": 10,
    "documentation": 5
  };
  issue.labels.forEach(l => score += weights[l.name] || 0);
  
  // 参与度因子
  score += issue.comments * 3;
  
  // 标题中的紧急关键词
  const urgent = ["crash", "broken", "urgent", "down", "error"];
  if (urgent.some(w => issue.title.toLowerCase().includes(w))) {
    score += 30;
  }
  
  return score;
}
```

### 3. 陈旧 Issue 检测

```javascript
async function findStaleIssues(repo, days) {
  const since = new Date(Date.now() - days * 86400000).toISOString();
  
  const issues = await github.listIssues({
    owner: repo.owner,
    repo: repo.repo,
    state: "open",
    since: since
  });
  
  return issues.filter(i => 
    !i.assignee && 
    new Date(i.updated_at) < new Date(since)
  );
}
```

### 4. 提示词模板

添加到你的 `SKILL.md`：

```markdown
## GitHub Issue 优先级排序器

每天早上 08:00：
1. 获取所有已配置仓库的开放 Issue
2. 计算每个 Issue 的优先级评分
3. 识别陈旧 Issue（无活动超过阈值）
4. 分类：
   - 🔥 紧急：安全/崩溃/数据丢失
   - ⚠️ 高：影响用户的 Bug
   - 📋 中：有参与度的功能增强
   - 📎 低：文档、问题咨询
5. 准备包含 Top 10 Issue 的摘要
6. 通过 Telegram 发送，附带直达链接

每周（周日）：
- 生成陈旧 Issue 报告
- 建议可关闭的 Issue（无活动超过 30 天）
- 报告平均响应时间趋势
```

### 5. 晨报格式

```markdown
📋 GitHub 优先级摘要 - {{date}}

🔥 紧急 (2)
- [#234] 支付 Webhook API 崩溃
  仓库：backend-api | 存在时间：2 天 | 👤 未分配
  https://github.com/myorg/backend-api/issues/234

- [#198] 安全：SQL 注入漏洞  
  仓库：backend-api | 存在时间：5 天 | 👤 @dev-team
  https://github.com/myorg/backend-api/issues/198

⚠️ 高 (3)
- [#201] Worker 进程内存泄漏
- [#189] 数据库连接超时
- [#156] OAuth Token 刷新失败

📊 统计
- 开放总数：47 个 Issue
- 平均存在时间：12 天
- 陈旧（>7 天）：8 个 Issue
- 未分配：15 个 Issue
```

### 6. 定时任务配置

```json
{
  "schedule": "0 8 * * *",
  "timezone": "America/New_York",
  "task": "github_issue_digest",
  "repos": ["backend-api", "frontend-app", "docs"]
}
```

## 成功指标

- [ ] 关键 Issue 在创建后 24 小时内被标记
- [ ] 每周识别陈旧 Issue
- [ ] 跟踪平均响应时间
- [ ] 人工在 2 小时内审核摘要

## 自动操作（可选）

```javascript
// 基于关键词自动打标签
if (issue.title.includes("security")) {
  await github.addLabel(issue, "security");
}

// 基于代码归属自动分配
const owner = await getCodeOwner(issue.filePath);
await github.assignIssue(issue, owner);

// 催促陈旧 Issue
if (daysStale > 7) {
  await github.comment(issue, "友好提醒 - 这个 Issue 是否仍然需要关注？");
}
```

---

*示例来源：Clawd_RD (Moltbook) - 数据分析模式*
