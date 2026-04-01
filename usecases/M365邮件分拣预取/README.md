# M365 邮件分拣预取架构

> 跨多个 Microsoft 365 租户的智能邮件监控，通过成本优化的预取机制将 token 用量降低 99%，并配合智能分拣——判断哪些邮件值得立即通知你，哪些可以稍后再说。

## 问题所在

如果你用 OpenClaw 监控邮件，很可能遇到过以下痛点：

- **成本爆炸**：每次 cron 任务都会触发系统提示词的完整缓存写入。如果每 15 分钟检查一次邮件，你每天要为 96 次冷启动买单——智能体还没读邮件，钱就花出去了。按 Claude Sonnet 每次冷启动约 $0.20 计算，光是查邮件一天就要 $20。
- **Token 膨胀**：如果你的智能体直接调用 M365 工具（通过 mcporter），它会拉取完整的 HTML 邮件正文——CSS、追踪像素、图片，应有尽有。一次收件箱检查就能消耗 145 万个 token。你的智能体简直是拿整张渲染好的网页当早餐吃。
- **警报疲劳**：没有智能分拣的话，每封邮件都会通知你——营销邮件、新闻通讯、自动回执、过时消息——久而久之你就不再信任这些警报了。

## 解决方案

一个两阶段架构，将**数据采集**（低成本、无需 LLM）与**智能分拣**（需要 LLM，但 token 输入极少）分离开来。

**阶段一——预取（系统 cron，零 AI 成本）：**
一个 Python 脚本在工作时间每 30 分钟运行一次。它调用 mcporter 从多个 M365 租户拉取邮件元数据，剥离回复链，按时间窗口过滤，然后写入一个小的 JSON 文件。成本：零 LLM token。

**阶段二——分拣（OpenClaw cron，极少量 token）：**
7 分钟后，你的 OpenClaw 智能体读取预先构建好的 JSON 文件，做出判断：哪些紧急、哪些日常、哪些可以等晨会简报再处理。它通过 Telegram 发送带有 emoji 分类和建议操作的警报。成本：约 1.4 万 token，而非 145 万。

## 设置

### 所需技能

- **mcporter**（内置）— Microsoft 365 集成
- **message** 或 Telegram 频道 — 用于发送警报

### 阶段一：预取脚本

创建一个 Python 脚本作为系统 cron 任务运行（不是 OpenClaw cron——无需 LLM 成本）：

```python
#!/usr/bin/env python3
"""Email prefetch — runs via system cron, writes JSON for OpenClaw to read."""
import subprocess, json, os, tempfile
from datetime import datetime, timedelta, timezone
from zoneinfo import ZoneInfo  # Python 3.9+; handles DST automatically

CST = ZoneInfo("America/Chicago")
LOOKBACK = timedelta(minutes=35)  # slightly wider than the 30-min interval
OUTPUT = "/tmp/openclaw/email-monitor-pending.json"

TENANTS = [
    {"name": "Primary", "account": "user@company.com"},
    {"name": "Secondary", "account": "user@otherdomain.com"},
]

def fetch_tenant(tenant):
    since = (datetime.now(CST) - LOOKBACK).astimezone(timezone.utc).strftime("%Y-%m-%dT%H:%M:%SZ")
    cmd = [
        "openclaw", "skills", "call", "mcporter",
        "--", "outlook", "mail", "list",
        "--account", tenant["account"],
        "--filter", f"receivedDateTime ge {since}",
        "--select", "subject,from,receivedDateTime,isRead,bodyPreview",
        "--top", "20",
        "--output", "text"
    ]
    try:
        result = subprocess.run(cmd, capture_output=True, text=True, timeout=30)
    except subprocess.TimeoutExpired:
        return []
    if result.returncode != 0:
        return []
    try:
        return json.loads(result.stdout)
    except json.JSONDecodeError:
        return []

def strip_reply_chains(emails):
    """Remove quoted reply content from bodyPreview to save tokens."""
    for email in emails:
        preview = email.get("bodyPreview", "")
        for marker in ["From:", "-----Original", "On ", "> "]:
            idx = preview.find(marker)
            if idx > 50:  # keep at least 50 chars
                preview = preview[:idx].rstrip()
                break
        email["bodyPreview"] = preview[:200]  # cap at 200 chars
    return emails

results = {}
for tenant in TENANTS:
    emails = fetch_tenant(tenant)
    results[tenant["name"]] = strip_reply_chains(emails)

os.makedirs(os.path.dirname(OUTPUT), exist_ok=True)
tmp_output = None
try:
    fd, tmp_output = tempfile.mkstemp(dir=os.path.dirname(OUTPUT), suffix=".json")
    with os.fdopen(fd, "w") as f:
        json.dump({"fetched_at": datetime.now(CST).isoformat(), "tenants": results}, f)
    os.replace(tmp_output, OUTPUT)
except (OSError, IOError) as e:
    print(f"ERROR: Failed to write {OUTPUT}: {e}")
    if tmp_output and os.path.exists(tmp_output):
        os.remove(tmp_output)
```

**系统 crontab**（每 30 分钟运行一次，上午 8 点至晚上 11 点）：
```bash
CRON_TZ=America/Chicago
*/30 8-23 * * * /usr/bin/python3 /path/to/email-prefetch.py >> /tmp/openclaw/email-monitor.log 2>&1
```

### 阶段二：OpenClaw Cron 任务

创建一个在预取后 7 分钟运行的 OpenClaw cron 任务：

```bash
openclaw cron add \
  --name "email-monitor" \
  --schedule "7,37 8-23 * * *" \
  --message "Read /tmp/openclaw/email-monitor-pending.json. Triage emails using EMAIL_MONITOR_PREFS.md rules. Alert me via Telegram only for items that need my attention. Use emoji categories and add → action lines for actionable items. Add a blank line between items. If nothing is actionable, skip the alert entirely."
```

### 阶段三：分拣规则

创建 `~/.openclaw/workspace/EMAIL_MONITOR_PREFS.md`：

```markdown
# 邮件监控偏好

## 始终警报（不受时间限制）
- 金融交易、支付失败、银行提醒
- 任何服务的安全警报
- VIP 联系人（参见 VIP_CONTACTS.md）
- 来自学校、营地、看护人的关于子女/受抚养人的消息

## 工作时间警报
- 需要回复的客户邮件
- 日历邀请
- 服务中断通知

## 静默 / 仅晨会简报
- 营销邮件和新闻通讯
- 自动回执和确认邮件
- 社交媒体通知
- 超过 6 小时的旧消息（已过时——不值得深夜打扰）

## 格式
- 🔴 紧急：需在 1 小时内回复
- 🟡 可操作：需在今日回复
- 🔵 信息性：仅供参考，无需操作
- → 每个可操作项附带建议操作行
```

创建 `~/.openclaw/workspace/VIP_CONTACTS.md`：
```markdown
# VIP 联系人 — 始终置顶
- boss@company.com (Manager)
- spouse@email.com (Family)
- school@district.edu (Kids' school)
```

## mcporter 关键注意事项

这些坑让我们花了几天时间调试。帮你省点痛苦：

1. **始终使用 `--select` 搭配 `bodyPreview`**，而不是拉取完整邮件正文。否则 mcporter 会返回渲染后的 HTML——CSS、图片、追踪像素——这会间歇性导致 JSON 解析失败，并多消耗 100 倍的 token。

2. **始终使用 `--output text`** 来获取干净的 JSON。默认输出会将响应包装在 MCP 信封中，需要额外的解析步骤。

3. **日历日期过滤是静默失效的。** mcporter 用于日历查询的 `startdatetime` / `enddatetime` 参数实际上不起过滤作用。需要拉取全部事件，然后在 Python 中进行后处理过滤。

## 效果对比

| 指标 | 优化前（直接 API） | 优化后（预取架构） |
|--------|-------------------|-------------------|
| 每次检查 token 消耗 | ~1,450,000 | ~14,000 |
| JSON 解析失败 | 间歇性 | 零 |
| 每日成本（仅邮件） | ~$20+ | ~$1-2 |
| 误报率 | 高 | 低（VIP + 时间感知） |

## 使用建议

- **旧消息静默**是最大的体验提升。如果一封邮件 6 小时前到达而现在已是晚上 10 点，你的智能体应该跳过它，而不是震动你的手机。它会在晨会简报中出现。
- **回复链剥离**比你想象的更重要。没有它的话，一个 10 封邮件的线程每次检查都会发送完整的历史记录。将 `bodyPreview` 限制在 200 个字符以内。
- **7 分钟的时间偏移**确保智能体读取时 JSON 文件始终是最新的。没有这个偏移，竞态条件会导致智能体读取到过期或不完整的数据。
- **多租户零成本。** 预取脚本按顺序循环遍历各租户。添加另一个 M365 账户只需在配置中加一行。

## 为什么用预取而不是直接工具调用？

每次 OpenClaw cron 任务都会触发一次完整的系统提示词缓存写入（在典型工作区下 Claude Sonnet 约 $0.20）。这是唤醒智能体的固定成本。如果智能体随后发起 3-4 次 mcporter 工具调用来检查多个收件箱，每次调用都会增加往返延迟和 token 消耗。

预取模式将这一流程反转：数据采集零成本（Python + 系统 cron），然后给智能体一个单一的、已预处理的 JSON 文件进行推理。一次缓存写入，一次文件读取，一次分拣决策。智能体的工作是判断，不是数据采集。

## 项目来源

作为 Triss Manifold 项目的一部分开发——一个在生产环境中运行的 OpenClaw 部署，运行在 Beelink SER5 迷你 PC 上，为一家托管服务提供商管理跨多个 M365 租户的邮件分拣。自 2026 年 2 月起每日稳定运行。
