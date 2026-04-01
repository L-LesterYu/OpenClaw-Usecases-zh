# 自主教育游戏开发流水线

## 痛点
**起源故事：** 一位"老派 LAN 派对"爸爸想为自己 3 岁的女儿 Susana（以及即将出生的 Julieta）创建一个安全、无广告、高质量的游戏门户网站。现有网站充斥着垃圾信息、侵扰性广告和具有欺骗性的按钮（暗黑模式），让他的幼儿深受困扰。

**挑战：** 搭建一个"干净、快速、简洁"的门户网站并不难。真正的挑战在于——在**没有开发团队**的情况下，为特定发展阶段（0-15 岁）量身定制**40 多款教育游戏**来填充内容。手动开发对一位独自承担开发工作的家长来说太慢了，而在几十款游戏中保持一致性也变得越来越困难。

## 功能介绍
本用例定义了一个"游戏开发智能体"，能够自主管理游戏从创建到维护的整个生命周期。工作流严格执行 **"Bug 优先"** 策略——智能体在实现新功能之前，必须先检查并解决已报告的 Bug。

**效率：** 该流水线能够每 **7 分钟产出 1 款新游戏或修复 1 个 Bug**。智能体不知疲倦地在 41 款以上计划游戏的待办列表中迭代，交替进行新内容创建和过往问题的修正。

当流程畅通时，智能体将执行：
1.  **选择**：基于"轮询"策略从队列（`development-queue.md`）中识别下一款游戏，以平衡各年龄段的内容分布。
2.  **实现**：按照严格的 `game-design-rules.md` 规范编写 HTML5/CSS3/JS 代码（无框架、移动端优先、支持离线）。
3.  **注册**：自动将游戏元数据添加到中央注册表（`games-list.json`）。
4.  **文档化**：更新 `CHANGELOG.md` 和 `master-game-plan.md` 的状态。
5.  **部署**：处理 Git 工作流：拉取主分支、创建功能分支、使用约定式提交提交更改，并合并回主分支。

## 提示词

本工作流的核心是赋予智能体的**系统指令**。该提示词将大语言模型转变为一名称职的开发者，严格遵守项目的严谨结构。

*（**注：** 生产环境中使用的实际提示词为**西班牙语**（`es-419`），以契合项目目标受众（拉美儿童）及该地区潜在的未来贡献者。以下版本为文档翻译版。）*

```text
Act as an Expert in Web Game Development and Child UX.
Your goal is to develop the next game in the production queue.

Please read and analyze the following context files before starting:

1.  BUG CONTEXT (Top Priority - CRITICAL):
    @[bugs/]
    (Check this folder. If there are files, YOUR TASK IS TO FIX **ONLY THE FIRST FILE** (in alphabetical order). Ignore the rest of the bugs and the game queue for now).

2.  QUEUE CONTEXT (Which game is next):
    @[development-queue.md]
    (Identify the game marked as [NEXT] in the "Next Games" section. ONLY if there are no bugs).

3.  DESIGN RULES (Technical Standards):
    @[game-design-rules.md]
    (Strictly follow these rules: Pure HTML/CSS/JS, folder structure, mobile responsiveness)

4.  GAME SPECIFICATIONS (Mechanics and Assets):
    (Identify the corresponding file in games-backlog/ based on the game ID)

5.  CENTRAL REGISTRY (Integration):
    @[public/js/games-list.json]
    (File where you MUST register the new game so it appears on the home page)

TASK:
0. **BUGS FIRST!**: If the `bugs/` folder has content, your only priority is to fix **the first bug in alphabetical order**. Create a `fix/...` branch, resolve **that** bug, update status, and merge. **Do not attempt to fix multiple bugs at once.**
   - IF THERE ARE NO BUGS, proceed with the next game:

1. **Synchronization**: `git fetch && git pull origin master` (CRITICAL).
2. Create a new branch: `git checkout -b feature/[game-id]`.
3. Create the folder and files in 'public/games/[game-id]/'.
4. Implement logic and design according to the backlog and design rules.
5. Register the game in 'games-list.json' (CRITICAL).
6. When finished:
    - Update `CHANGELOG.md` bumping the version.
    - Update `master-game-plan.md` and `development-queue.md`.
    - Document changes: `git commit -m "feat: add [game-id]"`.
7. **Delivery**:
    - Push: `git push origin feature/[game-id]`.
    - Request merge to master.
    - Once in master, push changes (`git push origin master`).
```

## 所需技能
-   **Git**：用于管理分支、提交和合并。

## 相关链接
-   [项目起源故事（LinkedIn）](https://www.linkedin.com/feed/update/urn:li:activity:7429739200301772800/) — 配置 OpenClaw 后这个项目是如何诞生的
-   [El Bebe Games 代码仓库](https://github.com/duberblockito/elbebe/tree/master) — 源代码
-   [El Bebe Games 在线站点](https://elbebe.co/) — 该流水线的成果展示
-   [HTML5 游戏开发最佳实践](https://developer.mozilla.org/en-US/docs/Games)
