# ✈️ 智能旅行规划师

> 几分钟搞定行程规划，不再耗费数小时。获取真正实用的个性化行程。

---

## 问题所在

规划一次旅行意味着要同时打开十几个浏览器标签页：机票、酒店、景点、餐厅、交通。你花了好几个小时比价，却仍然担心错过了最划算的选择或做出了次优决定。临时的变动更是会让所有计划全部打乱。

---

## 解决方案

OpenClaw 处理整个旅行规划流程：查找航班、推荐符合你偏好的住宿、制定逐日行程，并在计划变更时自动调整。一切都在一次对话中完成。

---

## 设置指南

### 第一步：安装旅行技能

```bash
openclaw skill install flights
openclaw skill install flight-tracker
openclaw skill install weather
openclaw skill install spots  # 用于本地推荐
```

### 第二步：设置个人偏好

创建 `~/openclaw/travel/preferences.md`：

```markdown
# 我的旅行偏好

## 航班
- 偏好航司：[列表]
- 座位偏好：靠窗/靠走道
- 最长中转时间：3 小时
- 预算范围：经济舱，长途飞行愿意升级

## 住宿
- 风格偏好：精品酒店 > 大型连锁
- 必须有：WiFi、工作区、空调
- 最好有：健身房、含早餐
- 避免：青旅、共用浴室

## 活动
- 喜欢：当地美食、步行游览、博物馆、自然风光
- 避免：旅游陷阱、购物中心
- 节奏：中等（不过于疲惫）
- 早起型：是

## 饮食
- 饮食限制：无
- 尝试意愿：愿意尝试当地美食
- 必尝：当地特色菜
```

### 第三步：创建旅行模板

创建 `~/openclaw/travel/trip-template.md`：

```markdown
# 旅行：{destination}
## 日期：{start} - {end}

### 航班
- 去程：
- 返程：

### 住宿
- 酒店：
- 地址：
- 预订确认号：

### 每日行程
#### 第 1 天
- 上午：
- 下午：
- 晚上：
- 晚餐：

### 行李清单
- [ ] 必备物品
- [ ] 证件

### 紧急信息
- 大使馆：
- 当地紧急电话：
```

---

## 所需技能

| 技能 | 用途 |
|------|------|
| `flights` | 航班搜索与预订 |
| `flight-tracker` | 实时航班状态 |
| `weather` | 目的地天气预报 |
| `spots` | 当地地点推荐 |

---

## 示例提示词

**规划行程：**
```
Plan a 5-day trip to Tokyo in April. I like food, temples, and avoiding crowds. Budget: mid-range.
```

**查找航班：**
```
Find the best flights from SFO to London, departing March 15-17, returning March 25. Show me options with price/convenience tradeoffs.
```

**每日行程：**
```
Build a detailed itinerary for day 3 in Barcelona. I'm near the Gothic Quarter and want to see Sagrada Familia.
```

**处理变更：**
```
My flight is delayed 4 hours. What does this mean for my hotel check-in and dinner reservation?
```

---

## 定时计划

```
0 6 * * *      # 早上 6 点 - 即将到来的旅行天气预报更新
0 8 * * *      # 早上 8 点 - 如果今天出行，检查航班状态
0 20 * * 0     # 周日晚上 8 点 - 审查即将到来的旅行计划
```

---

## HEARTBEAT.md 配置

```markdown
## 旅行
- [ ] 今天有需要追踪的航班吗？
- [ ] 即将前往的目的地有天气预警吗？
- [ ] 护照/签证到期提醒？
```

---

## 预期效果

**每次旅行：**
- 节省 3-5 小时的规划时间
- 获得比手动规划更好的行程
- 不会遗漏任何预订或预约

**长期积累：**
- 偏好不断优化，推荐更加精准
- 旅行历史助力未来规划
- 轻松无压力的出行准备
