# 02-checkpoints

> 強制檢查點：品質護欄，不可跳過

## 本模組包含

| 文件 | 檢查點 | 時機 |
|------|--------|------|
| [cp0-north-star.md](./_base/cp0-north-star.md) | CP0 | 專案/任務開始前 |
| [cp0.5-worktree-setup.md](./_base/cp0.5-worktree-setup.md) | CP0.5 | CP0 後（條件觸發） |
| [cp1-memory-search.md](./_base/cp1-memory-search.md) | CP1 | 任務開始前 |
| [cp1.5-consistency-check.md](./_base/cp1.5-consistency-check.md) | CP1.5 | 寫程式碼前 |
| [cp2-build-test.md](./_base/cp2-build-test.md) | CP2 | 程式碼變更後 |
| [cp3-milestone-confirm.md](./_base/cp3-milestone-confirm.md) | CP3 | Milestone 完成後 |
| [cp3.5-memory-sync.md](./_base/cp3.5-memory-sync.md) | CP3.5 | Memory 創建後 |
| [cp4-emergence-check.md](./_base/cp4-emergence-check.md) | CP4 | 迭代完成後（選擇性） |
| [cp5-failure-postmortem.md](./_base/cp5-failure-postmortem.md) | CP5 | 失敗後 |
| [cp6-project-health-check.md](./_base/cp6-project-health-check.md) | CP6 | 每 5 次迭代後 |
| [cp6.5-worktree-completion.md](./_base/cp6.5-worktree-completion.md) | CP6.5 | 任務完成時（條件觸發） |

## 檢查點總覽

```
CP0:   北極星錨定          → 建立願景/完成標準/不做清單
CP0.5: Worktree 隔離       → 高風險任務安全邊界（條件觸發）
CP1:   搜尋 Memory         → 避免重複犯錯
CP1.5: 一致性檢查          → 避免重複造輪子 + 架構一致
       ├─ Phase 1: 基礎    → 必執行（搜尋現有實作、專案慣例）
       └─ Phase 2: 架構    → 自動偵測觸發（依賴方向、錯誤處理、設計模式）
CP2:   編譯 + 測試         → 確保程式碼品質
CP3:   確認目標            → 確保方向正確
CP3.5: 同步 index          → 確保 Memory 可搜尋
CP4:   涌現檢查            → 發現改進機會（選擇性）
CP5:   失敗後驗屍          → 結構化學習教訓
CP6:   專案健檢            → Scope/方向/終止檢查
CP6.5: Worktree 完成       → 合併/清理（條件觸發）
```

## Checkpoint 並行化

部分 CP 之間無依賴關係，可以並行執行以減少等待時間：

### 可並行的 CP 組合

**1. CP1 + CP1.5 Phase 1**

CP1（Memory 搜尋）搜尋 `.claude/memory/`，CP1.5 Phase 1（基礎一致性檢查）搜尋 `src/`，兩者搜尋範圍不重疊、結果互不依賴。

```
# 在同一訊息中同時發送兩個 Task
Task: CP1 Memory Search (run_in_background: true)
Task: CP1.5 Phase 1 Basic Consistency Check (run_in_background: true)
# 等待兩者完成後，合併結果進入下一步
```

**2. CP4 + 下一迭代 Plan**

CP4（涌現檢查）為選擇性檢查點，其結果不阻塞後續 PDCA 迭代。可在背景運行 CP4，同時開始下一次迭代的 Plan 階段。

### 不可並行的 CP（序列依賴）

| CP | 原因 |
|----|------|
| CP0 / CP0.5 | 必須在所有其他 CP 之前完成（北極星錨定） |
| CP1.5 Phase 2 | 依賴 CP1 的搜尋結果（需要知道相關記憶才能做架構驗證） |
| CP2 → CP3 | CP2（編譯測試）必須在程式碼變更後執行，CP3 必須在 CP2 通過後 |
| CP3.5 | 必須在 Memory 創建後立即執行 |

### 並行化流程圖

```
CP0 → CP0.5 → ┬─ CP1 ──────────┬─→ CP1.5 Phase 2 → Do → CP2 → CP3 → CP3.5
               └─ CP1.5 Phase 1 ┘                                      │
                                                                        ▼
                                                                ┬─ CP4 (背景)
                                                                └─ 下一迭代 Plan
```

## CP1.5 Phase 2 觸發條件

Phase 2 架構檢查在以下**任一條件**成立時自動觸發：

| 條件 | 說明 |
|------|------|
| 新增目錄/模組 | 建立新的目錄結構 |
| 變更涉及 3+ 目錄 | 跨多個層級的修改 |
| 新增外部依賴 | 修改 `package.json`、`requirements.txt` 等 |
| 觸及核心目錄 | 路徑含 `core/`、`infra/`、`domain/`、`shared/` |
| 新增公開 API | 建立對外介面 |

## 重要提醒

**CP1-CP3.5 為強制檢查點，不可跳過！**

## 社群貢獻

