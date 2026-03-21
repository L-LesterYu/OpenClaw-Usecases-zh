# 每日YouTube摘要

每天清晨，获取你关注的最爱YouTube频道的个性化新视频摘要——再也不错过真正想看的创作者内容。

## 痛点

YouTube 的通知系统并不可靠。你订阅了频道，但新视频从不出现在首页信息流中。通知里也找不到。它们就这样……消失了。这并不意味着你不想看——只是 YouTube 的算法把它们埋没了。

此外，用精选内容洞察开启新的一天，远比在推荐信息流里无脑刷屏有意义得多。

## 功能说明

- 获取你关注频道列表中的最新视频
- 对每个视频的字幕进行摘要或提取关键洞察
- 每天定时（或按需）向你推送摘要

## 所需技能

安装 [youtube-full](https://clawhub.ai/therohitdas/youtube-full) 技能。

只需告诉你的 OpenClaw：

```text
"安装 youtube-full 技能并帮我配置好"
```

或者

```bash
npx clawhub@latest install youtube-full
```

就这样。其余的交给智能体处理——包括账号创建和 API 密钥配置。注册即送 **100 个免费额度**，无需信用卡。

> 注意：创建账号后，技能会根据操作系统自动将 API 密钥安全存储到正确的位置，因此 API 在所有上下文中都能正常工作。

![youtube-full 技能安装](https://pub-15904f15a44a4ea69350737e87660b92.r2.dev/media/1770620159490-e41e7baa.png)

### 为什么选择 TranscriptAPI.com 而不是 yt-dlp？

| 命令行工具（yt-dlp 等） | TranscriptAPI |
|--------------------------|---------------|
| 冗长的日志充斥智能体上下文 | 返回简洁的 JSON 响应 |
| 在 GCP/云端 OpenClaw 上无法运行 | 随处可用，速度快 |
| 随机被 YouTube 封锁 | 驱动服务百万用户的 [YouTubeToTranscript.com](https://youtubetotranscript.com)，带缓存，稳定可靠 |
| 需要安装二进制文件 | 无需二进制，纯 HTTP 调用 |

## 如何配置

### 方式一：基于频道的摘要

向 OpenClaw 发送提示：

```text
每天早上8点，获取以下 YouTube 频道的最新视频，并为我生成包含关键洞察的摘要：

- @TED
- @Fireship
- @ThePrimeTimeagen
- @lexfridman

对于每个新视频（过去24-48小时内上传的）：
1. 获取字幕
2. 用2-3个要点总结主要内容
3. 包含视频标题、频道名称和链接

如果频道标识无法解析，请搜索并找到正确的频道。
将我的频道列表保存到记忆中，以便后续添加或移除频道。
```

### 方式二：基于关键词的摘要

追踪特定主题的新视频：

```text
每天搜索 YouTube 上关于 "OpenClaw"（或 "Claude Code"、"AI agents" 等）的新视频。

维护一个名为 seen-videos.txt 的文件，记录已处理的视频 ID。
仅对不在该文件中的视频获取字幕。
处理完成后，将视频 ID 添加到 seen-videos.txt 中。

对于每个新视频：
1. 获取字幕
2. 给出3个要点的摘要
3. 标注与我工作相关的任何内容

每天早上9点执行此任务。
```

这样你就永远不会浪费额度去重复获取已经看过的视频。

## 使用技巧

- `channel/latest` 和 `channel/resolve` 是**免费的**（0额度）——检查新上传不会消耗任何额度
- 只有字幕转换需要每个1额度
- 可以要求不同的摘要风格：关键要点、精彩引语、精彩时刻的时间戳
- 已有同类产品 —— [Recapio - 每日 YouTube 回顾](https://recapio.com/features/daily-recaps)
