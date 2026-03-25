# 角色图像生成

直接在聊天中为你认养的角色生成任意场景、风格或氛围的 AI 图像。

## 痛点

创建角色图像通常需要打开平台网页 UI、手动搜索场景、逐一调整设置。没有办法在自然语言中描述你想要的内容，并在不离开工作流的情况下直接获得图像。

## 功能介绍

使用 `image-generation-claw-skill`，OpenClaw 从 `SOUL.md` 读取你的角色信息，将其解析为角色 vtoken，构建结构化提示词，提交图像生成任务，轮询直到完成，并返回图像 URL — 所有这些只需一条聊天消息：

> *"Draw 关羽 in a rainy bamboo forest, cinematic lighting, portrait"*

支持：
- 自然语言自定义提示词
- 艺术风格（漫画、油画、水彩、电影感、像素风等）
- 画面比例：竖版、横版、方形、长图
- 额外参考图像用于风格/一致性控制
- 会话中途切换角色的角色搜索功能

## 提示词示例

```
Draw [character name] in [scene description], [style], [mood]
```

```
Generate a landscape banner of [character] with dramatic lighting
```

```
Same character, watercolor style, autumn forest
```

```
Show me style options
```

## 所需技能

- [`image-generation-claw-skill`](https://github.com/tonyclawskill/image-generation-claw-skill) — 零依赖 Node.js 辅助工具
- 包含你认养角色的 `SOUL.md` 文件（由 `adopt` 技能创建）
- `~/.openclaw/workspace/.env` 中的 API 令牌

## 示例输出

> 🔍 Looking up character: 关羽...
> ✅ Character resolved: 关羽
> 🎨 Generating image (576×768)...
> ⏳ Task submitted: 3835c8de-...
>
> ━━━━━━━━━━━━━━━━━━━━━━━━
> ✨ 关羽 · rainy bamboo forest, cinematic
> https://oss.talesofai.cn/picture/3835c8de-...webp
> ━━━━━━━━━━━━━━━━━━━━━━━━

## 相关链接

- [image-generation-claw-skill](https://github.com/tonyclawskill/image-generation-claw-skill)
- [travelclaw — 角色冒险技能](https://github.com/talesofai/travelclaw)
