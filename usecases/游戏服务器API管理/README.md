# 通过API管理游戏服务器

为你的社区运行多人游戏服务器意味着要面对托管面板、配置文件、模组安装和重启——全都通过为人类设计的网页UI来完成。如果你跨多个游戏管理服务器，操作摩擦会成倍增加。

这个用例将 OpenClaw 连接到游戏服务器托管 API，让你的智能体通过自然对话来订购、配置、启动、停止和监控专属游戏服务器。

## 痛点

通过传统托管面板管理游戏服务器涉及：

- 在网页面板中导航只为修改一个配置值（最大玩家数、难度、模组）
- 手动检查服务器是否在线、有多少玩家连接、或者是否崩溃了
- 为每个游戏切换不同的托管服务商或面板
- 重启服务器、更新设置或查看日志需要多次点击和页面加载
- 无法自动化周期性任务，比如"每天早上6点重启 Valheim 服务器"或"每周五更换 Rust 地图"

## 功能

- **订购服务器**：通过聊天选择套餐、区域和游戏，购买和部署新的专属游戏服务器
- **生命周期控制**：一条消息即可启动、停止和重启服务器
- **配置管理**：读取和更新服务器设置（最大玩家数、难度、密码、模组），无需接触网页面板
- **状态监控**：按需查看服务器状态、玩家数量和连接信息
- **控制台访问**：直接向运行中的游戏服务器发送 RCON / 控制台命令
- **日志检查**：拉取最近的服务器日志以诊断崩溃或问题
- **多游戏支持**：相同的 API 模式适用于 17+ 款游戏——Valheim、Palworld、Rust、ARK、Factorio 等

## 支持的游戏

ARK: Survival Ascended、Counter-Strike 2、Enshrouded、Factorio、HumanitZ、Hytale、Necesse、Palworld、Project Zomboid、Rust、Satisfactory、Sons of the Forest、Terraria、Unturned、V Rising、Valheim 和 Vintage Story。

## 所需技能

- HTTP 请求（`fetch` / `curl`）调用 REST API
- 一个 [Supercraft](https://supercraft.host) 托管账号

无需自定义 MCP 服务器——该 API 是标准 REST 端点，任何智能体都可以调用。

## 设置方法

### 1. 获取 API 访问权限

在 [supercraft.host](https://supercraft.host) 注册并获取你的 API 凭据。API 文档位于 [claws.supercraft.host](https://claws.supercraft.host/documentation-for-agents/getting-started.md)，包含每款游戏的指南（例如 [Valheim 服务器 API](https://claws.supercraft.host/valheim-server-api)）。

### 2. 智能体配置

将以下内容添加到你的 `AGENTS.md`：

```text
## 游戏服务器管理

我可以通过 Supercraft API 管理专属游戏服务器。

API 基础地址：https://claws.supercraft.host
认证方式：Bearer token（JWT）——通过登录链接或购买流程获取
安全要求：切勿将 token 粘贴到 AGENTS.md 或提交到 git。
  在运行时从环境变量或密钥管理器加载 token。

可用操作：
- 列出我的服务器：GET /servers
- 服务器详情与状态：GET /servers/{id}
- 启动/停止/重启：POST /servers/{id}/start|stop|restart
- 查看配置：GET /servers/{id}/config
- 更新配置：PUT /servers/{id}/config
- 连接信息：GET /servers/{id}/connection
- 发送控制台命令：POST /servers/{id}/console
- 查看日志：GET /servers/{id}/logs
- 浏览可用游戏：GET /catalog/games
- 购买服务器（无需认证）：POST /orders/purchase
- 购买/登录后领取 token：GET /auth/claim?magic=...

当用户询问游戏服务器时：
1. 列出服务器以找到正确的那一个
2. 执行操作前检查状态
3. 执行破坏性操作（重启、配置变更）前进行确认

关键——购买与登录流程顺序：
当生成 checkout_url 或 login_url 时，你必须在调用任何工具（curl、exec、cron）
之前将链接作为消息发送给用户。如果你先调用工具，包含链接的消息会被阻塞，
用户将永远看不到。正确顺序：
1. 先回复用户，包含 checkout_url / login_url
2. 回复之后，设置一个 cron（每30秒）轮询 GET /auth/claim?magic=...
3. 当 claim 返回 status:"ready" 时，安全保存 JWT token
切勿使用 while/sleep 循环——请使用 cron 任务代替。
```

### 3. 示例对话

**检查服务器状态：**
> "我的 Valheim 服务器在运行吗？"

智能体调用 `GET /servers`，找到 Valheim 部署，调用 `GET /servers/{id}` 获取实时状态，并回复：

> "你的 Valheim 服务器在线，3/10 名玩家已连接。已运行 14 小时。"

**修改设置：**
> "把我的 Palworld 服务器最大玩家数设为 20"

智能体获取当前配置，更新 `max_players` 字段并应用：

> "已完成——最大玩家数已更新为 20。服务器需要重启才能生效。要我重启吗？"

**订购新服务器：**
> "我想和朋友一起开一个 Factorio 服务器，要便宜的"

智能体检查 `GET /catalog/games/fac`，显示可用套餐和定价，确认后调用 `POST /orders/purchase`。然后立即回复 `checkout_url` 以便用户完成支付。发送链接后，设置 cron 每 30 秒轮询 `/auth/claim` 直到支付确认。

**调试崩溃：**
> "我的 Rust 服务器好像挂了，看看怎么回事"

智能体检查状态（已停止），通过 `GET /servers/{id}/logs` 拉取最近日志，识别错误，并提议重启。

## 核心要点

- **REST API = 无需 MCP**：API 使用标准 HTTP + JWT 认证，任何具备 `fetch` 或 `curl` 的智能体都能使用——无需安装自定义技能
- **每款游戏都有独立 API 指南**：每款游戏都有专门的指南（如 `/valheim-server-api`），包含真实的产品 ID 和定价，智能体可以做出准确的购买推荐
- **配置感知游戏类型**：配置模式端点返回针对每款游戏的字段定义（类型、范围、默认值），智能体知道哪些值是有效的
- **控制台命令实现深度控制**：RCON 访问让智能体可以执行游戏内命令——封禁玩家、更改天气、广播消息——而不仅仅是管理托管层

## 相关链接

- [Supercraft 游戏服务器托管](https://supercraft.host)
- [API 入门指南](https://claws.supercraft.host/documentation-for-agents/getting-started.md)
- [API 参考（OpenAPI）](https://claws.supercraft.host/docs)
- [机器可读发现文档](https://supercraft.host/llms.txt)
