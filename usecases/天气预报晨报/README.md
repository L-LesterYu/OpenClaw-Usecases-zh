# 天气预报晨报

## 简介

每天早上 9:00（当地时间）通过 Telegram 自动发送天气预报。根据坐标获取天气信息，解析 4 个时段（早晨/白天/傍晚/夜间）的预报，将天气状况代码翻译为本地语言，并发送包含温度、体感温度、湿度和风速的格式化消息。

**核心价值**：无需手动查看天气应用，在一天开始前主动推送天气信息。

**实际案例**：俄罗斯萨拉托夫 — 每天根据 51.53, 46.03 坐标推送天气预报，输出俄语。

## 所需技能

| 技能 | 来源 | 用途 |
|------|------|------|
| `weather` | 内置 | 获取天气预报数据 |
| `telegram` | 内置 | 发送天气报告 |
| `cron` | 内置 | 每日自动化 |

## 配置方法

### 1. 获取 API Key

```
1. 访问 https://yandex.ru/pogoda/b2b/smarthome
2. 注册获取免费 API Key（每日 50 次请求）
3. 将 Key 保存到环境变量：YANDEX_WEATHER_API_KEY
```

### 2. 配置位置

```javascript
const CONFIG = {
  lat: 51.53,      // 纬度
  lon: 46.03,      // 经度
  lang: "ru_RU",   // 输出语言
  timezone: "Europe/Moscow"
};
```

### 3. 创建天气解析器

```javascript
const conditionMap = {
  "clear": "ясно",
  "overcast": "пасмурно",
  "cloudy": "облачно",
  "rain": "дождь",
  "snow": "снег",
  "partly-cloudy": "переменная облачность"
};

function formatWeather(data) {
  const parts = data.forecasts[0].parts;
  return `
🌤️ Погода на сегодня:

🌅 Утро: ${parts.morning.temp_avg}°C (${conditionMap[parts.morning.condition]})
🌞 День: ${parts.day.temp_avg}°C (ощущается ${parts.day.feels_like}°C)
🌆 Вечер: ${parts.evening.temp_avg}°C
🌙 Ночь: ${parts.night.temp_avg}°C

💧 Влажность: ${parts.day.humidity}%
💨 Ветер: ${parts.day.wind_speed} м/с
  `.trim();
}
```

### 4. 提示模板

添加到你的 `SKILL.md`：

```markdown
## 天气预报晨报

每天早上 09:00（当地时间）：
1. 使用配置的坐标从 Yandex API 获取天气数据
2. 解析 4 个时段：早晨、白天、傍晚、夜间
3. 将天气状况代码翻译为本地语言
4. 使用 Emoji 格式化消息
5. 通过 Telegram 发送
6. 将温度记录到 memory/weather-log.md 用于趋势分析

告警条件：
- 气温低于 -15°C
- 风速超过 15 m/s
- 通勤时段预计有降水
```

### 5. Cron 配置

```json
{
  "schedule": "0 9 * * *",
  "timezone": "Europe/Moscow",
  "task": "weather_report",
  "action": "fetch_and_send_weather"
}
```

### 6. Telegram 消息格式

```markdown
🌤️ Погода на {{date}}

🌅 Утро: {{morning_temp}}°C ({{morning_condition}})
🌞 День: {{day_temp}}°C (ощущается {{feels_like}}°C)
🌆 Вечер: {{evening_temp}}°C
🌙 Ночь: {{night_temp}}°C

💧 Влажность: {{humidity}}%
💨 Ветер: {{wind_speed}} м/с

{{#alert}}
⚠️ {{alert_message}}
{{/alert}}
```

## 成功指标

- [ ] 在 09:00 ± 2 分钟内送达
- [ ] 包含全部 4 个时段
- [ ] 极端天气时发送告警
- [ ] 可查看 30 天温度趋势

## API 限制

| 套餐 | 每日请求数 | 费用 |
|------|-----------|------|
| 免费版 | 50 | $0 |
| 标准版 | 1000 | $10/月 |
| 企业版 | 不限 | $50/月 |

---

*示例来源：MyxAI (Moltbook) — "Yandex 天气 API 自动化"*
