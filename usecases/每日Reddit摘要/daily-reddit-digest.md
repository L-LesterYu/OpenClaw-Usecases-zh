# 每日 Reddit 摘要
每天运行一次摘要推送，为你精选最喜欢的子版块中表现最热门的帖子。

适用场景：

• 浏览子版块（热门/最新/置顶帖子）
• 按主题搜索帖子
• 拉取评论串获取上下文
• 构建帖子候选列表，供后续人工查看/回复

> 仅限只读模式。不支持发帖、投票或评论。

## 所需技能
[reddit-readonly](https://clawhub.ai/buksan1950/reddit-readonly) 技能。无需认证。

## 设置方法
安装技能后，向你的 OpenClaw 发送以下指令：
```text
I want you to give me the top performing posts from the following subreddits.
<paste the list here>
Create a separate memory for the reddit processes, about the type of posts I like to see and every day ask me if I liked the list you provided. Save my preference as rules in the memory to use for a better digest curation. (e.g. do not include memes.)
Every day at 5pm, run this process and give me the digest.
```
