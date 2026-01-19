---
name: evolve
version: 5.8.0
description: 自我進化 Agent：給定目標，自主學習並迭代改進直到完成。
triggers: [evolve, 進化, 自我學習, 迭代改進, 達成目標, self-evolving, autonomous, goal-oriented, plan]
keywords: [agent, learning, pdca, memory, skill-acquisition, emergence, unified-planning, north-star, worktree, isolation, auto-update, plugin, leann, semantic-search, skill-creation]
---

# Self-Evolving Agent v5.8.0

> [**版本檢查**] → **北極星錨定** → [**Worktree 隔離**] → PSB 環境檢查 → 目標分析（**深度訪談**）→ **自動領域識別** → 評估能力 → 習得技能 → PDCA 執行（含方向校正）→ 診斷 → 多策略重試 → Repo 記憶 → **定期健檢** → [**Worktree 完成**] → 直到成功

## 快速導覽

本 skill 採用**原子化架構**，將知識拆分為獨立模組：

| 模組 | 用途 | 路徑 |
|------|------|------|
| **00-getting-started** | 入門與環境設定 | [→](./00-getting-started/) |
| **01-core** | 核心流程（PSB + PDCA） | [→](./01-core/) |
| **02-checkpoints** | 強制檢查點（護欄） | [→](./02-checkpoints/) |
| **03-memory** | 記憶系統操作 | [→](./03-memory/) |
| **04-emergence** | 涌現機制 | [→](./04-emergence/) |
| **05-integration** | 外部工具整合 | [→](./05-integration/) |
| **06-scaling** | 大規模專案優化 | [→](./06-scaling/) |
| **99-evolution** | 自我進化機制 | [→](./99-evolution/) |

## 使用方式

```bash
/evolve [目標描述]

# 範例
/evolve 建立一個能自動生成遊戲道具圖片的 ComfyUI 工作流程
/evolve 優化這段程式碼的效能，目標是降低 50% 執行時間
/evolve 為這個專案建立完整的測試覆蓋率達到 80%
```

### Flags

```bash
--explore          # 探索模式 - 允許自主選擇方向
--emergence        # 涌現模式 - 啟用跨領域連結探索
--autonomous       # 自主模式 - 完全自主，追求系統性創新
--max-iterations N # 最大迭代次數（預設 10）
--from-spec NAME   # 從 spec-workflow 的 tasks.md 執行
```

## 核心哲學

**人類與 AI 協作的本質：透過抽象化介面溝通**

| 傳統軟體 | AI 協作 | 作用 |
|----------|---------|------|
| API | MCP | 能力邊界（能做什麼） |
| SDK/Library | Tools | 具體實作（怎麼做） |
| 文檔+實踐 | Skill | 領域知識（何時用什麼） |
| Config | CLAUDE.md | 上下文約束（專案規範） |

**深層洞察**：
- Skill 不只是知識，是「封裝好的判斷力」
- 告訴 AI 在什麼情況下，用什麼方式，達成什麼目標
- 減少決策點 > 讓 AI 自己選擇

### 設計原則

| 原則 | 說明 |
|------|------|
| **有主見的設計** | 合理預設值 > 讓 AI 選擇，必填參數 ≤ 2 個 |
| **深且窄** | 專注 10% 高價值任務，不追求功能廣度 |
| **預期失敗** | 95% Agent 在生產環境失敗是常態，設計優雅降級 |
| **增強回饋** | 執行中提醒目標和進度，失敗時說明影響範圍 |

## 執行流程概覽

**Self-Evolving Loop v5.2**

0. 🔄 **版本檢查**（自動）— 檢查更新、詢問用戶、自動更新
1. 🌟 **CP0: 北極星錨定** — 願景、完成標準、不做清單、動機
2. 🔒 **CP0.5: Worktree 隔離**（條件觸發）— Level 2 / autonomous / 並行任務
3. **PSB System** — Plan → Setup → Build（環境準備）
4. **目標分析** — 深度訪談 + 架構等級判斷（Level 2 強制）
5. **能力評估 → Skill 習得**
6. **PDCA Cycle** — Plan → Do → Check → Act（含多策略選擇）
   - CP3: 方向校正（對照北極星）
7. **Git-based Memory** — 記錄學習經驗
8. 🏥 **CP6: 專案健檢**（每 5 次迭代）— Scope、方向、終止檢查
9. 🏁 **CP6.5: Worktree 完成**（條件觸發）— 合併/清理

↻ 重複直到：目標達成 或 達到最大迭代次數

> 💡 **v5.8 新增**：Skill 缺口處理 — 找不到適合 Skill 時自動詢問
> - 相關度 < 0.5 時觸發詢問：研究並建立 / 組合現有 / 直接開始
> - 整合 skill-creator 和 4C 知識習得法
> - 詳見：[02-checkpoints/_base/cp1-memory-search.md](./02-checkpoints/_base/cp1-memory-search.md#找不到適合-skill-時v58-新增)
>
> 💡 **v5.7 新增**：LEANN 語義搜尋 Skill Discovery — CP1 自動推薦相關 Skill
> - 從任務描述理解概念，而非關鍵字匹配
> - 設定：`./scripts/setup-skill-index.sh`
> - 整合說明：[05-integration/_base/leann-skill-discovery.md](./05-integration/_base/leann-skill-discovery.md)
>
> 💡 **v5.2 新增**：版本檢查與自動更新 — 每次啟動時檢查新版本
> - 版本檢查：[00-getting-started/_base/version-check.md](./00-getting-started/_base/version-check.md)
> - 自動比較本地與遠端版本，詢問用戶是否更新
>
> 💡 **v5.1 新增**：Worktree 隔離環境 — 高風險任務的安全邊界
> - CP0.5：Worktree 準備 → [02-checkpoints/_base/cp0.5-worktree-setup.md](./02-checkpoints/_base/cp0.5-worktree-setup.md)
> - CP6.5：Worktree 完成 → [02-checkpoints/_base/cp6.5-worktree-completion.md](./02-checkpoints/_base/cp6.5-worktree-completion.md)
> - 概述：[06-scaling/_base/isolated-environments.md](./06-scaling/_base/isolated-environments.md)
>
> 💡 **v4.4 新增**：北極星系統 — 解決「做到後面迷失方向」的問題
> - CP0：北極星錨定 → [02-checkpoints/_base/cp0-north-star.md](./02-checkpoints/_base/cp0-north-star.md)
> - CP3：方向校正 → [02-checkpoints/_base/cp3-milestone-confirm.md](./02-checkpoints/_base/cp3-milestone-confirm.md)
> - CP6：專案健檢 → [02-checkpoints/_base/cp6-project-health-check.md](./02-checkpoints/_base/cp6-project-health-check.md)
>
> 💡 **v4.3 新增**：深度訪談模式 — 「寫 spec 最大的問題是你不知道自己漏了什麼」
> 詳見 [01-core/_base/goal-analysis.md](./01-core/_base/goal-analysis.md#深度訪談模式deep-interview)

### 架構考量三層設計

| Layer | 階段 | 動作 |
|-------|------|------|
| 1 | Goal Analysis | 判斷架構等級 (0/1/2) |
| 2 | PDCA Plan | 依等級做架構設計 |
| 3 | CP1.5 Phase 2 | 驗證實作符合設計 |

→ 設計 → 實作 → 驗證 閉環

## 強制檢查點（護欄）

> **這些檢查點不可跳過**，詳見 [02-checkpoints](./02-checkpoints/)

| 檢查點 | 時機 | 動作 |
|--------|------|------|
| **CP0** 🌟 | 專案/任務開始前 | 北極星錨定（建立或讀取） |
| **CP0.5** 🔒 | CP0 後（條件觸發） | Worktree 隔離環境準備 |
| **CP1** | 任務開始前 | 搜尋 .claude/memory/ 查找相關經驗 |
| **CP1.5** | 寫程式碼前 | 一致性檢查（兩階段） |
| **CP2** | 程式碼變更後 | 編譯 + 測試驗證 |
| **CP3** | Milestone 完成後 | 確認目標、**方向校正**、下一步 |
| **CP3.5** | Memory 文件創建後 | 立即同步 index.md |
| **CP4** | 迭代完成後 | 涌現機會檢查（選擇性） |
| **CP5** | PDCA Check 失敗時 | 失敗後驗屍，生成結構化 Lesson |
| **CP6** 🏥 | 每 5 次迭代後 | 專案健檢（Scope、方向、終止檢查） |
| **CP6.5** 🏁 | 任務完成時（條件觸發） | Worktree 合併/清理 |

### CP1.5 兩階段設計

**Phase 1: 基礎檢查（必執行）**
- 搜尋現有實作，避免重複造輪子
- 檢查專案慣例（命名、風格）
- 檢查 Schema/API 一致性

**Phase 2: 架構檢查（自動偵測觸發）**
- 依賴方向、錯誤處理一致性、橫切關注點、設計模式一致性

**觸發條件**：新增目錄/模組、變更涉及 3+ 目錄、新增外部依賴、觸及 core/infra/domain/shared/、新增公開 API

## 停止條件

| 狀態 | 條件 |
|------|------|
| ✅ 成功 | 所有子目標完成 + 驗收標準通過 |
| ❌ 失敗 | 達到最大迭代次數 或 連續 3 次相同錯誤 |
| ⏸️ 暫停 | 需要用戶決策 或 風險操作需確認 |

## 完成信號

- `✅ GOAL ACHIEVED: [目標描述]`
- `⏸️ NEED HUMAN: [原因]`
- `❌ CANNOT COMPLETE: [原因]`

## 相關資源

- [Reflexion Paper](https://arxiv.org/abs/2303.11366)
- [OpenAI Self-Evolving Agents Cookbook](https://cookbook.openai.com/examples/partners/self_evolving_agents/autonomous_agent_retraining)
- [Andrew Ng - Agentic Design Patterns](https://www.deeplearning.ai/the-batch/agentic-design-patterns-part-2-reflection/)
