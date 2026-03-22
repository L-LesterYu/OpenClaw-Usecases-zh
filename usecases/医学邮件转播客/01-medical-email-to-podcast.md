# 医学邮件转播客

## 简介

将医学简报邮件自动转化为音频播客，方便通勤途中收听。该工作流会解析收到的医学邮件，深入研究其中嵌入的链接以获取更深入的背景信息，撰写针对医生专业方向的对话式播客脚本，使用 ElevenLabs 生成 TTS 语音，并通过 Signal 投递。

**为什么重要**：医生每天都会收到大量密集的医学简报邮件，但缺乏时间逐封阅读。将邮件转化为音频播客，让医生可以在通勤或锻炼时学习最新医学动态。

**实际案例**：一位全科医生每天收到"Doctors of BC Newsflash"简报。智能体将 6 篇报道转化为一段 5 分 18 秒的播客，涵盖急诊中心、疾病暴发和政策更新等内容。

## 所需技能

| 技能 | 来源 | 用途 |
|------|------|------|
| [`email`](https://clawhub.ai/skills/agentmail-wrapper) | ClawHub | 读取和解析收到的邮件 |
| `web_fetch` | 内置 | 研究链接文章内容 |
| [`elevenlabs`](https://clawhub.ai/skills/beware-piper-tts) | ClawHub | 生成 TTS 语音 |
| `ffmpeg` | 内置 | 拼接音频片段 |
| `signal` | 内置 | 投递最终音频文件 |

## 如何配置

### 1. 配置邮件检测

```
将医学简报邮件转发设置到智能体的 Gmail 邮箱。
在心跳巡检中配置自动检测，匹配以下条件的简报：
- 发件人：doctors@bcnews.com
- 主题包含："Newsflash"
```

### 2. 安装技能

```bash
npx molthub@latest install email
npx molthub@latest install web_fetch
npx molthub@latest install elevenlabs
npx molthub@latest install ffmpeg
npx molthub@latest install signal
```

### 3. 创建处理脚本

创建 `skills/email-podcast/index.js`：

```javascript
// 解析邮件 → 提取报道 → 研究链接 → 撰写脚本 → TTS → 投递
async function processMedicalEmail(email) {
  const stories = parseStories(email.body);
  const enriched = await Promise.all(
    stories.map(s => web_fetch(s.url).then(enhanceStory))
  );
  const script = writePodcastScript(enriched, "family_medicine");
  const audio = await generateTTS(script); // 超过 4000 字符时分块处理
  await signal.sendAudio({ to: human.phone, audio });
}
```

### 4. 提示词模板

添加到 `SKILL.md`：

```markdown
## 医学邮件转播客

当你收到医学简报邮件时：
1. 解析邮件正文，提取报道标题和链接
2. 对每个链接：获取完整文章以获得更深入的背景信息
3. 撰写一段 5 分钟的对话式播客脚本
4. 使用 ElevenLabs TTS（超过 4000 字符时分块，用 ffmpeg 拼接）
5. 通过 Signal 发送音频文件
6. 记录到 memory/medical-podcasts/YYYY-MM-DD.md

风格：专业但自然对话，针对全科医学场景定制。
```

### 5. 定时任务配置

```json
{
  "schedule": "0 6 * * *",
  "task": "check_medical_emails",
  "action": "process_and_deliver_podcast"
}
```

## 成功指标

- [ ] 简报在收到后 1 小时内处理完成
- [ ] 音频时长：5-7 分钟
- [ ] 用户在 24 小时内收听
- [ ] 零人工步骤

## 故障排除

| 问题 | 解决方案 |
|------|----------|
| TTS 失败（文本过长） | 按 4000 字符分块，使用 ffmpeg 拼接 |
| 链接返回付费墙 | 使用 web_fetch 配合 textise dot iitty |
| 音频质量不佳 | 切换 ElevenLabs 语音为 'Antoni' 或 'Bella' |

---

*示例来源：Fred（Moltbook）——"今天构建了一个邮件转播客技能"*
