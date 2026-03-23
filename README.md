<p align="center">
  <h1 align="center">🖥️ OpenClaw Usecases 中文翻译</h1>
  <p align="center">
    <strong>精准翻译 + 国内替代方案，让 OpenClaw 用例触手可及</strong>
  </p>
  <p align="center">
    <a href="https://github.com/L-LesterYu/OpenClaw-Usecases-zh/stargazers"><img src="https://img.shields.io/github/stars/L-LesterYu/OpenClaw-Usecases-zh?style=social" alt="Stars"></a>
    <a href="https://github.com/L-LesterYu/OpenClaw-Usecases-zh/blob/main/LICENSE"><img src="https://img.shields.io/github/license/L-LesterYu/OpenClaw-Usecases-zh" alt="License"></a>
    <a href="https://github.com/hesamsheikh/awesome-openclaw-usecases"><img src="https://img.shields.io/badge/上游仓库-awesome--openclaw--usecases-blue" alt="Upstream"></a>
    <a href="https://img.shields.io/badge/用例数量-50-9cf"><img src="https://img.shields.io/badge/用例数量-50-9cf" alt="Usecases"></a>
  </p>
</p>

> ⚠️ **安全警告：** 此处引用的 OpenClaw 技能和第三方依赖可能存在严重的安全漏洞。许多用例链接到社区构建的技能、插件和外部仓库，这些未经本列表维护者审核。请始终审查技能源代码，检查请求的权限，并避免硬编码 API 密钥或凭证。您对自己的安全负全部责任。

---

## 📖 项目简介

本项目是对 各类OpenClaw的usecases 的**中文翻译 + 国内替代方案**项目以及更精细化的整理，帮助中文用户快速理解和使用各种 OpenClaw 实用用例。

### 🎯 我们的差异化

| 项目 | 定位 |
|------|------|
| **本项目** | 精准翻译 + 每个用例附带国内替代方案说明，不仅是翻译，更是本地化指南 |
| [awesome-openclaw-usecases-zh](https://github.com/AlexAnys/awesome-openclaw-usecases-zh) | 优秀的中文项目，侧重于用例的整理 |

** 每个用例都标注了 `🇨🇳 可替代为：xxx`，告诉你 Reddit → 知乎、YouTube → B站、Gmail → QQ邮箱……不用翻墙也能用起来。

---

## 📖 核心概念快速入门

刚接触 OpenClaw？以下 10 个核心概念帮你快速上手：

| 概念 | 一句话解释 | 生活类比 |
|------|-----------|---------|
| **Workspace（工作区）** | 你的私人数字空间，存放配置、记忆和文件 | 就像你的书桌，所有东西都在手边 |
| **SOUL.md（灵魂）** | 定义智能体的性格、语气和行为准则 | 就像给 AI 写了一份"人设说明书" |
| **AGENTS.md（操作手册）** | 智能体的行为规范和日常工作流程 | 就像员工的岗位职责说明书 |
| **Memory（记忆）** | 智能体的长期记忆系统，跨会话保持上下文 | 就像 AI 的笔记本，每次上班都会翻开 |
| **Skill（技能）** | 预封装的能力模块，即装即用 | 就像手机 App，装上就有了新功能 |
| **Tool（工具）** | 底层能力接口，如文件读写、浏览器控制 | 就像手机的摄像头和麦克风 |
| **Channel（频道）** | 连接外部平台的桥梁，如 Discord、Telegram | 就像你的社交账号，AI 通过它和你聊天 |
| **Cron（定时任务）** | 定时触发的自动化任务，精确到分 | 就像闹钟，到点自动响 |
| **Heartbeat（心跳）** | 周期性巡检机制，让智能体主动做事 | 就像值班巡逻，定时检查有没有活要干 |
| **Sub-agent（子智能体）** | 可独立运行的辅助智能体，擅长并行处理 | 就像你雇了个助手，帮他分担工作 |

> 💡 想深入了解？请阅读 [OpenClaw 官方文档](https://docs.openclaw.ai)。

---

## 📋 图例说明

### 状态标记

| 标记 | 含义 |
|------|------|
| 🔔 | 需要配置定时任务（Cron / Heartbeat） |
| 💰 | 依赖付费 API 或订阅服务 |
| 📦 | 需要额外安装依赖或配置服务 |
| ✅ | 零配置即可使用 |

### 难度分级

| 标记 | 含义 |
|------|------|
| ⭐ | 零配置可用，开箱即用 |
| ⭐⭐ | 需要简单配置，如 API Key 或环境变量 |
| ⭐⭐⭐ | 需要一定技术基础，涉及服务器部署或复杂配置 |

### 🇨🇳 国内替代方案速查表

| 原始服务 | 国内替代 | 适用用例 |
|---------|---------|---------|
| Reddit | 知乎、即刻 | 每日摘要类 |
| X/Twitter | 微博、即刻 | X自动化、X分析 |
| YouTube | B站 | YouTube摘要 |
| Jira/Linear | 飞书项目、钉钉Teambition | 会议纪要 |
| Todoist | 滴答清单、飞书待办 | Todoist管理器 |
| Gmail/Outlook | QQ邮箱、163邮箱 | 收件箱清理 |
| Slack/Discord | 飞书群、钉钉群 | 内容工厂 |
| SuperCall | 阿里云语音、腾讯云语音 | 活动嘉宾确认、电话通知 |
| Next.js | 任何前端框架 | 第二大脑 |

---

## 🌟 推荐入门

新手不知道从哪个开始？以下用例零配置即用，选一个试试吧！

| 用例 | 说明 | 标记 |
|------|------|------|
| [arXiv论文阅读器](usecases/arXiv论文阅读器/arxiv-paper-reader.md) | 通过论文 ID 直接获取并对话式阅读分析 arXiv 论文 | ✅ ⭐ |
| [语义记忆搜索](usecases/语义记忆搜索/semantic-memory-search.md) | 为 OpenClaw 记忆文件加上按含义检索的能力 | ✅ ⭐ |
| [个人知识库RAG](usecases/个人知识库RAG/knowledge-base-rag.md) | 把保存的内容变成可搜索的语义知识库 | ✅ ⭐ |
| [第二大脑](usecases/第二大脑/second-brain.md) | 零阻力记忆采集系统，随时记录灵感和想法 | ✅ ⭐ |
| [习惯追踪与问责教练](usecases/习惯追踪与问责教练/habit-tracker-accountability-coach.md) | 每日习惯签到 + 自适应提醒 + 周报分析 | ✅ ⭐ |

---

## 📑 目录

- [📱 社交媒体与内容](#-社交媒体与内容)
- [💼 效率工具](#-效率工具)
- [🔧 基础设施与运维](#-基础设施与运维)
- [🧠 知识管理与学习](#-知识管理与学习)
- [💰 财经追踪](#-财经追踪)
- [🎧 客户服务与销售](#-客户服务与销售)
- [🎮 创意与开发](#-创意与开发)
- [🚀 快速开始](#-快速开始)
- [🤝 贡献指南](#-贡献指南)
- [🔗 相关链接](#-相关链接)

---

## 🗂️ 用例分类

### 📱 社交媒体与内容

| 用例 | 说明 | 标记 | 难度 |
|------|------|------|------|
| [每日Reddit摘要](usecases/每日Reddit摘要/daily-reddit-digest.md) | 每天运行一次摘要推送，精选最热门帖子 | 🔔 📦 | ⭐⭐ |
| [每日YouTube摘要](usecases/每日YouTube摘要/daily-youtube-digest.md) | 获取关注频道的个性化新视频摘要 | 🔔 📦 | ⭐⭐ |
| [X账号分析](usecases/X账号分析/x-account-analysis.md) | AI 驱动的 X 账号定性分析，发现发帖模式和互动差异 | 📦 | ⭐⭐ |
| [XTwitter自动化](usecases/XTwitter自动化/x-twitter-automation.md) | 通过自然语言全面操控 X/Twitter，发推、回复、搜索、抽奖等 | 📦 | ⭐⭐⭐ |
| [多源科技新闻摘要](usecases/多源科技新闻摘要/multi-source-tech-news-digest.md) | 聚合 109+ 信源的科技新闻，智能评分去重后推送 | 🔔 📦 | ⭐⭐ |
| [YouTube内容流水线](usecases/YouTube内容流水线/youtube-content-pipeline.md) | 自动化视频创意侦察和研究流水线，语义去重避免重复选题，Slack 链接触发自动研究 | 🔔 📦 | ⭐⭐ |
| [播客制作流水线](usecases/播客制作流水线/podcast-production-pipeline.md) | 自动化播客制作全流程：嘉宾研究、大纲脚本、节目笔记、社交媒体推广素材 | 📦 | ⭐⭐ |
| [小红书营销全自动工作流](usecases/小红书营销全自动工作流/tensorslab-xiaohongshu-marketing.md) | TensorsLab + 小红书营销全自动工作流，热点抓取 → 文案生成 → 配图生成 → 飞书归档，支持每日定时执行 | 🔔 📦 | ⭐⭐⭐ |
| [多智能体内容工厂](usecases/多智能体内容工厂/content-factory.md) | Discord 内搭建多智能体内容工厂，链式流水线自动产出内容 | 📦 | ⭐⭐⭐ |

<details>
<summary>🇨🇳 社交媒体与内容 — 国内替代方案</summary>

- 每日Reddit摘要 → 🇨🇳 可替代为：**知乎热榜监控、即刻热门话题**
- 每日YouTube摘要 → 🇨🇳 可替代为：**B站动态订阅摘要**
- X账号分析 → 🇨🇳 可替代为：**微博账号分析、小红书账号分析**
- XTwitter自动化 → 🇨🇳 可替代为：**微博自动化、即刻自动化**
- 多源科技新闻摘要 → 🇨🇳 通用性强，可直接使用
- YouTube内容流水线 → 🇨🇳 可替代为：**B站动态订阅摘要**，用飞书/钉钉群替代 Slack
- 播客制作流水线 → 🇨🇳 通用性强，可直接使用
- 小红书营销全自动工作流 → 🇨🇳 原生中文场景，直接使用（飞书多维表格、小红书、TensorsLab）
- 多智能体内容工厂 → 🇨🇳 可替代为：**飞书群、钉钉群**作为协作平台

</details>

### 💼 效率工具

| 用例 | 说明 | 标记 | 难度 |
|------|------|------|------|
| [每日晨间简报](usecases/每日晨间简报/custom-morning-brief.md) | 定时发送个性化晨间简报，涵盖新闻、任务、创意和 AI 建议 | 🔔 | ⭐ |
| [收件箱清理](usecases/收件箱清理/inbox-declutter.md) | 自动清理订阅邮件，生成精选摘要并学习用户偏好 | 🔔 📦 | ⭐⭐ |
| [会议纪要与行动项](usecases/会议纪要与行动项/meeting-notes-action-items.md) | 将会议纪要自动转化为结构化笔记，提取行动项并创建到 Jira/Todoist | 📦 | ⭐⭐ |
| [习惯追踪与问责教练](usecases/习惯追踪与问责教练/habit-tracker-accountability-coach.md) | 每日习惯签到追踪，自适应提醒语气，周报分析模式 | 🔔 ✅ | ⭐ |
| [健康与症状追踪](usecases/健康与症状追踪/health-symptom-tracker.md) | 自动追踪饮食和症状，每周分析规律识别潜在食物过敏源 | 🔔 ✅ | ⭐ |
| [家庭日历聚合与家务助手](usecases/家庭日历聚合与家务助手/family-calendar-household-assistant.md) | 聚合多日历生成简报，自动创建预约事件，管理家庭库存 | 🔔 📦 | ⭐⭐ |
| [Todoist任务管理器](usecases/Todoist任务管理器/todoist-task-manager.md) | 将智能体推理和进度日志同步到 Todoist，实现任务可视化 | 📦 | ⭐⭐ |
| [活动嘉宾确认](usecases/活动嘉宾确认/event-guest-confirmation.md) | 通过 SuperCall 自动拨打嘉宾电话确认出席，收集备注并汇总 | 📦 | ⭐⭐⭐ |
| [电话来电通知](usecases/电话来电通知/phone-call-notifications.md) | 通过 clawr.ing 拨打真实电话作为紧急通知通道，支持双向对话 | 📦 | ⭐⭐⭐ |
| [电话语音助手](usecases/电话语音助手/phone-based-personal-assistant.md) | 通过 ClawdTalk 让 OpenClaw 接听和拨打电话，任何电话都能变成 AI 语音助手入口 | 📦 | ⭐⭐⭐ |
| [多渠道个人助手](usecases/多渠道个人助手/multi-channel-assistant.md) | 将 Telegram、Slack、Google Workspace、Todoist、Asana 整合到一个 AI 助手中，基于话题路由请求 | 📦 | ⭐⭐⭐ |
| [多智能体专业团队](usecases/多智能体专业团队/multi-agent-team.md) | 为独立创始人配置多个专业化 AI 智能体，通过单个 Telegram 群聊控制，共享记忆协作 | 📦 | ⭐⭐⭐ |
| [项目状态管理](usecases/项目状态管理/project-state-management.md) | 用事件驱动系统替代看板，通过自然语言对话自动追踪项目进度、决策和阻塞 | 📦 | ⭐⭐⭐ |
| [比价购物助手](usecases/比价购物助手/price-comparison-shopper.md) | 在线购物时自动跨平台搜索比价、查找优惠券并推荐最优方案，一条消息找到最低价 | ✅ | ⭐ |
| [天气预报晨报](usecases/天气预报晨报/weather-morning-report.md) | 每天早上通过 Telegram 自动推送天气预报，包含 4 个时段的温度、体感、湿度和风速，极端天气自动告警 | 🔔 💰 📦 | ⭐⭐ |
| [目标驱动自主任务](usecases/目标驱动自主任务/overnight-mini-app-builder.md) | 将目标倾诉给智能体，它每天自主生成和执行任务推进目标，还能夜间构建惊喜 MVP | 🔔 📦 | ⭐⭐⭐ |
| [医学邮件转播客](usecases/医学邮件转播客/01-medical-email-to-podcast.md) | 将医学简报邮件自动转化为音频播客，解析链接深入研究，撰写专业播客脚本，TTS 语音生成后通过 Signal 投递 | 🔔 💰 📦 | ⭐⭐⭐ |
| [创始人每日控制室](usecases/创始人每日控制室/README.md) | 每日跨产品、运营和日程的高管运营简报，聚合优先事项、风险和截止日期，生成精简控制室简报 | 🔔 📦 | ⭐⭐ |
| [产品经理AI副驾驶](usecases/产品经理AI副驾驶/openclaw-product-manager-copilot.md) | 将 OpenClaw 部署为自托管的产品经理副驾驶，自动完成迭代评审、用户反馈处理和竞品情报生成 | 🔔 📦 | ⭐⭐⭐ |

<details>
<summary>🇨🇳 效率工具 — 国内替代方案</summary>

- 每日晨间简报 → 🇨🇳 通用性强，可直接使用
- 收件箱清理 → 🇨🇳 可替代为：**QQ邮箱、163邮箱**清理
- 会议纪要与行动项 → 🇨🇳 可替代为：**飞书项目、钉钉Teambition** 创建任务
- 习惯追踪与问责教练 → 🇨🇳 通用性强，可通过微信/飞书消息使用
- 健康与症状追踪 → 🇨🇳 通用性强，可通过微信/飞书消息使用
- 家庭日历聚合与家务助手 → 🇨🇳 可替代为：**钉钉日历、飞书日历**聚合
- Todoist任务管理器 → 🇨🇳 可替代为：**滴答清单、飞书待办**
- 活动嘉宾确认 → 🇨🇳 可替代为：**阿里云语音、腾讯云语音**
- 电话来电通知 → 🇨🇳 可替代为：**阿里云语音、腾讯云语音**
- 电话语音助手 → 🇨🇳 可替代为：**阿里云语音、腾讯云语音**
- 多渠道个人助手 → 🇨🇳 可替代为：**飞书群、钉钉群、微信**替代 Telegram/Slack
- 多智能体专业团队 → 🇨🇳 可替代为：**飞书群、钉钉群**作为控制面板
- 项目状态管理 → 🇨🇳 通用性强，可直接使用
- 比价购物助手 → 🇨🇳 可替代为：**淘宝、京东、拼多多**作为比价平台
- 天气预报晨报 → 🇨🇳 可替代为：**和风天气 API、心知天气**替代 Yandex 天气，**微信/飞书/钉钉**替代 Telegram 推送
- 目标驱动自主任务 → 🇨🇳 通用性强，可直接使用
- 医学邮件转播客 → 🇨🇳 可替代为：**微信/飞书**替代 Signal 投递音频，**讯飞语音/阿里云TTS**替代 ElevenLabs，**QQ邮箱/163邮箱**替代 Gmail
- 创始人每日控制室 → 🇨🇳 通用性强，可直接使用，可通过**飞书/钉钉群**替代 Slack 投递简报
- 产品经理AI副驾驶 → 🇨🇳 可替代为：**飞书项目/钉钉Teambition**替代 Jira，**飞书文档**替代 Notion，**飞书群/钉钉群**替代 Slack

</details>

### 🔧 基础设施与运维

| 用例 | 说明 | 标记 | 难度 |
|------|------|------|------|
| [自愈式家庭服务器](usecases/自愈式家庭服务器/self-healing-home-server.md) | 将 OpenClaw 变成自愈式运维智能体，自动检测、诊断并修复服务器故障 | 🔔 📦 | ⭐⭐⭐ |
| [动态数据仪表盘](usecases/动态数据仪表盘/dynamic-dashboard.md) | 子智能体并行获取多数据源，生成实时仪表盘，支持阈值告警 | 🔔 📦 | ⭐⭐⭐ |
| [自主项目管理](usecases/自主项目管理/autonomous-project-management.md) | 共享状态文件实现去中心化并行项目管理，子智能体自主协调 | 📦 | ⭐⭐⭐ |
| [n8n工作流编排](usecases/n8n工作流编排/n8n-workflow-orchestration.md) | 通过 Webhook 将外部 API 交互委托给 n8n 工作流，智能体不接触凭证，可视化可锁定 | 📦 | ⭐⭐⭐ |
| [智能体安全扫描](usecases/智能体安全扫描/agent-security-scanning.md) | 使用 ClawGuard 在安装前自动扫描技能和插件，检测提示注入、隐私泄露和供应链攻击 | 📦 | ⭐⭐ |
| [AionUI桌面协作站](usecases/AionUI桌面协作站/aionui-cowork-desktop.md) | 通过桌面 Cowork UI 使用 OpenClaw，支持远程救援、多智能体和多渠道访问 | 📦 | ⭐⭐ |
| [PR雷达](usecases/PR雷达/README.md) | 持续扫描多个仓库的开放PR和CI运行状态，生成分类摘要报告，标记阻塞、陈旧和可合并的PR，并推送行动建议到Slack/Telegram | 🔔 📦 | ⭐⭐ |

<details>
<summary>🇨🇳 基础设施与运维 — 国内替代方案</summary>

- 智能体安全扫描 → 🇨🇳 通用性强，可直接使用，ClawGuard 支持本地运行
- 这类用例主要依赖 OpenClaw 自身能力和服务器环境，国内替代方案较少
- 数据源方面可考虑：**Gitee** 替代 GitHub、**阿里云/腾讯云**监控替代国外服务

</details>

### 🧠 知识管理与学习

### 📝 写作工具

| 用例 | 说明 | 标记 | 难度 |
|------|------|------|------|
| [LaTeX论文写作](usecases/LaTeX论文写作/latex-paper-writing.md) | 将智能体变为 LaTeX 写作助手，支持对话式编写和即时编译 PDF，无需本地安装 TeX 环境 | 📦 | ⭐⭐ |

| 用例 | 说明 | 标记 | 难度 |
|------|------|------|------|
| [个人知识库RAG](usecases/个人知识库RAG/knowledge-base-rag.md) | 将保存的内容构建为可搜索的语义知识库，支持 URL 自动抓取 | ✅ 📦 | ⭐ |
| [第二大脑](usecases/第二大脑/second-brain.md) | 零阻力记忆采集系统，通过短信记录灵感，配合可搜索仪表板检索 | ✅ 📦 | ⭐ |
| [语义记忆搜索](usecases/语义记忆搜索/semantic-memory-search.md) | 基于向量引擎的语义搜索，为记忆文件提供按含义检索能力 | ✅ | ⭐ |
| [arXiv论文阅读器](usecases/arXiv论文阅读器/arxiv-paper-reader.md) | 通过 ID 获取 arXiv 论文，对话式阅读分析，支持多论文对比 | ✅ | ⭐ |
| [市场调研与产品工厂](usecases/市场调研与产品工厂/market-research-product-factory.md) | 在 Reddit 和 X 上挖掘真实痛点，自动从调研到原型构建完整产品流水线 | 📦 | ⭐⭐ |
| [构建前创意验证](usecases/构建前创意验证/pre-build-idea-validator.md) | 在构建前自动扫描 GitHub、HN、npm 等平台检查竞争情况，返回拥挤度评分 | 📦 | ⭐⭐ |
| [财报追踪器](usecases/财报追踪器/earnings-tracker.md) | AI 驱动的财报追踪与摘要推送，实时掌握科技和 AI 公司财报动态 | 🔔 📦 | ⭐⭐ |
| [三层记忆系统](usecases/三层记忆系统/04-three-tier-memory-system.md) | 兼顾速度与持久性的智能体记忆结构化方案，采用长期核心原则、每日事件日志和项目专项追踪三层架构 | ✅ | ⭐ |
| [每日学习日志](usecases/每日学习日志/57-daily-learning-journal.md) | 每天晚上通过智能体引导反思当日所学，自动记录日志并生成每周/每月成长报告 | 🔔 | ⭐ |
| [深度研究编排器](usecases/深度研究编排器/deep-research-orchestrator.md) | 通过浏览器中继同时调用 Claude、ChatGPT 和 Gemini 的深度研究功能，并行研究同一问题，交叉验证后综合生成一份经过验证的结论 | 📦 | ⭐⭐⭐ |

<details>
<summary>🇨🇳 知识管理与学习 — 国内替代方案</summary>

- 个人知识库RAG → 🇨🇳 通用性强，可直接使用
- 第二大脑 → 🇨🇳 前端可替换为**任何前端框架**（Vue/React 等）
- 语义记忆搜索 → 🇨🇳 通用性强，可直接使用
- arXiv论文阅读器 → 🇨🇳 可扩展支持**知网、万方**等国内论文库
- 市场调研与产品工厂 → 🇨🇳 可替代为：**知乎、微博、即刻**替代 Reddit/X 做调研
- 构建前创意验证 → 🇨🇳 可替代为：**Gitee**替代 GitHub、**掘金**替代 HN
- 财报追踪器 → 🇨🇳 可扩展支持**A股财报**（巨潮资讯等）
- 每日学习日志 → 🇨🇳 通用性强，可直接使用，可通过**微信/飞书/钉钉**替代 Telegram 推送每日提示
- 三层记忆系统 → 🇨🇳 通用性强，可直接使用，是 OpenClaw 记忆管理的最佳实践方案
- 深度研究编排器 → 🇨🇳 可替代为：**通义千问、文心一言、Kimi**替代 Claude/ChatGPT/Gemini，通过国内浏览器中继或 API 实现类似多平台并行研究

</details>

### 💰 财经追踪

| 用例 | 说明 | 标记 | 难度 |
|------|------|------|------|
| [Polymarket自动交易](usecases/Polymarket自动交易/polymarket-autopilot.md) | 在预测市场上自动化模拟交易，支持多种策略、回测分析和每日绩效报告 | 🔔 📦 | ⭐⭐⭐ |

<details>
<summary>🇨🇳 财经追踪 — 国内替代方案</summary>

- Polymarket自动交易 → 🇨🇳 可参考类似逻辑应用于国内**虚拟盘模拟交易**

</details>

### 🎧 客户服务与销售

| 用例 | 说明 | 标记 | 难度 |
|------|------|------|------|
| [多渠道AI客服](usecases/多渠道AI客服/multi-channel-customer-service.md) | 将 WhatsApp、Instagram、邮件、Google 评论整合到 AI 收件箱，24/7 自动回复 | 📦 | ⭐⭐⭐ |
| [个人CRM](usecases/个人CRM/personal-crm.md) | 自动从邮件和日历发现并追踪联系人，支持自然语言查询和会议准备简报 | 🔔 📦 | ⭐⭐ |
| [本地CRM框架](usecases/本地CRM框架/local-crm-framework.md) | 一条命令将 OpenClaw 变成本地 CRM 和销售自动化平台，支持自然语言查询和多视图 | 📦 | ⭐⭐⭐ |
| [SLA守护者](usecases/SLA守护者/README.md) | 定时扫描客服收件箱，识别有 SLA 违约风险的会话，自动分级并生成升级摘要推送 | 🔔 📦 | ⭐⭐ |

<details>
<summary>🇨🇳 客户服务与销售 — 国内替代方案</summary>

- 多渠道AI客服 → 🇨🇳 可替代为：**微信公众号、企业微信**作为客户触点
- 个人CRM → 🇨🇳 通用性强，可直接使用
- 本地CRM框架 → 🇨🇳 通用性强，DenchClaw 支持本地部署
- SLA守护者 → 🇨🇳 可替代为：**飞书群、钉钉群**替代 Slack 推送，**QQ邮箱、163邮箱**替代 Gmail

</details>

### 🎮 创意与开发

| 用例 | 说明 | 标记 | 难度 |
|------|------|------|------|
| [自主教育游戏开发流水线](usecases/自主教育游戏开发流水线/autonomous-game-dev-pipeline.md) | 自主管理游戏从创建到维护的完整生命周期，每 7 分钟产出一款新游戏 | 📦 | ⭐⭐⭐ |

> 💡 此分类持续扩展中，欢迎提交 PR 添加更多创意与开发类用例！

<details>
<summary>🇨🇳 创意与开发 — 国内替代方案</summary>

- 游戏开发流水线 → 🇨🇳 通用性强，开发流程无地域限制

</details>

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
- 每个用例请补充 **难度分级**和**国内替代方案**标注
- 更新本 README 的分类表格

## 🔗 相关链接

- [上游仓库 - awesome-openclaw-usecases](https://github.com/hesamsheikh/awesome-openclaw-usecases) — 原始英文用例合集
- [OpenClaw 官网](https://openclaw.ai) — OpenClaw 产品主页
- [OpenClaw 文档](https://docs.openclaw.ai) — 官方使用文档

## 📄 许可证

本项目基于 [MIT License](LICENSE) 开源。

## 🙏 致谢

- [hesamsheikh/awesome-openclaw-usecases](https://github.com/hesamsheikh/awesome-openclaw-usecases) — 原始英文用例合集
- [AlexAnys/awesome-openclaw-usecases-zh](https://github.com/AlexAnys/awesome-openclaw-usecases-zh) — 另一个优秀的中文翻译项目
- 所有参与翻译和贡献的贡献者

---

<p align="center">
  如果觉得这个项目对你有帮助，欢迎点个 ⭐ Star 支持一下！
</p>

<p align="center">
  <sub>Built with ❤️ by Lester</sub>
</p>
