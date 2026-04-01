# WordPress B2B 外贸站点部署

国际贸易公司（制造商、出口商、贸易公司）需要专业网站来触达海外买家。但大多数公司缺乏技术人员——他们要么依赖昂贵的外包公司，要么在服务器、SSL、CDN、多语言内容和 SEO 等环节的 WordPress 手动搭建中苦苦挣扎。一个典型的网站往往需要数天甚至数周的反复沟通。

本用例将 OpenClaw 化身为部署代理，通过交互式采集业务需求、配置服务器，在 40 分钟内部署一个完整配置的 WordPress 站点——涵盖 Docker 编排、三层缓存、多语言支持和安全加固。

## 痛点

- 非技术背景的企业主无法正确部署 WordPress（SSL、反向代理、缓存、安全）
- 委托建站公司费用高达 2,000–10,000 美元，且耗时数周
- 通用 WordPress 模板缺乏 B2B 外贸核心要素：多语言页面、WhatsApp 集成、无需 WooCommerce 开销的产品目录
- 手动配置服务器容易出错——遗漏防火墙规则、低内存 VPS 未配置 swap、忘记 SSL 续期、缓存层未优化
- 性能直接影响 SEO：加载慢意味着在 Google 搜索中流失潜在买家

## 功能概览

- **交互式需求采集**：在接触任何服务器之前，先收集公司名称、产品、目标市场、语言和联系方式
- **服务器配置**：SSH 登录全新 VPS，配置防火墙/swap/时区，安装 Docker
- **模板部署**：克隆经过实战验证的 Docker Compose 技术栈（WordPress 6.7 + MySQL 8 + Nginx Alpine），并根据用户输入生成环境配置
- **SSL 自动化**：Let's Encrypt 自动续期 cron，或 Cloudflare Origin 证书——由用户选择
- **插件栈安装**：通过 WP-CLI 批量安装 9 款精选插件（Astra、Elementor、Rank Math、WP Super Cache、Imagify、Polylang、Jetpack Boost、Contact Form 7、Chaty）
- **多语言配置**：根据第 1 步确定的目标市场配置 Polylang 语言
- **SEO 配置**：Rank Math 设置，包含公司结构化数据、XML 站点地图、Open Graph
- **三层缓存**：WP Super Cache（应用层）+ Nginx 代理缓存（服务层）+ Cloudflare CDN（边缘层）——通过 curl 响应头验证
- **安全加固**：文件权限锁定、xmlrpc.php 屏蔽、自动化数据库备份、UptimeRobot 监控
- **最终验证**：执行 10 项检查清单，输出包含所有访问地址的汇总报告

## 前置条件

- Linux 服务器的 SSH 访问权限（推荐 Ubuntu 22.04+）
- 域名及 DNS 管理权限
- （可选）Cloudflare 账户，用于 CDN
- （可选）Imagify API 密钥，用于图片优化

无需从 ClawHub 安装任何 OpenClaw 技能——代理按照 SKILL.md 说明直接通过 SSH 执行 Shell 命令。

## 如何开始

### 1. 安装技能

```bash
clawhub install wordpress-trade-site
```

或直接克隆模板仓库：

```bash
git clone https://github.com/iPythoning/wordpress-trade-starter.git
```

### 2. 开始对话

告诉你的 OpenClaw 代理：

> "Help me deploy a WordPress site for my trade company"

代理将启动第一阶段（业务信息采集），并引导你完成全部 9 个阶段的交互式流程。

### 3. 需要准备的材料

- 服务器 IP 和 SSH 凭据（或购买 VPS 的预算——代理会根据你的目标市场推荐服务商）
- 你的域名
- 业务信息：公司名称、产品、目标市场、联系方式
- 约 40 分钟的交互式配置时间

### 4. 架构

部署后的技术栈如下：

```
Cloudflare (CDN + WAF)
    ↓
Nginx (Reverse Proxy + Gzip + Proxy Cache)
    ↓
WordPress 6.7 (Apache + WP Super Cache + Plugins)
    ↓
MySQL 8 (Persistent Volume)
```

所有服务运行在 Docker 容器中，支持自动重启和健康检查。

## 核心要点

- **先业务，后技术**：在服务器配置之前先收集公司信息、目标市场和语言，确保每一项技术决策（数据中心位置、语言包、SEO 结构化数据）都基于实际业务需求。这正是建站公司做的事情——也是大多数"一键部署"脚本忽略的环节。
- **三层缓存才是真正的性能利器**：大多数 WordPress 优化指南仅关注插件缓存。叠加 WP Super Cache + Nginx 代理缓存 + Cloudflare CDN，在每月 10 美元的 VPS 上将 TTFB 从 1.8 秒降至 0.3 秒。代理会配置并验证全部三层。
- **WP-CLI 让代理更强大**：没有 WP-CLI，WordPress 配置需要浏览器交互。有了它，代理可以通过 SSH 命令安装插件、创建页面、构建菜单、配置设置——这才使得全自动化流程成为可能。
- **xmlrpc.php 是真实威胁**：外贸站点所有者不会考虑 WordPress 安全问题。代理默认屏蔽 xmlrpc.php、锁定文件权限并设置自动化备份——安全不应该是可选的。

## 灵感来源

基于 [TitanPuls.com](https://titanpuls.com) 的实际部署经验构建，这是一家服务于 50 多个国家的半挂车制造商。模板和 11 篇文档从生产站点中提炼，打包为 [wordpress-trade-starter](https://github.com/iPythoning/wordpress-trade-starter)——随后封装为交互式 OpenClaw 技能。

## 相关链接

- [wordpress-trade-starter (GitHub)](https://github.com/iPythoning/wordpress-trade-starter) — Docker 模板 + 11 篇文档
- [wordpress-trade-site (ClawHub)](https://clawhub.ai/ipythoning/wordpress-trade-site) — OpenClaw 交互式部署技能
- [WordPress WP-CLI Documentation](https://developer.wordpress.org/cli/commands/)
- [Cloudflare Free Plan](https://www.cloudflare.com/plans/free/) — 免费使用 CDN + WAF
