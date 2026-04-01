<!-- Original: auditable-project-memory.md -->

# 可审计项目记忆与决策回溯

长期运行的 OpenClaw 项目最终都会遇到一个记忆问题：智能体确实记住了*某些东西*，但你无法快速判断**什么变了、为什么变、上下文从何而来，以及是否仍然可信**。

本工作流使用 [openclaw-mem](https://github.com/phenomenoner/openclaw-mem) 作为面向项目工作的本地优先记忆层。与其将记忆视为黑盒，不如维护一本可检查、可查询、可审查的账本，在旧上下文悄悄影响新决策之前先做确认。

## 痛点

在较长期的项目中，上下文会逐渐漂移。

你会问：
- "我们为什么不再使用那个库了？"
- "自从上一个可用版本以来，改了什么？"
- "这个回答的依据是什么？"

如果没有可审计的记忆层，智能体可能会调出过时的或来源薄弱的上下文，而你没有快速验证的方法。仅靠搜索能有所帮助，但无法解决信任问题。

## 功能说明

- 将项目观察记录捕获到本地 JSONL + SQLite 记忆账本中
- 提供确定性回溯循环：**搜索 → 时间线 → 获取**
- 允许你检查近期的决策历史，而无需将巨大的记忆文件加载到上下文中
- 生成 JSON 凭证，使回溯和审查更易于审计
- 支持只读记忆健康检查，以便在修改任何内容之前审查过时或膨胀的记忆
- 帮助防止较弱或过时的记忆占据智能体有限的上下文窗口

## 所需工具

- [`openclaw-mem`](https://github.com/phenomenoner/openclaw-mem)
- Python 3.13 + [`uv`](https://github.com/astral-sh/uv)
- OpenClaw（如果后续想添加自动捕获，则为可选）

## 设置步骤

1. 克隆并安装：

```bash
git clone https://github.com/phenomenoner/openclaw-mem.git
cd openclaw-mem
uv sync --locked
```

2. 快速测试本地账本：

```bash
uv run --python 3.13 --frozen -- python -m openclaw_mem --json status
```

3. 将笔记、决策或示例记忆导入数据库：

```bash
uv run --python 3.13 --frozen -- python ./scripts/make_sample_jsonl.py --out ./sample.jsonl
uv run --python 3.13 --frozen -- python -m openclaw_mem ingest --file ./sample.jsonl --json
```

4. 使用回溯循环检查系统会返回什么内容：

```bash
uv run --python 3.13 --frozen -- python -m openclaw_mem search "OpenClaw" --limit 10 --json
uv run --python 3.13 --frozen -- python -m openclaw_mem timeline 2 --window 2 --json
uv run --python 3.13 --frozen -- python -m openclaw_mem get 1 --json
```

5. 运行只读记忆健康检查：

```bash
uv run --python 3.13 --frozen -- python -m openclaw_mem optimize review --json --limit 200
```

6. 如果你已经在运行 OpenClaw，添加 sidecar 插件以自动捕获观察记录：

```bash
# From the openclaw-mem directory:
ln -s ./extensions/openclaw-mem ~/.openclaw/plugins/openclaw-mem
openclaw gateway restart
```

然后导入已捕获的观察记录：

```bash
uv run --python 3.13 --frozen -- python -m openclaw_mem ingest \
  --file ~/.openclaw/memory/openclaw-mem-observations.jsonl --json
```

## 提示词 / 工作流

账本填充完成后，在基于旧上下文采取行动之前，先将其作为检查依据：

```text
在回答有关本项目过去决策的问题之前：
1. 先检查 openclaw-mem
2. 优先使用近期且来源充分的上下文
3. 如果记忆看起来过时或依据薄弱，请明确说明
4. 在相关时引用记忆凭证或来源备注
```

## 核心洞察

- **凭证胜于直觉。** 问"这个回答的依据是什么？"远比假设智能体记对了更安全。
- **本地优先的记忆更值得信任。** 你可以直接检查账本，而不是将记忆当作隐藏状态。
- **记忆质量的核心在于筛选。** 在长期项目中，难点不仅是存储更多上下文——而是决定什么仍然值得占用上下文窗口的空间。
- **Sidecar 优先的采用方式可降低风险。** 你可以先通过本地捕获和回溯验证价值，再对 OpenClaw 配置做更深入的改动。

## 相关链接

- [openclaw-mem GitHub](https://github.com/phenomenoner/openclaw-mem)
- [快速入门](https://github.com/phenomenoner/openclaw-mem/blob/main/QUICKSTART.md)
- [自动捕获插件](https://github.com/phenomenoner/openclaw-mem/blob/main/docs/auto-capture.md)
- [产品介绍](https://github.com/phenomenoner/openclaw-mem/blob/main/docs/about.md)
- [OpenClaw](https://github.com/openclaw/openclaw)
