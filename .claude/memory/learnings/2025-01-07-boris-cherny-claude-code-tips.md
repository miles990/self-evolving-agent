---
date: "2025-01-07"
tags: [claude-code, best-practices, boris-cherny, workflow, subagents, verification]
task: 研究 Claude Code 創作者的使用技巧
status: resolved
source: https://www.threads.com/@boris_cherny/post/DTBVlMIkpcm
---

# Boris Cherny 的 Claude Code 使用技巧

## 情境
Boris Cherny 是 Claude Code 的創作者，他分享了 13 條個人使用技巧。

## 核心洞察

### 最重要的一條（Tip #13）
**給 Claude 驗證工作的方式，能提升 2-3 倍品質**

Boris 使用 Chrome extension 讓 Claude 測試 UI，開啟瀏覽器、測試、迭代直到成功。

### 平行化策略（Tips #1, #2）
- 本地跑 5 個 Claude（終端分頁 1-5）
- 雲端 claude.ai/code 另外跑 5-10 個
- 每個專注不同任務

### 團隊協作（Tips #4, #5）
- 單一 CLAUDE.md 存入 git，每週更新
- PR 上 @.claude tag 自動更新（GitHub Action）

### 工作流程優化
| 技巧 | 說明 |
|------|------|
| Plan mode | shift+tab 兩次起手，然後 auto-accept |
| Slash commands | /commit-push-pr 等內部工作流程 |
| Subagents | code-simplifier, verify-app, build-validator |
| PostToolUse hook | 自動格式化程式碼 |

### 長時間任務處理（Tip #12）
- Stop hook 驗證 background agent 工作
- ralph-wiggum plugin 做確定性處理
- --permission-mode=dontAsk 或 sandbox 避免阻塞

### MCP 整合（Tip #11）
```json
{
  "mcpServers": {
    "slack": {
      "type": "http",
      "url": "https://slack.mcp.anthropic.com/mcp"
    }
  }
}
```
整合 Slack, BigQuery, Sentry 等工具。

## 對 self-evolving-agent 的改進建議

1. **強化驗證迴圈**
   - PDCA Check 階段加入自動測試執行
   - 整合 verify-app 概念

2. **Subagents 策略池**
   - 加入 code-simplifier 策略
   - 加入 build-validator 策略

3. **Hooks 整合**
   - PostToolUse hook 自動格式化
   - Stop hook 處理長時間進化任務

4. **ralph-wiggum 整合**
   - 長時間任務使用 ralph-wiggum loop

## 驗證
✅ 已記錄完整 13 條技巧
✅ 提出具體改進建議

## 相關檔案
- `SKILL.md` - self-evolving-agent 技能定義
- `.claude/memory/strategies/` - 策略記錄
