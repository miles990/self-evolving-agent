#!/bin/bash
# evolve-hooks.sh - evolve 強制執行提醒腳本
# 用於 Claude Code Hooks 配置

set -e

HOOK_TYPE="${1:-}"
TOOL_NAME="${2:-}"
EXIT_CODE="${3:-0}"
FILE_PATH="${4:-}"

# 顏色定義
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

# 圖標
ICON_WARN="⚠️"
ICON_CHECK="✅"
ICON_STOP="🛑"
ICON_TIP="💡"
ICON_STAR="🌟"
ICON_DEBUG="🔧"
ICON_TEST="🧪"
ICON_MEMORY="📝"

# ====================
# PostToolUse Hooks
# ====================

post_edit_write() {
    local file="$1"

    # 檢查是否為程式碼文件
    if [[ "$file" =~ \.(ts|js|tsx|jsx|py|go|rs|java|cpp|c|swift|kt)$ ]]; then
        echo -e "${YELLOW}${ICON_TEST} [superpowers:TDD] 確認是否遵守 TDD 流程：${NC}"
        echo -e "   ${CYAN}1. 先寫測試（RED）→ 2. 看失敗 → 3. 寫實作（GREEN） → 4. 看通過${NC}"
        echo -e "   ${RED}鐵律: NO PRODUCTION CODE WITHOUT A FAILING TEST FIRST${NC}"
        echo ""
    fi

    # 檢查是否為 Memory 文件
    if [[ "$file" =~ \.claude/memory/ ]]; then
        echo -e "${BLUE}${ICON_MEMORY} [CP3.5] Memory 文件已變更 - 記得同步 index.md！${NC}"
        echo -e "   ${CYAN}執行: Edit .claude/memory/index.md 新增條目${NC}"
        echo ""
    fi
}

post_bash_failed() {
    local exit_code="$1"

    if [[ "$exit_code" != "0" ]]; then
        echo -e "${RED}${ICON_DEBUG} [superpowers:systematic-debugging] 命令失敗！${NC}"
        echo -e "   ${YELLOW}鐵律: NO FIXES WITHOUT ROOT CAUSE INVESTIGATION FIRST${NC}"
        echo ""
        echo -e "   ${CYAN}四階段流程：${NC}"
        echo -e "   1. 根因調查 - 仔細閱讀錯誤訊息、重現問題"
        echo -e "   2. 模式分析 - 找運作中的類似程式碼比較"
        echo -e "   3. 假設測試 - 形成假設、最小化測試"
        echo -e "   4. 實作修復 - 建立失敗測試案例、單一修復"
        echo ""
        echo -e "   ${RED}禁止：「試著改改看」「先快速修復」「同時改多處」${NC}"
        echo ""
    fi
}

post_bash_test() {
    local exit_code="$1"

    if [[ "$exit_code" == "0" ]]; then
        echo -e "${GREEN}${ICON_CHECK} [superpowers:verification] 測試通過${NC}"
    else
        echo -e "${RED}${ICON_STOP} [superpowers:verification] 測試失敗 - 不可宣告完成！${NC}"
        echo -e "   ${YELLOW}鐵律: NO COMPLETION CLAIMS WITHOUT FRESH VERIFICATION EVIDENCE${NC}"
        echo ""
    fi
}

# ====================
# PreToolUse Hooks
# ====================

pre_task_start() {
    echo -e "${STAR}${ICON_STAR} [CP0] 北極星檢查${NC}"

    if [[ -d ".claude/memory/north-star" ]]; then
        echo -e "   ${GREEN}${ICON_CHECK} 北極星文件存在${NC}"
    else
        echo -e "   ${YELLOW}${ICON_WARN} 建議先執行北極星錨定${NC}"
    fi

    echo -e "${BLUE}${ICON_TIP} [CP1] 記得搜尋 Memory 和相關 Skill${NC}"
    echo ""
}

pre_code_write() {
    echo -e "${YELLOW}${ICON_WARN} [CP1.5] 寫程式碼前檢查：${NC}"
    echo -e "   ${CYAN}Phase 1: 搜尋現有實作、檢查專案慣例${NC}"
    echo -e "   ${CYAN}Phase 2: 依賴方向、錯誤處理一致性（自動偵測觸發）${NC}"
    echo ""
    echo -e "${YELLOW}${ICON_TEST} [superpowers:TDD] 記得先寫測試！${NC}"
    echo ""
}

# ====================
# Stop Hooks
# ====================

stop_verification_reminder() {
    echo -e "${YELLOW}${ICON_CHECK} [superpowers:verification-before-completion]${NC}"
    echo -e "   ${CYAN}完成前確認：${NC}"
    echo -e "   ${CYAN}[ ] 測試命令已執行且通過${NC}"
    echo -e "   ${CYAN}[ ] Build 命令已執行且成功${NC}"
    echo -e "   ${CYAN}[ ] 所有 lint 警告已處理${NC}"
    echo ""
    echo -e "   ${RED}禁止用語: should work / probably fixed / looks correct${NC}"
    echo ""
}

stop_memory_reminder() {
    echo -e "${BLUE}${ICON_MEMORY} [CP3.5] 記得記錄學習經驗到 .claude/memory/${NC}"
    echo -e "   ${CYAN}• learnings/ - 解決方案、最佳實踐${NC}"
    echo -e "   ${CYAN}• failures/ - 失敗經驗、踩坑記錄${NC}"
    echo -e "   ${CYAN}• decisions/ - 架構決策 (ADR)${NC}"
    echo ""
}

# ====================
# 主邏輯
# ====================

case "$HOOK_TYPE" in
    "post-edit-write")
        post_edit_write "$FILE_PATH"
        ;;
    "post-bash-failed")
        post_bash_failed "$EXIT_CODE"
        ;;
    "post-bash-test")
        post_bash_test "$EXIT_CODE"
        ;;
    "pre-task-start")
        pre_task_start
        ;;
    "pre-code-write")
        pre_code_write
        ;;
    "stop-verification")
        stop_verification_reminder
        ;;
    "stop-memory")
        stop_memory_reminder
        ;;
    *)
        echo "Usage: evolve-hooks.sh <hook-type> [tool-name] [exit-code] [file-path]"
        echo ""
        echo "Hook types:"
        echo "  post-edit-write     - After Edit/Write tool"
        echo "  post-bash-failed    - After Bash command fails"
        echo "  post-bash-test      - After test command"
        echo "  pre-task-start      - Before starting a task"
        echo "  pre-code-write      - Before writing code"
        echo "  stop-verification   - Before claiming completion"
        echo "  stop-memory         - Session end reminder"
        ;;
esac
