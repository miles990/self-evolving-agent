#!/bin/bash
# build-verify hook - 編輯 TypeScript/代碼文件後自動提醒 CP2 驗證
# 觸發條件：PostToolUse (Edit/Write)

set -euo pipefail

# 從 stdin 讀取 hook 輸入
INPUT=$(cat)

# 取得修改的檔案路徑
FILE=$(echo "$INPUT" | grep -o '"file_path":"[^"]*"' | head -1 | cut -d'"' -f4 || true)

# 沒有檔案路徑則直接通過
if [[ -z "$FILE" ]]; then
  echo '{"decision":"approve"}'
  exit 0
fi

# 根據副檔名判斷是否為代碼文件
case "$FILE" in
  *.md|*.yaml|*.yml|*.json|*.txt)
    # 非代碼文件，靜默通過
    echo '{"decision":"approve"}'
    exit 0
    ;;
  *.ts|*.tsx|*.js|*.jsx|*.py|*.go|*.rs|*.sh)
    # 代碼文件，提醒驗證
    echo '{"decision":"approve","additionalContext":"⚠️ CP2 自動提醒：代碼文件已修改 ('"$FILE"')，記得在此輪修改完成後執行編譯+測試驗證。\n建議命令：pnpm typecheck && pnpm test（TypeScript）或相應的建置命令"}'
    exit 0
    ;;
  *)
    # 其他文件類型，靜默通過
    echo '{"decision":"approve"}'
    exit 0
    ;;
esac
