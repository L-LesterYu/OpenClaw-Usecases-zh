# AI YouTube 视频剪辑（Tubeify）

## 痛点
独立 YouTube 创作者花费大量时间手动浏览原始录制素材，逐帧裁剪空白停顿、填充词和长暂停。这项工作枯燥且重复，完全可以让 AI 智能体自动完成。

## 功能说明
使用 OpenClaw 配合 Tubeify 技能，提交原始视频 URL，几分钟内即可获得精修剪辑后的视频——无需手动编辑，无需非线性编辑软件。

## 提示词
```text
编辑我的最新录制视频 [VIDEO_URL]。删除所有超过 0.5 秒的停顿和填充词。保持 1.0x 原速。
```

## 所需技能
- [`tubeify`](https://clawhub.ai/esokullu/tubeify) — 基于 API 的 AI YouTube 视频编辑器

## 工作流程
1. 智能体使用钱包地址向 Tubeify 进行身份验证
2. 提交原始视频 URL 及处理选项（停顿移除、填充词移除、速度调整）
3. 轮询状态端点，直到处理完成
4. 返回精修视频的下载链接

## 相关链接
- [Tubeify](https://tubeify.xyz)
- [ClawHub 技能](https://clawhub.ai/esokullu/tubeify)
- API: `POST https://tubeify.xyz/process.php`
