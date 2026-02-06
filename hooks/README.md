# Hooks 配置說明

本專案有兩種 hooks 機制，服務不同場景：

## 1. Claude Code Plugin Hooks（本目錄）

位置：`hooks/*.json` + `hooks/*.sh`

用於 Claude Code Plugin 自動載入，透過 `additionalContext` 提供提醒。

| 檔案 | 觸發時機 | 功能 |
|------|----------|------|
| `checkpoint-reminder.json` | Edit/Write | 提醒 CP1.5、CP2 檢查點 |
| `memory-sync.json` | Write to .claude/memory/ | 提醒 CP3.5 同步 index.md |
| `build-verify.json` | Edit/Write 代碼文件 | 自動偵測代碼變更，提醒執行編譯+測試驗證 |

### build-verify Hook 詳細說明

`build-verify.sh` 會根據修改的檔案副檔名智能判斷是否需要提醒驗證：

- **觸發提醒的副檔名**: `.ts`, `.tsx`, `.js`, `.jsx`, `.py`, `.go`, `.rs`, `.sh`
- **靜默通過的副檔名**: `.md`, `.yaml`, `.yml`, `.json`, `.txt`
- **無檔案路徑時**: 靜默通過

提醒內容包含修改的檔案名稱和建議的驗證命令（如 `pnpm typecheck && pnpm test`）。

## 2. evolve-hooks.sh（scripts 目錄）

位置：`scripts/evolve-hooks.sh`

更完整的提醒腳本，包含：
- TDD 流程提醒
- Memory 同步提醒
- 版本發布檢查
- 彩色輸出格式

### 手動配置方式

在 `~/.claude/settings.json` 中添加：

```json
{
  "hooks": {
    "PostToolUse": [
      {
        "matcher": "Edit|Write",
        "hooks": [
          {
            "type": "command",
            "command": "/path/to/scripts/evolve-hooks.sh post $TOOL_NAME $EXIT_CODE $FILE_PATH"
          }
        ]
      }
    ]
  }
}
```

## 選擇建議

- **使用 Plugin**：自動載入 `hooks/` 目錄配置
- **自訂需求**：使用 `scripts/evolve-hooks.sh` 手動配置
