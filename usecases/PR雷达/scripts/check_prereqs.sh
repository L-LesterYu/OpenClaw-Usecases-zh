#!/usr/bin/env bash
set -euo pipefail

for cmd in openclaw gh jq; do
  command -v "$cmd" >/dev/null 2>&1 || { echo "缺少命令: $cmd"; exit 1; }
done

gh auth status >/dev/null 2>&1 || { echo "gh 未认证"; exit 1; }

echo "前置条件检查通过"
