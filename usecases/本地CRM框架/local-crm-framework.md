# 本地 CRM 框架（DenchClaw）

搭建一个真正能与 OpenClaw 配合使用的 CRM 非常痛苦。你需要连接数据库、构建 UI、配置浏览器自动化、对接消息平台，还要让智能体理解你的数据结构。大多数人在中途就放弃了，最终只能用一个半成品的 Notion 集成凑合。

DenchClaw 是一个开源框架，只需一条命令即可将 OpenClaw 变成完全本地的 CRM、销售自动化和生产力平台——完全运行在你的机器上。

## 痛点

OpenClaw 作为底层能力非常强大，但要用于实际业务工作流（线索跟踪、外联、管道管理），需要拼凑十几个工具：数据库、UI、浏览器访问、消息集成、文件管理。每增加一个集成就意味着更多手动配置、更多需要管理的凭证、更多可能出问题的环节。你想要的是 Cursor 级别的业务操作体验，而不是一堆 shell 脚本。

## 功能介绍

- **一键安装**：`npx denchclaw` 安装一切——DuckDB 数据库、Web UI、OpenClaw 配置、浏览器自动化、技能——并在 `localhost:3100` 打开
- **自然语言 CRM**：问"显示员工超过 5 人的公司"它会实时更新视图。无需手动筛选
- **完整浏览器自动化**：复制你的 Chrome 配置文件，使智能体拥有与你相同的认证状态——说"从我的 HubSpot 导入所有数据"它会登录、导出并导入
- **多种视图**：表格、看板、日历、时间线（甘特图）、图库和列表视图——均可通过 YAML 由智能体配置
- **应用构建器**：OpenClaw 构建独立的 Web 应用（仪表盘、工具、游戏），在工作空间内运行并可访问你的数据
- **文件系统优先**：表格筛选、视图、列切换、日历设置——一切都是文件，OpenClaw 可以直接读取和修改
- **也可作为编码智能体**：DenchClaw 构建了 DenchClaw。它也是一个完整的文件树浏览器和代码编辑器

## 设置方法

1. 一条命令安装：

```bash
npx denchclaw
```

2. 完成引导向导。DenchClaw 创建一个名为 `dench` 的专用 OpenClaw 配置并在端口 19001 启动网关。

3. 在浏览器中打开 `localhost:3100`。在 Safari 上，可以将其添加到 Dock 作为 PWA。

4. 开始对话：

```text
Hey, create a "Leads" object with fields: Name, Email, Company, Status (New/Contacted/Qualified/Won/Lost), and Notes. Import this CSV of leads I downloaded from Apollo.
```

```text
Show me all leads where Status is "Contacted" and sort by last updated. Switch to Kanban view grouped by Status.
```

```text
Go to my LinkedIn, find the last 20 people who viewed my profile, and add them as leads with their company info enriched.
```

```text
Draft a personalized outreach email to each lead in "New" status based on their company's recent news. Save the drafts in a new "Outreach Drafts" document.
```

5. 你也可以从 Telegram 或任何已连接的消息平台使用——在路上用手机管理你的销售管道。

## 所需技能

DenchClaw 自动打包所有所需技能：

- **CRM 技能** — 基于 DuckDB 的结构化数据管理，支持对象、字段、条目和多种视图类型
- **应用构建技能** — 构建在工作空间内运行的 Web 应用（仪表盘、工具），可访问数据库
- **浏览器自动化技能** — 带有你现有 Chrome 认证状态的 Chromium 浏览器，用于网页抓取、导入和外联

无需额外安装或配置任何技能。

## 核心洞察

- **文件系统 = 智能体原生 UI**：因为每个设置、筛选和视图都存储为 YAML/markdown 文件，OpenClaw 可以像编辑代码一样自然地修改 UI。无需 API 包装器。
- **DuckDB 是最佳平衡点**：最小、最高性能的嵌入式数据库，同时支持完整 SQL。无服务进程、无凭证、无网络——只是一个文件。
- **Chrome 配置克隆是超能力**：DenchClaw 复制你的浏览器认证状态，而不是与 OAuth 流程和 API 限速搏斗。智能体看到的就是你看到的，做你能做的事。
- **一条 `npx` 命令胜过周末的搭建工作**：整个技术栈（数据库、Web UI、OpenClaw 配置、网关、浏览器、技能）自动安装和配置。无需 Docker、无 .env 文件、无依赖地狱。

## 演示

[观看演示视频](https://www.youtube.com/watch?v=pfACTbc3Bh4#t=43) — 展示从安装到通过自然语言管理实时 CRM 管道的完整工作流。

## 相关链接

- [DenchClaw GitHub](https://github.com/DenchHQ/DenchClaw) — MIT 许可，开源
- [DenchClaw 官网](https://denchclaw.com)
- [Discord 社区](https://discord.gg/PDFXNVQj9n)
- [Skills Store](https://skills.sh)
