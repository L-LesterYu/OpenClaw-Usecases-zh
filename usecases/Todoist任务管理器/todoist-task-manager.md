# Todoist 任务管理器：智能体任务可见性
通过将内部推理和进度日志直接同步到 Todoist，让长时间运行的智能体工作流保持最大透明度。

## 痛点
当智能体执行复杂的多步骤任务（如构建全栈应用或进行深度研究）时，用户往往不清楚智能体当前在做什么、哪些步骤已完成、以及可能卡在哪里。对于后台任务，手动查看聊天日志非常繁琐。

## 功能说明
本场景使用 `todoist-task-manager` 技能来：
1.  **可视化状态**：在特定分区中创建任务，如 `🟡 进行中` 或 `🟠 等待中`。
2.  **外化推理**：将智能体的内部"计划"写入任务描述。
3.  **实时流式日志**：将子步骤完成情况以评论形式实时添加到任务中。
4.  **自动对账**：心跳脚本检查停滞任务并通知用户。

## 所需技能
你无需预置技能。只需提示你的 OpenClaw 智能体创建下方**设置指南**中描述的 bash 脚本。由于 OpenClaw 可以管理自己的文件系统并执行 shell 命令，它会在你请求时自动"构建"该技能。

## 详细设置指南

### 1. 配置 Todoist
创建一个项目（例如"OpenClaw 工作区"）并获取其 ID。为不同状态创建分区：
- `🟡 进行中`
- `🟠 等待中`
- `🟢 已完成`

### 2. 实现方式："智能体自建"技能
无需安装技能，你可以让 OpenClaw 为你创建这些脚本。每个脚本负责与 Todoist API 通信的不同部分。

**`scripts/todoist_api.sh`**（核心封装器）：
```bash
#!/bin/bash
# Usage: ./todoist_api.sh <endpoint> <method> [data_json]
ENDPOINT=$1
METHOD=$2
DATA=$3
TOKEN="YOUR_TODOIST_API_TOKEN"

if [ -z "$DATA" ]; then
  curl -s -X "$METHOD" "https://api.todoist.com/rest/v2/$ENDPOINT" \
    -H "Authorization: Bearer $TOKEN"
else
  curl -s -X "$METHOD" "https://api.todoist.com/rest/v2/$ENDPOINT" \
    -H "Authorization: Bearer $TOKEN" \
    -H "Content-Type: application/json" \
    -d "$DATA"
fi
```

**`scripts/sync_task.sh`**（任务与状态管理）：
```bash
#!/bin/bash
# Usage: ./sync_task.sh <task_content> <status> [task_id] [description] [labels_json_array]
CONTENT=$1
STATUS=$2
TASK_ID=$3
DESCRIPTION=$4
LABELS=$5
PROJECT_ID="YOUR_PROJECT_ID"

case $STATUS in
  "In Progress") SECTION_ID="SECTION_ID_PROGRESS" ;;
  "Waiting")     SECTION_ID="SECTION_ID_WAITING" ;;
  "Done")        SECTION_ID="SECTION_ID_DONE" ;;
  *)             SECTION_ID="" ;;
esac

PAYLOAD="{\"content\": \"$CONTENT\""
[ -n "$SECTION_ID" ] && PAYLOAD="$PAYLOAD, \"section_id\": \"$SECTION_ID\""
[ -n "$PROJECT_ID" ] && [ -z "$TASK_ID" ] && PAYLOAD="$PAYLOAD, \"project_id\": \"$PROJECT_ID\""
if [ -n "$DESCRIPTION" ]; then
  ESC_DESC=$(echo "$DESCRIPTION" | sed ':a;N;$!ba;s/\n/\\n/g' | sed 's/"/\\"/g')
  PAYLOAD="$PAYLOAD, \"description\": \"$ESC_DESC\""
fi
[ -n "$LABELS" ] && PAYLOAD="$PAYLOAD, \"labels\": $LABELS"
PAYLOAD="$PAYLOAD}"

if [ -n "$TASK_ID" ]; then
  ./scripts/todoist_api.sh "tasks/$TASK_ID" POST "$PAYLOAD"
else
  ./scripts/todoist_api.sh "tasks" POST "$PAYLOAD"
fi
```

**`scripts/add_comment.sh`**（进度日志）：
```bash
#!/bin/bash
# Usage: ./add_comment.sh <task_id> <comment_text>
TASK_ID=$1
TEXT=$2
ESC_TEXT=$(echo "$TEXT" | sed ':a;N;$!ba;s/\n/\\n/g' | sed 's/"/\\"/g')
PAYLOAD="{\"task_id\": \"$TASK_ID\", \"content\": \"$ESC_TEXT\"}"
./scripts/todoist_api.sh "comments" POST "$PAYLOAD"
```

### 3. 使用提示词
你可以将以下提示词发给智能体，用于**设置**和**使用**该可见性系统：

```text
我希望你为自己构建一个基于 Todoist 的任务可见性系统。

首先，在 'scripts/' 文件夹中创建三个 bash 脚本：
1. todoist_api.sh（Todoist REST API 的 curl 封装器）
2. sync_task.sh（创建或更新任务，带有进行中、等待中和已完成的不同 section_id）
3. add_comment.sh（将进度日志作为评论发布）

使用以下变量进行设置：
- Token: [你的 Todoist API Token]
- Project ID: [你的项目 ID]
- Section IDs: [进行中 ID, 等待中 ID, 已完成 ID]

创建完成后，对于我交给你的每一个复杂任务：
1. 在"进行中"分区创建任务，并在描述中写入你的完整计划。
2. 每完成一个子步骤，调用 add_comment.sh 记录你做了什么。
3. 完成后将任务移动到"已完成"分区。
```

## 相关链接
- [Todoist REST API 文档](https://developer.todoist.com/rest/v2/)
```
