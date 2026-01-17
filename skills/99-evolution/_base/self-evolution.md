# 自我進化機制

> 讓系統從「會做」進化到「會教自己怎麼做」

## 調整 Evolve Skill 流程

**當用戶說「調整 evolve skill」時，必須遵循以下流程：**

```
┌─────────────────────────────────────────────────────────────────┐
│  Evolve Skill 修改流程（不可跳過）                               │
│                                                                 │
│  1. 🔴 在本地 self-evolving-agent 專案修改                      │
│     - 確認當前目錄是 self-evolving-agent                        │
│     - 直接編輯 skills/ 下的相關檔案                             │
│                                                                 │
│  2. 驗證修改                                                    │
│     - 檢查語法和格式正確                                        │
│     - 確認邏輯一致性                                            │
│                                                                 │
│  3. Commit & Push                                               │
│     - git add <modified files>                                  │
│     - git commit -m "feat/fix/docs: 描述變更"                   │
│     - git push                                                  │
│                                                                 │
│  4. 🟢 從遠端更新（在其他使用專案中）                           │
│     - 若在其他專案使用 evolve skill，需從遠端抓取更新           │
│     - /plugin marketplace update evolve-plugin                  │
│     - 或手動 git pull self-evolving-agent repo                  │
└─────────────────────────────────────────────────────────────────┘
```

> ⚠️ **重要**：不要直接修改 `~/.claude/plugins/` 中的檔案，
> 永遠在 self-evolving-agent 本地專案中修改後再同步。

### 修改前確認清單

- [ ] 確認在 self-evolving-agent 專案目錄中
- [ ] 確認要修改的檔案路徑
- [ ] 了解變更的影響範圍

### 修改後確認清單

- [ ] 變更已 commit 並 push
- [ ] 在需要的專案中更新到最新版本

## 四大自我進化能力

| 能力 | 說明 | 觸發時機 |
|------|------|----------|
| **Self-Evolution** | 累積可重用的 patterns 和解決方案 | 任務成功後 |
| **Self-Correction** | 建議失敗時自動修正策略 | PDCA Check 失敗時 |
| **Self-Validation** | 驗證學到的知識是否有效 | 習得新 skill 後 |
| **Personalization** | 適應專案特定的風格和偏好 | 累積足夠經驗後 |

## 知識蒸餾流程

```
成功經驗 (memory/learnings/)
         ↓
模式識別 (多次成功的共同點)
         ↓
蒸餾為:
├─ 新的 SKILL.md (小而深)
│   例: "comfyui-game-assets" skill
│
├─ 既有 skill 的增補
│   - Examples 區塊
│   - Pitfalls 區塊
│   - Checklist 區塊
│
└─ 策略池更新
    - 新策略加入
    - 成功率數據
```

## 蒸餾觸發條件

### 新 Skill 創建

當以下條件滿足時，建議創建新 skill：
- 同一任務類型成功 5+ 次
- 形成了可複用的模式
- 現有 skill 都不完全匹配

### 既有 Skill 增補

當以下條件滿足時，增補現有 skill：
- 發現新的 pitfall（已記錄 3+ 次）
- 發現更好的方法（成功率顯著提升）
- 有具體的範例值得記錄

### 策略池更新

當以下條件滿足時，更新策略池：
- 新策略成功 3+ 次
- 現有策略成功率下降
- 發現策略適用條件需要調整

## 社群貢獻機制

採用 `_base/` + `community/` 分離架構：

```
skills/
├── 01-core/
│   ├── _base/           # 官方內容（受保護）
│   │   └── pdca-cycle.md
│   └── community/       # 社群貢獻（可自由添加）
│       └── my-custom-pattern.md
```

**優勢：**
- 官方更新不會覆蓋社群內容
- 社群貢獻不會與官方衝突
- 可以選擇性採用社群內容

## 自動觸發（Hooks）

建議配置的 Claude Code Hooks：

### Session-End Hook

會話結束時，提示記錄學習：

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

### Post-Failure Hook

命令失敗後，自動分類錯誤：

```json
{
  "hooks": {
    "PostToolUse": [
      {
        "matcher": "Bash",
        "condition": "exit_code != 0",
        "command": "echo '⚠️ 命令失敗，請分類錯誤類型並記錄'"
      }
    ]
  }
}
```

## 預期涌現能力

基於自我進化機制，系統最容易自然長出的能力：

### 1. 跨領域任務管線
```
投資分析 (domain skill)
    ↓
寫報告 (creative/storytelling)
    ↓
落地成腳本/表格 (software skill)
```

### 2. 自動補洞
```
做一半發現缺知識
    ↓
自動搜尋 skill
    ↓
安裝並驗證
    ↓
繼續任務
```

### 3. 越做越不重複犯同樣錯
```
強制檢查點 + 變更後測試 + milestone 確認
    ↓
行為穩定
    ↓
「突然成熟」的感覺
```
