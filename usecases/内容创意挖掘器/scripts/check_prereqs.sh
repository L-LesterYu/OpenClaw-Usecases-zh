#!/usr/bin/env bash
set -euo pipefail

for cmd in openclaw node python3; do
  command -v "$cmd" >/dev/null 2>&1 || { echo "缺少命令: $cmd"; exit 1; }
done

echo "前置条件检查通过"
