# 语义记忆搜索

OpenClaw 的内置记忆系统将所有内容存储为 Markdown 文件 —— 但随着记忆在几周和几个月中不断积累，找到上周二做出的那个决定变得几乎不可能。这里没有搜索功能，只能滚动浏览文件。

本用例在 OpenClaw 现有的 Markdown 记忆文件基础上，使用 [memsearch](https://github.com/zilliztech/memsearch) 添加了**向量驱动的语义搜索**功能，让您可以通过含义而非关键词即时找到任何过去的记忆。

## 核心功能

- **一键索引**：通过单个命令将所有 OpenClaw Markdown 记忆文件索引到向量数据库（Milvus）中
- **语义搜索**：按含义搜索 —— "我们选择了什么缓存解决方案？" 即使不出现"caching"一词也能找到相关记忆
- **混合搜索**：结合密集向量和 BM25 全文搜索，通过 RRF 重排序获得最佳结果
- **智能去重**：使用 SHA-256 内容哈希，确保未变更的文件不会被重复嵌入 —— 零浪费 API 调用
- **自动同步**：文件监视器在记忆文件变更时自动重新索引，确保索引始终是最新的
- **灵活嵌入**：支持任何嵌入提供商：OpenAI、Google、Voyage、Ollama，或完全本地运行（无需 API 密钥）

## 痛点分析

OpenClaw 的记忆以纯 Markdown 文件的形式存储。这有利于便携性和人类可读性，但缺乏搜索功能。随着记忆的增长，您要么不得不 grep 文件（仅限关键词，错过语义匹配），要么将整个文件加载到上下文中（在无关内容上浪费 token）。您需要一种方式能够询问"我对 X 做了什么决定？"，无论表述方式如何，都能获得相关的精确片段。

## 所需技能

- 无需 OpenClaw 技能 —— memsearch 是独立的 Python CLI/库
- Python 3.10+ 及 pip 或 uv

## 设置指南

### 1. 安装 memsearch
```bash
pip install memsearch
```

### 2. 运行交互式配置向导
```bash
memsearch config init
```

### 3. 索引您的 OpenClaw 记忆目录
```bash
memsearch index ~/path/to/your/memory/
```

### 4. 按含义搜索您的记忆
```bash
memsearch search "what caching solution did we pick?"
```

### 5. 启用实时同步
启动文件监视器 —— 它会在每次文件变更时自动重新索引：
```bash
memsearch watch ~/path/to/your/memory/
```

### 6. 完全本地设置（无需 API 密钥）
```bash
pip install "memsearch[local]"
memsearch config set embedding.provider local
memsearch index ~/path/to/your/memory/
```

## 关键洞察

**Markdown 保持事实真相**：向量索引只是派生的缓存 —— 您可以随时使用 `memsearch index` 重新构建。您的记忆文件永远不会被修改。

**智能去重节省成本**：每个片段都由 SHA-256 内容哈希标识。重新运行 `index` 只会嵌入新的或变更的内容，因此您可以随意运行而不会浪费嵌入 API 调用。

**混合搜索优于纯向量搜索**：通过倒排等级融合（RRF）结合语义相似度（密集向量）和关键词匹配（BM25），能够同时捕获基于含义和精确匹配的查询。

## 实际应用示例

**日常使用**：
```bash
# 搜索特定决策
memsearch search "我们选择了什么数据库方案？"

# 查找会议讨论
memsearch search "关于API设计的讨论要点"

# 回顾技术选型
memsearch search "为什么选择Go而不是Python"
```

**高级搜索**：
```bash
# 组合搜索条件
memsearch search "缓存策略 + Redis实现"

# 时间范围搜索
memsearch search "2024年初架构决策"

# 项目相关搜索
memsearch search "用户认证系统设计"
```

## 最佳实践

1. **定期备份**：定期备份您的记忆文件，确保数据安全
2. **合理分块**：较大的文件建议合理分块，提高搜索精度
3. **及时索引**：添加新记忆后及时运行索引，保持搜索时效性
4. **本地优先**：敏感数据建议使用本地嵌入提供商，保护隐私
5. **批量操作**：大批量文件变更时，建议使用批量索引功能

## 相关链接

- [memsearch GitHub](https://github.com/zilliztech/memsearch) —— 支持此用例的库
- [memsearch 文档](https://zilliztech.github.io/memsearch/) —— 完整的 CLI 参考、Python API 和架构说明
- [OpenClaw](https://github.com/openclaw/openclaw) —— 启发 memsearch 的记忆架构
- [Milvus](https://milvus.io/) —— 向量数据库后端