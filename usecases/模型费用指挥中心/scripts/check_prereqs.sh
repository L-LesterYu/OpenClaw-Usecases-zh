#!/usr/bin/env bash
set -euo pipefail

command -v openclaw >/dev/null 2>&1 || { echo "缺少命令: openclaw"; exit 1; }

echo "前置条件检查通过"
