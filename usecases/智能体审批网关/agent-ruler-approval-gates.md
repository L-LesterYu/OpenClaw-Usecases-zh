---
title: 'Agent Ruler for OpenClaw：审批网关与审计凭证，构建更安全的智能体工作流'
slug: agent-ruler-approval-gates
summary: 在OpenClaw外围添加确定性策略执行、审批网关和审计凭证，让本地智能体以更小的爆炸半径和更清晰的操作可见性安全运行。
whatItDoes: 在Agent Ruler后运行OpenClaw，隔离工作区操作，对高风险边界越界行为设置审批网关，并在本地控制面板中展示审批记录和凭证。
category: operations
difficulty: advanced
tags:
  - approval-gates
  - audit-trail
  - security-governance
  - telegram-bridge
  - prompt-injection-defense
targetUser:
  - 平台工程师
  - SRE 团队
  - 自托管运维人员
skillsUsed:
  - name: Agent Ruler
    href: https://github.com/steadeepanda/agent-ruler
updatedAt: '2026-03-22'
published: true
---

## 功能说明
- 将OpenClaw置于确定性引用监控器和隔离运行器之后，而非依赖模型判断来执行策略。
- 将工作划分为工作区、共享区、系统关键区和密钥区等区域，以减少意外损坏。
- 为高风险边界越界行为添加审批网关，包括网络访问、导出或投递操作、权限提升和敏感写入。
- 在本地控制面板中展示审批记录、凭证、策略视图和运行时状态，并提供可选的Telegram桥接用于审批流程。
- 让运维人员保持网关本地优先的同时，无需实时监控每一步即可审查重要操作。

## 所需技能
- [Agent Ruler](https://github.com/steadeepanda/agent-ruler)

## 痛点
OpenClaw在能够操作真实文件、工具和外部服务时最为实用，但这种能力也放大了提示注入、错误工具选择和无人值守自动化的爆炸半径。缺乏外部控制层时，运维人员往往只能在弱自主性和弱安全性之间做出选择。

## 核心价值
本方案在OpenClaw外围添加治理层，而不会将每个任务都变成手动看护。正常的工作区操作保持高效，而高风险操作则变得显式化、可审查和可审计。结果是为本地智能体工作流打造了一个更适合生产环境的配置方案。

## 典型场景
- 在个人工作站或家庭服务器上运行OpenClaw，附近存放着敏感文件和账户信息。
- 保持以Telegram为主的运营模式，同时将高风险审批通过受控界面回传处理。
- 允许长时间运行的自动化在工作区中准备文件，然后对向真实目标的投递或导出设置审批网关。
- 运行多个本地智能体运行器，但希望使用统一的边界模型和审批工作流。

## 如何设置
1. 准备一台已安装 `bubblewrap` 的Linux主机，并确保在Agent Ruler之外已有可正常工作的OpenClaw配置。
2. 从最新版本安装Agent Ruler，然后运行 `agent-ruler init` 创建其管理工作区。
3. 运行 `agent-ruler setup` 并导入或配置OpenClaw运行器的连接。
4. 通过Agent Ruler启动OpenClaw：`agent-ruler run -- openclaw gateway`。
5. 打开终端中打印的URL访问本地控制面板。文档中的默认回退地址为 `http://127.0.0.1:4622`。
6. 默认保持网关仅限本地访问，然后在设置过程中可选择启用Telegram或Tailscale辅助的远程访问。

## 相关链接
- [Agent Ruler (GitHub)](https://github.com/steadeepanda/agent-ruler)
- [Agent Ruler：关于本项目](https://github.com/steadeepanda/agent-ruler/blob/master/about-this-project.md)
- [Show HN：面向AI智能体的确定性安全方案 – OpenClaw 等](https://news.ycombinator.com/item?id=47466968)

## 常见问题
### 这会替代OpenClaw自带的沙箱功能吗？
不会。它在运行器外围添加了一个外部治理层。该项目明确将自己定位为降低损害，而非提供完美保证。

### 是否每个智能体操作都需要审批？
不需要。文档中的模式是正常工作区操作保持高效，而高风险边界越界行为则根据策略设置为 `allow`、`deny` 或 `pending_approval`。

### 必须使用Telegram吗？
不需要。标准的运维操作界面是本地控制面板。Telegram仅作为审批和频道工作流的可选功能。
