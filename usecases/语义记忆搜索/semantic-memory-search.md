# 语义记忆搜索

OpenClaw 内置的记忆系统将所有内容存储为 Markdown 文件——但随着记忆在数周甚至数月中不断增长，找到上周二做出的某个决定变得几乎不可能。系统没有搜索功能，只能逐个翻阅文件。

本用例在 OpenClaw 现有的 Markdown 记忆文件之上，通过 [memsearch](https://github.com/zilliztech/memsearch) 添加了**基于向量引擎的语义搜索**功能，让你可以按含义即时检索任何历史记忆，而不仅限于关键词匹配。

## 功能特性

- 使用单条命令将所有 OpenClaw Markdown 记忆文件索引到向量数据库（Milvus）中
- 按含义搜索：例如搜索"我们选择了什么缓存方案？"，即使原文中并未出现"缓存"一词，也能找到相关记忆
- 混合搜索（稠密向量 + BM25 全文检索），通过 RRF 重排序获得最佳结果
- 采用 SHA-256 内容哈希机制，未变更的文件不会重新嵌入——零 API 调用浪费
- 文件监控器在记忆文件发生变更时自动重新索引，确保索引始终最新
- 兼容任意嵌入模型提供商：OpenAI、Google、Voyage、Ollama，或完全本地运行（无需 API 密钥）

## 解决的痛点

OpenClaw 的记忆以纯 Markdown 文件存储，这便于迁移和人类阅读，但缺乏搜索能力。随着记忆不断积累，你只能通过 `grep` 搜索文件（仅限关键词匹配，会遗漏语义相关的结果）或将整个文件加载到上下文中（在无关内容上浪费 Token）。你需要一种方式来提问"关于 X 我当时做了什么决定？"，并获取精确相关的片段，无论措辞如何。

## 所需技能

- 无需 OpenClaw 技能——memsearch 是独立的 Python CLI/库
- Python 3.10+，配合 pip 或 uv

## 配置方法

1. 安装 memsearch：
```bash
pip install memsearch
```

2. 运行交互式配置向导：
```bash
memsearch config init
```

3. 索引你的 OpenClaw 记忆目录：
```bash
memsearch index ~/path/to/your/memory/
```

4. 按含义搜索记忆：
```bash
memsearch search "what caching solution did we pick?"
```

5. 如需实时同步，启动文件监控器——它会在每次文件变更时自动索引：
```bash
memsearch watch ~/path/to/your/memory/
```

6. 如需完全本地部署（无需 API 密钥），安装本地嵌入模型：
```bash
pip install "memsearch[local]"
memsearch config set embedding.provider local
memsearch index ~/path/to/your/memory/
```

## 核心要点

- **Markdown 始终为真实数据源。** 向量索引仅作为派生缓存，你可以随时通过 `memsearch index` 重建。你的记忆文件永远不会被修改。
- **智能去重节省费用。** 每个文本块通过 SHA-256 内容哈希进行标识。重新运行 `index` 仅会对新增或变更的内容进行嵌入，你可以随意执行索引而不会浪费嵌入 API 调用。
- **混合搜索优于纯向量搜索。** 通过倒数排名融合（Reciprocal Rank Fusion）将语义相似度（稠密向量）与关键词匹配（BM25）相结合，能够同时捕获基于含义的查询和精确匹配的查询。

## 相关链接

- [memsearch GitHub](https://github.com/zilliztech/memsearch) — 驱动本用例的核心库
- [memsearch 文档](https://zilliztech.github.io/memsearch/) — 完整 CLI 参考、Python API 及架构说明
- [OpenClaw](https://github.com/openclaw/openclaw) — 启发 memsearch 的记忆架构
- [Milvus](https://milvus.io/) — 向量数据库后端
