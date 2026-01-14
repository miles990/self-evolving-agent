# Claude Code Hooks 整合

> 使用 Hooks 自動化觸發驗證和記錄

## Hook 類型

| Hook | 時機 | 用途 |
|------|------|------|
| **PreToolUse** | 工具執行前 | 版本偵測、前置檢查 |
| **PostToolUse** | 工具執行後 | 自動格式化、驗證 |
| **Stop** | 會話結束時 | 提醒記錄學習 |

## 配置方式

在 `.claude/settings.local.json` 配置：

```json
{
  "hooks": {
    "PostToolUse": [
      {
        "matcher": "Edit|Write",
        "command": "echo '📝 File modified - remember to verify changes'"
      }
    ],
    "Stop": [
      {
        "command": "echo '💡 Session ended - consider recording learnings to .claude/memory/'"
      }
    ]
  }
}
```

## PostToolUse Hook

### 自動格式化

```json
{
  "hooks": {
    "PostToolUse": [
      {
        "matcher": "Edit|Write",
        "command": "npx prettier --write $FILE"
      }
    ]
  }
}
```

### Lint 檢查

```json
{
  "hooks": {
    "PostToolUse": [
      {
        "matcher": "Edit|Write",
        "command": "npx eslint $FILE --fix"
      }
    ]
  }
}
```

## Stop Hook

### 完成驗證

```json
{
  "hooks": {
    "Stop": [
      {
        "command": "npm test && npm run build"
      }
    ]
  }
}
```

### 學習提醒

```json
{
  "hooks": {
    "Stop": [
      {
        "command": "echo '💡 記得將本次學習記錄到 .claude/memory/'"
      }
    ]
  }
}
```

## evolve 建議的 Hooks 配置

```json
{
  "hooks": {
    "PostToolUse": [
      {
        "matcher": "Edit|Write",
        "command": "echo '📝 File modified'"
      },
      {
        "matcher": "Bash",
        "condition": "exit_code != 0",
        "command": "echo '⚠️ Command failed - classify error type'"
      }
    ],
    "Stop": [
      {
        "command": "echo '💡 Session ended - record learnings to .claude/memory/'"
      }
    ]
  }
}
```

## Boris Tip 整合

### Tip #9: PostToolUse 自動格式化

> 讓 Claude 專注於邏輯，格式化交給工具

```json
{
  "hooks": {
    "PostToolUse": [
      {
        "matcher": "Edit|Write",
        "command": "npx prettier --write $FILE && npx eslint $FILE --fix"
      }
    ]
  }
}
```

### Tip #12: Stop Hook 完成驗證

> 確保長時間任務完成時驗證結果

```json
{
  "hooks": {
    "Stop": [
      {
        "command": "npm test && npm run build && echo '✅ All checks passed'"
      }
    ]
  }
}
```

## 注意事項

1. **Hook 命令要快** - 避免阻塞
2. **錯誤處理** - Hook 失敗不應阻止繼續
3. **環境依賴** - 確保命令在專案目錄可執行
