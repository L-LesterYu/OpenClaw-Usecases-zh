# arXiv 论文阅读器

阅读 arXiv 论文意味着要下载 PDF、在不同论文之间切换时丢失上下文，还要费力解析密集的 LaTeX 符号。你希望能够以对话的方式阅读、分析和比较论文，而无需离开你的工作区。

这个工作流将你的智能体变成一个研究阅读助手：

- 通过 ID 获取任意 arXiv 论文，获得干净、可读的文本（LaTeX 会自动展平处理）
- 先浏览论文结构——列出章节来决定要读什么，再决定是否阅读全文
- 快速扫描多篇论文的摘要，对阅读列表进行优先级排序
- 让智能体总结、比较或点评特定章节
- 结果会在本地缓存——再次查看同一篇论文时是即时的

## 所需技能

- [arxiv-reader](https://github.com/Prismer-AI/Prismer/tree/main/skills/arxiv-reader) 技能（3 个工具：`arxiv_fetch`、`arxiv_sections`、`arxiv_abstract`）

无需 Docker 或 Python —— 该技能使用 Node.js 内置功能独立运行。它直接从 arXiv 下载，自动解压 LaTeX 源码并展平引用文件。

## 如何设置

1. 从 [Prismer 仓库](https://github.com/Prismer-AI/Prismer/tree/main/skills/arxiv-reader) 安装 `arxiv-reader` 技能 —— 将 `skills/arxiv-reader/` 目录复制到你的 OpenClaw 技能文件夹中。

2. 技能已就绪。向 OpenClaw 发送以下提示：
```text
我正在研究 [主题]。以下是我的工作流：

1. 当我给你一个 arXiv ID（例如 2301.00001）时：
   - 先获取摘要，让我判断是否相关
   - 如果我说"读一下"，获取完整论文（默认移除附录）
   - 总结关键贡献、方法和结果

2. 当我给你多个 ID 时：
   - 获取所有摘要，给我一个对比表
   - 按与我的研究主题的相关性进行排序

3. 当我询问某个特定章节时：
   - 先列出论文的章节
   - 然后获取并详细解释相关章节

维护一个我已阅读论文及其要点的持续列表。
```

3. 试试看："读一下 2401.04088 —— 主要贡献是什么？"
