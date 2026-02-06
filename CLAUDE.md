# Self-Evolving Agent - Project Context

> 專案約束文件，供 AI 助手理解專案規範

## Workflow Preferences

- 當要求「plan」、「design」、「discuss」時，先呈現計劃/設計文件，**不要直接開始實作或探索代碼**。等用戶確認後再進入實作階段
- 先確認範圍（scope）再動手，避免過度實作
- 主要語言：Markdown（Skill 定義）、Bash（腳本）、TypeScript（目標專案）
- 架構討論使用 mermaid 圖輔助說明
- 遵守 PDCA 循環：即使是小改動也要有明確的 Plan → Do → Check → Act
- 報告進度時簡潔明確，不要冗長解釋

## 專案概述

這是一個 **Claude Code Skill**，讓 AI 能夠自主達成目標、從經驗中學習並持續改進。

## 技術棧

- **語言**: Markdown (Skill 定義)、Bash (腳本)
- **架構**: 原子化模組設計
- **記憶系統**: Git-based (.claude/memory/)
- **整合**: PAL MCP、spec-workflow MCP、Claude Code Plugin

## 目錄結構

```
skills/
├── SKILL.md                 # 主入口（全域 skill 文件）
├── 00-getting-started/      # 入門模組
├── 01-core/                 # 核心流程
├── 02-checkpoints/          # 強制檢查點
├── 03-memory/               # 記憶系統
├── 04-emergence/            # 涌現機制
├── 05-integration/          # 外部整合
└── 99-evolution/            # 自我進化
```

## 設計原則

1. **有主見的設計**: 合理預設值 > 讓 AI 選擇
2. **深且窄**: 專注高價值任務，不追求廣度
3. **預期失敗**: 設計優雅降級機制
4. **增強回饋**: 清晰的進度和錯誤報告

## 重要約定

### Checkpoint 規則（不可跳過）

| 檢查點 | 時機 | 動作 |
|--------|------|------|
| CP1 | 任務開始前 | 搜尋 .claude/memory/ |
| CP2 | 程式碼變更後 | 編譯 + 測試驗證 |
| CP3 | Milestone 後 | 確認目標和方向 |
| CP3.5 | Memory 創建後 | 同步 index.md |
| CP4 | 迭代完成後 | 涌現機會檢查 |

### Checkpoint 並行化

以下 CP 可以並行執行以提升效率：

| 並行組合 | 說明 | 方式 |
|----------|------|------|
| **CP1 + CP1.5 Phase 1** | Memory 搜尋與基礎一致性檢查互不依賴 | 同時啟動兩個 Task（`run_in_background: true`），等待兩者完成 |
| **CP4 + 下一迭代 Plan** | 涌現檢查不阻塞後續流程 | CP4 在背景運行，同時開始下一次 PDCA Plan |

**不可並行的 CP**：
- CP0/CP0.5 必須在所有其他 CP 之前完成
- CP1.5 Phase 2 依賴 CP1 的搜尋結果，不可與 CP1 並行
- CP2 必須在程式碼變更後、CP3 之前執行（序列關係）

### Memory 操作

- 創建 memory 文件後**立即**更新 index.md
- 使用標準格式（見 03-memory/_base/operations.md）
- 定期清理過時記錄

### 版本規範

- 版本號: v{major}.{minor}.{patch}
- 變更記錄: CHANGELOG.md
- 重大變更需更新 skills/SKILL.md 版本

## 禁止事項

- ❌ 跳過強制檢查點
- ❌ 創建 memory 後不更新 index.md
- ❌ 修改 _base/ 目錄下的官方文件（除非是版本更新）
- ❌ 在腳本中使用硬編碼絕對路徑

## Hooks 自動化

本專案透過 `hooks/` 目錄配置 Claude Code Plugin Hooks，自動提醒關鍵檢查點：

| Hook | 觸發時機 | 提醒內容 |
|------|----------|----------|
| `checkpoint-reminder` | Edit/Write | CP1.5 一致性、CP2 驗證 |
| `memory-sync` | Write .claude/memory/ | CP3.5 同步 index.md |
| `build-verify` | Edit/Write 代碼文件 | 自動偵測代碼變更，提醒編譯+測試 |

`build-verify` hook 會智能判斷檔案類型：僅對 `.ts/.tsx/.js/.jsx/.py/.go/.rs/.sh` 等代碼文件觸發提醒，Markdown/YAML/JSON 等非代碼文件靜默通過。

## 開發指南

### 添加新模組

1. 在 `skills/` 下創建新目錄
2. 添加 `_base/` 子目錄
3. 創建 `README.md` 說明文件
4. 更新 `skills/SKILL.md` 目錄結構

### 測試變更

```bash
# 環境檢查
./scripts/check-env.sh

# Memory 驗證
./scripts/validate-memory.sh
```

### 提交規範

```
feat: 新功能
fix: 修復
docs: 文檔
refactor: 重構
chore: 雜項
```

## 相關資源

- [USAGE.md](./USAGE.md) - 詳細使用手冊
- [examples/](./examples/) - 使用範例
- [docs/](./docs/) - 延伸文檔
