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

---

## 📖 项目简介

本项目是对 github上的OpenClaw的usecases比如[awesome-openclaw-usecases](https://github.com/hesamsheikh/awesome-openclaw-usecases) 仓库的**中文翻译**，旨在帮助中文用户快速理解和使用各种 OpenClaw 实用用例。

> 🌟 **一句话定位：** 将全球最棒的 OpenClaw 用例翻译成中文，降低使用门槛。

## ⭐ 推荐用例

| 用例 | 推荐理由 |
|------|---------|
| 🗞️ 多源科技新闻摘要 | 覆盖 109+ 信源，一条命令掌握全球科技动态 |
| 📚 个人知识库RAG | 将零散信息构建为可搜索的语义知识库，AI 驱动的第二大脑 |
| 📧 收件箱清理 | 自动清理订阅邮件，每天推送精选摘要，越用越懂你 |

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
| [多源科技新闻摘要](usecases/多源科技新闻摘要/multi-source-tech-news-digest.md) | 自动聚合 109+ 信源的科技新闻，涵盖 RSS、Twitter/X、GitHub 发布和网页搜索，智能评分去重后推送 | 🔔 📦 |

### ⚡ 个人效率

| 用例 | 说明 | 标记 |
|------|------|------|
| [习惯追踪与问责教练](usecases/习惯追踪与问责教练/habit-tracker-accountability-coach.md) | 通过 Telegram 或短信进行每日习惯签到追踪，自适应提醒语气，周报分析模式 | 🔔 ✅ |
| [收件箱清理](usecases/收件箱清理/inbox-declutter.md) | 自动清理订阅邮件堆积，每天生成精选摘要并学习用户偏好持续优化 | 🔔 📦 |

### 💰 财经追踪

| 用例 | 说明 | 标记 |
|------|------|------|
| [财报追踪器](usecases/财报追踪器/earnings-tracker.md) | AI驱动的自动化财报追踪与摘要推送工具，帮助用户实时掌握科技和AI公司的财报动态 | 🔔 📦 |

### 🧠 知识管理

| 用例 | 说明 | 标记 |
|------|------|------|
| [个人知识库RAG](usecases/个人知识库RAG/knowledge-base-rag.md) | 将所有保存的内容构建为可搜索的语义知识库，支持 URL 自动抓取收录和智能检索 | ✅ 📦 |

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
