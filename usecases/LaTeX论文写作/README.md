# LaTeX 论文写作

搭建本地 LaTeX 环境非常繁琐——安装 TeX Live 需要占用数 GB 空间，调试编译错误费时费力，在编辑器和 PDF 阅读器之间来回切换更打断了写作思路。你希望无需任何本地配置，就能以对话的方式编写和编译 LaTeX 论文。

本工作流将你的智能体变成一个 LaTeX 写作助手，支持即时编译：

- 与智能体协作编写 LaTeX——描述你的需求，它自动生成源码
- 使用 pdflatex、xelatex 或 lualatex 即时编译为 PDF（无需本地安装 TeX）
- 内联预览 PDF，无需切换到其他应用
- 使用起步模板（article、IEEE、beamer、中文论文）快速跳过样板代码
- 支持 BibTeX/BibLaTeX 参考文献——直接粘贴 .bib 内容即可

## 所需技能

- [latex-compiler](https://github.com/Prismer-AI/Prismer/tree/main/skills/latex-compiler) 技能（4 个工具：`latex_compile`、`latex_preview`、`latex_templates`、`latex_get_template`）
- Prismer 工作空间容器（在 8080 端口运行 LaTeX 服务器，内置完整 TeX Live）

## 如何配置

1. 克隆并使用 Docker 部署 [Prismer](https://github.com/Prismer-AI/Prismer)（LaTeX 服务器会随完整 TeX Live 自动启动）：
```bash
git clone https://github.com/Prismer-AI/Prismer.git && cd Prismer
docker compose -f docker/docker-compose.dev.yml up
```

2. `latex-compiler` 技能已内置——无需额外安装。向 OpenClaw 发送以下提示：
```text
帮我用 LaTeX 写一篇研究论文。以下是我的工作流：

1. 从 IEEE 模板开始（或根据需要选择 article/beamer）
2. 当我描述某个章节时，生成对应的 LaTeX 源码
3. 每次重大编辑后，编译并预览 PDF，以便我检查格式
4. 如果出现编译错误，阅读日志并自动修复
5. 当我提供 BibTeX 条目时，将其添加到参考文献中并重新编译

如果需要中文/CJK 支持，使用 xelatex，否则默认使用 pdflatex。
始终运行 2 次编译以正确生成交叉引用。
```

3. 试试看：「新建一篇 IEEE 格式的论文，标题为"A Survey of LLM Agents"。给出模板并填写摘要和引言部分，然后编译。」
