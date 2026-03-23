# Hugging Face 论文研究发现

紧跟 ML 研究前沿意味着每天都要刷新 Hugging Face Papers 页面，扫视几十个标题，逐一点进去看摘要，还要手动交叉比对 GitHub 仓库。你需要一种对话式的方式，在不离开工作区的情况下发现、筛选和深度阅读热门论文。

本工作流结合两个技能，打造完整的研究发现流水线：

- 浏览 Hugging Face 当日热门论文——按点赞数或日期排序
- 按关键词搜索论文，找到任何主题的相关研究
- 获取完整论文元数据：摘要、作者、GitHub 仓库、社区点赞数、AI 生成的摘要
- 阅读任意论文的社区讨论和评论
- 通过 arXiv ID 深度阅读论文的完整 LaTeX 源码（使用 arxiv-source）

## 所需技能

- [hf-papers](https://github.com/openclaw/skills/tree/main/skills/willamhou/hf-papers) 技能（4 个工具：`hf_daily_papers`、`hf_search_papers`、`hf_paper_detail`、`hf_paper_comments`）
- [arxiv-source](https://github.com/openclaw/skills/tree/main/skills/willamhou/arxiv-source) 技能（3 个工具：`arxiv_fetch`、`arxiv_sections`、`arxiv_abstract`）——用于获取完整论文文本

无需 Docker 或身份验证——两个技能均使用公开 API 并进行本地缓存。

## 如何设置

1. 安装两个技能：
```bash
clawhub install hf-papers
clawhub install arxiv-source
```

2. 使用以下工作流提示 OpenClaw：
```text
我想紧跟 ML 研究前沿。以下是我的每日工作流：

1. 每天早上，展示 Hugging Face 上排名前 10 的热门论文（按点赞数排序）
   - 对每篇论文展示：标题、点赞数、GitHub 仓库（如有）、一句话 AI 摘要

2. 当我说"搜索 [主题]"时：
   - 在 HF Papers 中搜索并展示最相关的结果
   - 高亮标出有 GitHub 仓库链接或高点赞数的论文

3. 当我选择一篇论文时（通过 ID）：
   - 展示完整摘要、作者和相关资源
   - 如有社区评论则展示
   - 询问是否需要深度阅读

4. 深度阅读时：
   - 通过 arxiv-source 获取完整论文
   - 总结核心贡献、方法和结果
   - 标注值得查看的代码仓库

维护一份今日已审阅论文的清单，附带一句话要点。
```

3. 试试看："今天 Hugging Face Papers 上有什么热门论文？"
