# 语音激活智能助手（带上下文感知）

你正在做饭、开车或遛狗——需要智能体帮你做点什么。"Hey Jarvis，给 Rob 发封邮件说说预算的事。"你的智能体应该知道 Rob 是谁、你说的哪个预算，然后直接把邮件发出去，不用你一字一句地拼。

这个用例将 OpenClaw 变成一个语音激活助手，能够根据你的联系人、项目和近期对话构建的知识图谱来解析语音命令。

## 功能特性

- 监听唤醒词（"Hey Jarvis"，或你自定义的任意词）
- 在本地转录你的语音命令
- 从个人知识图谱中解析实体（"Rob" → Rob Martinez, rob@vectorcare.com）
- 分发动作：发邮件、发短信、设置提醒、搜索、日历操作、记笔记
- 通过你偏好的渠道确认执行结果（iMessage、Telegram 等）
- 声纹授权机制确保只有经过批准的声音才能触发动作

## 解决的痛点

Siri 和 Alexa 等语音助手太"笨"了。它们除了通讯录之外不了解你的联系人，无法将"客户"解析为具体的人，也无法把"预算那件事"关联到某次特定对话。缺失的关键一环是**上下文**——这需要从你的真实对话中构建知识图谱。

## 所需技能

- [Percept](https://github.com/GetPercept/percept) — 语音采集 + 上下文智能（`pip install getpercept`）
- 音频输入源：[Omi 项链](https://www.omi.me/)、Apple Watch 或笔记本电脑麦克风
- iMessage、Telegram 或 Discord 用于确认通知
- Google Workspace（可选，用于通过 `gog` CLI 收发邮件/管理日历）

## 配置方法

1. 安装并启动 Percept：
```bash
pip install getpercept
percept init
percept serve --port 8900
```

2. 在 Percept 控制台配置唤醒词（默认端口 8960）：
   - 进入 Settings（设置）
   - 设置唤醒词：`["hey jarvis"]`（或你偏好的触发词）

3. 授权声纹（安全机制——只有你的声音能触发动作）：
```bash
# 自然地说几段对话让 Percept 学习你的声音标签
# 然后授权你的说话人 ID：
percept speakers authorize SPEAKER_0
```

4. 连接你的音频输入源（Omi 项链、手表或麦克风）并开始对话：
```
"Hey Jarvis，给 Rob 发封邮件说说下周二 Q2 预算会议的事"
"Hey Jarvis，20 分钟后提醒我检查部署"
"Hey Jarvis，Sarah 上周关于供应商合同说了什么？"
"Hey Jarvis，记一下——客户要求提案在 3 月 5 日前提交"
```

5. Percept 会：
   - 检测唤醒词
   - 等待完整命令（智能静音检测）
   - 从知识图谱中解析 "Rob" → Rob Martinez
   - 解析意图（邮件、提醒、搜索、笔记）
   - 通过 OpenClaw 执行并通过 iMessage/Telegram 确认

## 交互示例

```
你："Hey Jarvis，通知团队站会改到下午 2 点"

[Percept]
  → 唤醒词已检测
  → 意图：短信/消息
  → 解析结果："团队" → VectorCare 站会群组
  → 动作：通过 iMessage 发送到群组

智能体："✅ 已发送至 VectorCare 站会群：'站会今天改到下午 2 点'"
```

```
你："Hey Jarvis，上周我们和 Priority Ambulance 讨论了什么？"

[Percept]
  → 唤醒词已检测
  → 意图：搜索
  → 实体：Priority Ambulance
  → 正在搜索最近 7 天的对话记录...

智能体："上周二你们讨论了他们在佐治亚州的车队扩张计划、
FHIR 集成时间表，他们还询问了实时 GPS 追踪功能。
Rob 承诺在周五之前发送一份报价方案。"
```

## 为什么有效

核心不在语音识别——Whisper 已经处理得很好了。真正的魔法是**基于个人知识图谱的实体解析**。当你说"Rob"时，Percept 的 5 级解析级联会依次检查精确匹配、模糊匹配、关系图谱上下文、近期使用频率和语义相似度，来确定你指的是哪个 Rob。这才是让它感觉像一个真正的助手，而不是一个花哨的听写工具的原因。

## 安全性

- 声纹授权：只有经过批准的声音才能触发动作
- 所有处理均在本地完成——音频数据不会离开你的设备
- 危险命令（rm、sudo、转账等）通过安全检查进行拦截
- 安全事件会记录日志以供审计

## 相关链接

- [Percept GitHub](https://github.com/GetPercept/percept)
- [Omi 项链](https://www.omi.me/)
- [Percept on PyPI](https://pypi.org/project/getpercept/)
- [OpenClaw 技能](https://github.com/openclaw/openclaw)
