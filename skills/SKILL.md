---
name: evolve
version: 4.0.0
description: 自我進化 Agent：給定目標，自主學習並迭代改進直到完成。
triggers: [evolve, 進化, 自我學習, 迭代改進, 達成目標, self-evolving, autonomous, goal-oriented, plan]
keywords: [agent, learning, pdca, memory, skill-acquisition, emergence, unified-planning]
---

# Self-Evolving Agent v4.0.0

> PSB 環境檢查 → 目標分析 → **自動領域識別** → 評估能力 → 習得技能 → PDCA 執行 → 診斷 → 多策略重試 → Repo 記憶 → 直到成功

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

```
┌─────────────────────────────────────────────────────────────────┐
│  人類與 AI 協作的本質：透過抽象化介面溝通                       │
│                                                                 │
│  ┌──────────────┬──────────────┬────────────────────────┐      │
│  │ 傳統軟體     │ AI 協作      │ 作用                   │      │
│  ├──────────────┼──────────────┼────────────────────────┤      │
│  │ API          │ MCP          │ 能力邊界（能做什麼）   │      │
│  │ SDK/Library  │ Tools        │ 具體實作（怎麼做）     │      │
│  │ 文檔+實踐    │ Skill        │ 領域知識（何時用什麼） │      │
│  │ Config       │ CLAUDE.md    │ 上下文約束（專案規範） │      │
│  └──────────────┴──────────────┴────────────────────────┘      │
│                                                                 │
│  深層洞察：                                                     │
│  • Skill 不只是知識，是「封裝好的判斷力」                       │
│  • 告訴 AI 在什麼情況下，用什麼方式，達成什麼目標               │
│  • 減少決策點 > 讓 AI 自己選擇                                  │
└─────────────────────────────────────────────────────────────────┘
```

### 設計原則

| 原則 | 說明 |
|------|------|
| **有主見的設計** | 合理預設值 > 讓 AI 選擇，必填參數 ≤ 2 個 |
| **深且窄** | 專注 10% 高價值任務，不追求功能廣度 |
| **預期失敗** | 95% Agent 在生產環境失敗是常態，設計優雅降級 |
| **增強回饋** | 執行中提醒目標和進度，失敗時說明影響範圍 |

## 執行流程概覽

```
┌─────────────────────────────────────────────────────────────────┐
│                  Self-Evolving Loop v4.0                        │
│                                                                 │
│  ╔═══════════════════════════════════════════════════════════╗ │
│  ║  PSB System (環境準備)                                     ║ │
│  ║  Plan → Setup → Build                                      ║ │
│  ╚═══════════════════════════════════════════════════════════╝ │
│                            ↓                                    │
│         目標分析 → 能力評估 → Skill 習得                        │
│                            ↓                                    │
│  ╔═══════════════════════════════════════════════════════════╗ │
│  ║  PDCA Cycle (執行循環)                                     ║ │
│  ║  Plan → Do → Check → Act                                   ║ │
│  ║       ↑                  │                                 ║ │
│  ║       └── 多策略選擇 ←───┘                                 ║ │
│  ╚═══════════════════════════════════════════════════════════╝ │
│                            ↓                                    │
│                    Git-based Memory                             │
│                                                                 │
│    重複直到：目標達成 或 達到最大迭代次數                       │
└─────────────────────────────────────────────────────────────────┘
```

## 強制檢查點（護欄）

> **這些檢查點不可跳過**，詳見 [02-checkpoints](./02-checkpoints/)

| 檢查點 | 時機 | 動作 |
|--------|------|------|
| **CP1** | 任務開始前 | 搜尋 .claude/memory/ 查找相關經驗 |
| **CP2** | 程式碼變更後 | 編譯 + 測試驗證 |
| **CP3** | Milestone 完成後 | 確認目標、方向、下一步 |
| **CP3.5** | Memory 文件創建後 | 立即同步 index.md |
| **CP4** | 迭代完成後 | 涌現機會檢查（選擇性） |

## 停止條件

```
✅ 成功：所有子目標完成 + 驗收標準通過
❌ 失敗：達到最大迭代次數 或 連續 3 次相同錯誤
⏸️ 暫停：需要用戶決策 或 風險操作需確認
```

## 完成信號

```
✅ GOAL ACHIEVED: [目標描述]
⏸️ NEED HUMAN: [原因]
❌ CANNOT COMPLETE: [原因]
```

## 目錄結構

```
skills/
├── SKILL.md                    # 本文件（主入口）
├── 00-getting-started/         # 入門
│   ├── _base/                  # 官方內容
│   │   ├── init.md             # 初始化指南
│   │   └── psb-setup.md        # PSB 環境檢查
│   └── community/              # 社群貢獻
├── 01-core/                    # 核心流程
│   ├── _base/
│   │   ├── goal-analysis.md    # 目標分析
│   │   ├── capability-assessment.md  # 能力評估
│   │   ├── skill-acquisition.md      # 技能習得
│   │   └── pdca-cycle.md       # PDCA 循環
│   └── community/
├── 02-checkpoints/             # 強制檢查點
│   ├── _base/
│   │   ├── cp1-memory-search.md
│   │   ├── cp2-build-test.md
│   │   ├── cp3-milestone-confirm.md
│   │   ├── cp3.5-memory-sync.md
│   │   └── cp4-emergence-check.md
│   └── community/
├── 03-memory/                  # 記憶系統
│   ├── _base/
│   │   ├── structure.md        # 目錄結構
│   │   ├── operations.md       # 操作指南
│   │   └── lifecycle.md        # 生命週期管理
│   └── community/
├── 04-emergence/               # 涌現機制
│   ├── _base/
│   │   ├── multi-stage-routing.md    # 多階路由
│   │   ├── skill-metrics.md          # 效果記分板
│   │   ├── knowledge-distillation.md # 知識蒸餾
│   │   └── emergence-levels.md       # 涌現等級
│   └── community/
├── 05-integration/             # 外部整合
│   ├── _base/
│   │   ├── skillpkg.md         # skillpkg 整合
│   │   ├── pal-tools.md        # PAL 工具
│   │   ├── spec-workflow.md    # spec-workflow 整合
│   │   └── hooks.md            # Claude Code Hooks
│   └── community/
└── 99-evolution/               # 自我進化
    ├── _base/
    │   ├── self-evolution.md   # 自我進化機制
    │   ├── self-correction.md  # 自我修正
    │   └── templates/          # 模板
    ├── community/              # 社群貢獻的進化模式
    └── hooks/                  # Hook 腳本
```

## 相關資源

- [Reflexion Paper](https://arxiv.org/abs/2303.11366)
- [OpenAI Self-Evolving Agents Cookbook](https://cookbook.openai.com/examples/partners/self_evolving_agents/autonomous_agent_retraining)
- [Andrew Ng - Agentic Design Patterns](https://www.deeplearning.ai/the-batch/agentic-design-patterns-part-2-reflection/)
