<p align="center">
  <h1 align="center">🖥️ OpenClaw Usecases 中文翻译</h1>
  <p align="center">
    <strong>awesome-openclaw-usecases 的中文翻译项目，让 OpenClaw 用例触手可及</strong>
  </p>
  <p align="center">
    <a href="https://github.com/L-LesterYu/OpenClaw-Usecases-zh/stargazers"><img src="https://img.shields.io/github/stars/L-LesterYu/OpenClaw-Usecases-zh?style=social" alt="Stars"></a>
    <a href="https://github.com/L-LesterYu/OpenClaw-Usecases-zh/blob/main/LICENSE"><img src="https://img.shields.io/github/license/L-LesterYu/OpenClaw-Usecases-zh" alt="License"></a>
    <a href="https://github.com/hesamsheikh/awesome-openclaw-usecases"><img src="https://img.shields.io/badge/上游仓库-awesome--openclaw--usecases-blue" alt="Upstream"></a>
  </p>
</p>

> ⚠️ **安全警告：** 此处引用的 OpenClaw 技能和第三方依赖可能存在严重的安全漏洞。许多用例链接到社区构建的技能、插件和外部仓库，这些未经本列表维护者审核。请始终审查技能源代码，检查请求的权限，并避免硬编码 API 密钥或凭证。您对自己的安全负全部责任。

---

## 📖 项目简介

本项目是对 github上的OpenClaw的usecases（比如[awesome-openclaw-usecases](https://github.com/hesamsheikh/awesome-openclaw-usecases)） 仓库的**中文翻译**，旨在帮助中文用户快速理解和使用各种 OpenClaw 实用用例。

> 🌟 **一句话定位：** 将全球最棒的 OpenClaw 用例翻译成中文，降低使用门槛。

## 📋 图例说明

| 标记 | 含义 |
|------|------|
| 🔔 | 需要配置定时任务（Cron / Heartbeat） |
| 💰 | 依赖付费 API 或订阅服务 |
| 📦 | 需要额外安装依赖或配置服务 |
| ✅ | 零配置即可使用 |

## 🗂️ 用例分类

### 📰 信息聚合

| 用例 | 说明 | 标记 |
|------|------|------|
| [每日Reddit摘要](usecases/每日Reddit摘要/daily-reddit-digest.md) | 每天运行一次摘要推送，为你精选最喜欢的子版块中表现最热门的帖子 | 🔔 📦 |
| [每日YouTube摘要](usecases/每日YouTube摘要/daily-youtube-digest.md) | 每天获取你关注的YouTube频道的个性化新视频摘要，再也不错过真正想看的创作者内容 | 🔔 📦 |
| [X账号分析](usecases/X账号分析/x-account-analysis.md) | AI 驱动的 X 账号定性分析，发现发帖模式、热门话题和互动差异，无需付费订阅 | 📦 |
| [多源科技新闻摘要](usecases/多源科技新闻摘要/multi-source-tech-news-digest.md) | 自动聚合 109+ 信源的科技新闻，涵盖 RSS、Twitter/X、GitHub 发布和网页搜索，智能评分去重后推送 | 🔔 📦 |

### ⚡ 个人效率

| 用例 | 说明 | 标记 |
|------|------|------|
| [会议纪要与行动项](usecases/会议纪要与行动项/meeting-notes-action-items.md) | 将任意会议纪要自动转化为结构化笔记，提取行动项并创建到 Jira/Linear/Todoist，支持 Slack 摘要推送 | 📦 |
| [每日晨间简报](usecases/每日晨间简报/custom-morning-brief.md) | 每天定时发送个性化晨间简报，涵盖新闻、任务、创意和 AI 主动建议，醒来时工作已完成 | 🔔 |
| [习惯追踪与问责教练](usecases/习惯追踪与问责教练/habit-tracker-accountability-coach.md) | 通过 Telegram 或短信进行每日习惯签到追踪，自适应提醒语气，周报分析模式 | 🔔 ✅ |
| [收件箱清理](usecases/收件箱清理/inbox-declutter.md) | 自动清理订阅邮件堆积，每天生成精选摘要并学习用户偏好持续优化 | 🔔 📦 |
| [健康与症状追踪](usecases/健康与症状追踪/health-symptom-tracker.md) | 通过 Telegram 自动追踪饮食和症状，每日提醒记录餐食，每周分析规律识别潜在食物过敏源 | 🔔 ✅ |
| [电话来电通知](usecases/电话来电通知/phone-call-notifications.md) | 将智能体电话通知作为紧急通知通道，通过 clawr.ing 直接拨打真实电话，支持双向实时对话 | 📦 |
| [活动嘉宾确认](usecases/活动嘉宾确认/event-guest-confirmation.md) | 通过 SuperCall 插件自动拨打嘉宾电话逐一确认活动出席情况，收集饮食禁忌等备注并生成汇总报告 | 📦 |
| [家庭日历聚合与家务助手](usecases/家庭日历聚合与家务助手/family-calendar-household-assistant.md) | 聚合多日历生成晨间简报，被动监控短信自动创建预约事件，管理家庭库存和购物协调 | 🔔 📦 |
| [Todoist任务管理器](usecases/todoist任务管理器/todoist-task-manager.md) | 将智能体内部推理和进度日志同步到 Todoist，实现长时间运行任务的可视化透明度 | 📦 |

### 🔧 基础设施运维

| 用例 | 说明 | 标记 |
|------|------|------|
| [自愈式家庭服务器](usecases/自愈式家庭服务器/self-healing-home-server.md) | 将 OpenClaw 变成自愈式基础设施运维智能体，通过 SSH 和定时任务自动检测、诊断并修复服务器故障，支持晨间简报、邮件分类和知识库管理 | 🔔 📦 |
| [动态数据仪表盘](usecases/动态数据仪表盘/dynamic-dashboard.md) | 通过子智能体并行获取多数据源信息，生成实时仪表盘，支持 GitHub、社交媒体、市场数据和系统健康监控，自动刷新与阈值告警 | 🔔 📦 |

### 💰 财经追踪

| 用例 | 说明 | 标记 |
|------|------|------|
| [财报追踪器](usecases/财报追踪器/earnings-tracker.md) | AI驱动的自动化财报追踪与摘要推送工具，帮助用户实时掌握科技和AI公司的财报动态 | 🔔 📦 |

### 🎮 游戏开发

| 用例 | 说明 | 标记 |
|------|------|------|
| [自主教育游戏开发流水线](usecases/自主教育游戏开发流水线/autonomous-game-dev-pipeline.md) | 自主管理游戏从创建到维护的完整生命周期，每 7 分钟产出一款新游戏或修复一个 Bug，严格执行 Bug 优先策略 | 📦 |

### 📱 社交媒体

| 用例 | 说明 | 标记 |
|------|------|------|
| [X/Twitter自动化](usecases/X/Twitter自动化/x-twitter-automation.md) | 通过自然语言全面操控 X/Twitter，发推、回复、点赞、转推、关注、私信、搜索、数据提取、抽奖和账号监控，全部在 OpenClaw 聊天中完成 | 📦 |

### 🏭 内容创作

| 用例 | 说明 | 标记 |
|------|------|------|
| [多智能体内容工厂](usecases/多智能体内容工厂/content-factory.md) | 在 Discord 内搭建多智能体内容工厂，链式流水线自动完成调研、写作和缩略图生成，全程无需人工干预 | 📦 |

### 🛠️ 项目管理

| 用例 | 说明 | 标记 |
|------|------|------|
| [自主项目管理](usecases/自主项目管理/autonomous-project-management.md) | 通过共享状态文件实现去中心化并行项目管理，子智能体自主协调无需中央调度 | 📦 |

### 🧠 知识管理

| 用例 | 说明 | 标记 |
|------|------|------|
| [个人知识库RAG](usecases/个人知识库RAG/knowledge-base-rag.md) | 将所有保存的内容构建为可搜索的语义知识库，支持 URL 自动抓取收录和智能检索 | ✅ 📦 |
| [第二大脑](usecases/第二大脑/second-brain.md) | 将 OpenClaw 变成零阻力的记忆采集系统，通过短信记录灵感、链接和想法，配合 Next.js 可搜索仪表板随时检索 | ✅ 📦 |
| [arXiv论文阅读器](usecases/arXiv论文阅读器/arxiv-paper-reader.md) | 通过 ID 获取任意 arXiv 论文并以对话方式阅读分析，自动展平 LaTeX 符号，支持多论文摘要对比和章节级别深度解读 | ✅ 📦 |
| [语义记忆搜索](usecases/语义记忆搜索/semantic-memory-search.md) | 基于向量引擎的语义搜索，为 OpenClaw 记忆文件提供按含义检索能力，混合搜索与自动索引确保记忆始终可查 | ✅ 📦 |

---

## 🚀 快速开始

### 1. 克隆仓库

```bash
git clone https://github.com/L-LesterYu/OpenClaw-Usecases-zh.git
cd OpenClaw-Usecases-zh
```

### 2. 浏览用例

进入 `usecases/` 目录，选择感兴趣的用例查看详细文档。

### 3. 使用用例

将对应用例的 Markdown 文件内容导入 OpenClaw 即可使用。具体导入方式请参考各用例文档中的说明。

> 💡 **提示：** 带有 🔔 标记的用例需要配合 OpenClaw 的 Cron 或 Heartbeat 功能使用，建议先阅读 [OpenClaw 官方文档](https://docs.openclaw.ai) 了解相关配置。

## 🤝 贡献指南

欢迎参与翻译和改进！以下是贡献流程：

1. **Fork** 本仓库
2. 创建特性分支：`git checkout -b translate/new-usecase`
3. 在 `usecases/` 目录下创建对应的中文翻译文件夹
4. 提交更改：`git commit -m "feat: 添加 XXX 用例中文翻译"`
5. 推送分支：`git push origin translate/new-usecase`
6. 提交 **Pull Request**

### 翻译规范

- 文件夹使用**中文名称**，内部保留英文原文件名
- 翻译要求准确流畅，技术术语保留英文并在首次出现时附注中文
- 更新本 README 的分类表格

## 🔗 相关链接

- [上游仓库 - awesome-openclaw-usecases](https://github.com/hesamsheikh/awesome-openclaw-usecases) — 原始英文用例合集
- [OpenClaw 官网](https://openclaw.ai) — OpenClaw 产品主页
- [OpenClaw 文档](https://docs.openclaw.ai) — 官方使用文档

## 📄 许可证

本项目基于 [MIT License](LICENSE) 开源。

## 🙏 致谢

- [hesamsheikh/awesome-openclaw-usecases](https://github.com/hesamsheikh/awesome-openclaw-usecases) — 原始英文用例合集
- 所有参与翻译和贡献的贡献者

---

<p align="center">
  如果觉得这个项目对你有帮助，欢迎点个 ⭐ Star 支持一下！
</p>

<p align="center">
  <sub>Built with ❤️ by Lester</sub>
</p>
