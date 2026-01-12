# Self-Evolving Agent

[![Version](https://img.shields.io/badge/version-4.5.0-blue)](./skills/SKILL.md)
[![License](https://img.shields.io/badge/license-MIT-green)](./LICENSE)
[![Architecture](https://img.shields.io/badge/architecture-atomic-purple)](./skills/)

> A Claude Code skill that enables autonomous goal achievement through iterative learning and self-improvement.

**[Quick Install](#quick-install)** | [Documentation](./skills/SKILL.md) | [Usage Manual](./USAGE.md) | [Examples](./examples/) | [Troubleshooting](./docs/TROUBLESHOOTING.md)

```
🌟北極星錨定 → PSB 環境檢查 → 目標分析（深度訪談）→ 評估能力 → 習得技能 → PDCA 執行 → 方向校正 → Repo 記憶 → 定期健檢 → 直到成功
```

## When to Use (適用場景)

**最能發揮價值的任務：**

| 場景 | 情境說明 | 使用範例 |
|------|----------|----------|
| 🎯 **複雜目標** | 需要多步驟、跨領域的任務 | `/evolve 為這個專案建立完整的用戶認證系統，包含 OAuth、JWT、權限管理` |
| 🔄 **迭代開發** | 需要反覆調整直到達成標準 | `/evolve 優化這個 API 的回應時間，目標降低 50%` |
| 🧭 **探索與研究** | 方向不明確，需要自主探索 | `/evolve 研究這個 codebase 的架構，找出可以改進的地方 --explore` |
| 💡 **項目發想** | 從零開始構思新專案 | `/evolve 我想做一個幫助開發者管理 side project 的工具，幫我發想功能` |
| 📝 **制定規格** | 透過深度訪談釐清需求 | `/evolve 幫我規劃一個訂單管理系統的規格，我還不確定需要哪些功能` |
| 📚 **累積經驗** | 會重複遇到類似問題的專案 | `/evolve 修復這個 bug 並記錄解決方案供未來參考` |

**參數說明：**

| 參數 | 說明 | 使用時機 |
|------|------|----------|
| `--explore` | 探索模式，允許自主選擇方向 | 目標不明確、想看看有什麼可以改進 |
| `--emergence` | 涌現模式，啟用跨領域連結 | 希望 AI 主動發現意外的改進機會 |
| `--autonomous` | 自主模式，完全自主創新 | 完全信任 AI 的判斷，追求系統性改進 |
| `--max-iterations N` | 最大迭代次數（預設 10） | 控制任務執行深度 |
| `--from-spec NAME` | 從 spec-workflow 執行 | 已有規格文件，按計畫實作 |

**簡單任務也能用：**
- 一行指令能解決的問題 — 可以用，但直接問 Claude 也行
- 純資訊查詢 — 不一定需要完整流程

## What's New in v4.5.0

### 🌟 北極星系統 (v4.4)
解決「做到後面迷失方向」的問題：
- **CP0**: 北極星錨定 — 任務開始前建立願景、完成標準、不做清單
- **CP3**: 方向校正 — Milestone 後對照北極星確認方向
- **CP6**: 專案健檢 — 每 5 次迭代檢查 Scope 膨脹和終止條件

### 🎯 深度訪談模式 (v4.3)
「寫 spec 最大的問題是你不知道自己漏了什麼」— 透過結構化問答挖掘隱藏需求

### ⚡ Token 優化 (v4.5)
SKILL.md 從 ~27K tokens 精簡至 ~2.2K tokens（降低 92%），採用原子化按需載入

## Quick Install

### Option 1: One-line install (Recommended)

```bash
# Basic install
curl -fsSL https://raw.githubusercontent.com/miles990/self-evolving-agent/main/install.sh | bash

# Full install with hooks and memory initialization
curl -fsSL https://raw.githubusercontent.com/miles990/self-evolving-agent/main/install.sh | bash -s -- --with-hooks --with-memory

# Install to specific project
curl -fsSL https://raw.githubusercontent.com/miles990/self-evolving-agent/main/install.sh | bash -s -- --target /path/to/project
```

### Option 2: Manual install

```bash
# Clone and copy
git clone https://github.com/miles990/self-evolving-agent.git
cp -r self-evolving-agent/skills /path/to/your/project/.claude/skills/evolve
```

### Option 3: Use with skillpkg

```bash
skillpkg install github:miles990/self-evolving-agent
```

## Core Philosophy

**AI 協作的本質：透過抽象化介面溝通**

| 傳統軟體 | AI 協作 | 作用 |
|----------|---------|------|
| API | MCP | 能力邊界（能做什麼） |
| SDK/Library | Tools | 具體實作（怎麼做） |
| 文檔+Best Practices | Skill | 領域知識（何時用什麼） |
| Config | CLAUDE.md | 上下文約束（專案規範） |

> **Skill 不只是知識，是「封裝好的判斷力」** — 告訴 AI 在什麼情況下，用什麼方式，達成什麼目標

## Usage

Trigger the agent with `/evolve`:

```bash
/evolve [your goal description]
```

### Flags

```bash
--explore          # 探索模式 - 允許自主選擇方向
--emergence        # 涌現模式 - 啟用跨領域連結探索
--autonomous       # 自主模式 - 完全自主，追求系統性創新
--max-iterations N # 最大迭代次數（預設 10）
--from-spec NAME   # 從 spec-workflow 的 tasks.md 執行
```

### Examples

```bash
# Simple goal
/evolve Optimize this React component's performance

# Complex goal
/evolve Build a ComfyUI workflow that generates game asset images
       with transparent backgrounds, consistent style, and batch processing

# Exploration mode
/evolve 讓這個專案變得更好 --explore --emergence --max-iterations 10

# From spec
/evolve implement user auth --from-spec auth-system
```

## How It Works

**Self-Evolving Loop v4.5**

1. 🌟 **CP0: 北極星錨定** — 願景、完成標準、不做清單
2. **PSB System** — Plan → Setup → Build（環境準備）
3. **目標分析** — 深度訪談 + 架構等級判斷
4. **能力評估 → Skill 習得**
5. **PDCA Cycle** — Plan → Do → Check → Act
   - CP3: 方向校正（對照北極星）
6. **Git-based Memory** — 記錄學習經驗
7. 🏥 **CP6: 專案健檢**（每 5 次迭代）

↻ 重複直到：目標達成 或 達到最大迭代次數

## Mandatory Checkpoints (護欄)

這些檢查點**不可跳過**，確保行為穩定：

| 檢查點 | 時機 | 動作 |
|--------|------|------|
| **CP0** 🌟 | 專案/任務開始前 | 北極星錨定（建立或讀取） |
| **CP1** | 任務開始前 | 搜尋 .claude/memory/ 查找相關經驗 |
| **CP1.5** | 寫程式碼前 | 一致性檢查（兩階段） |
| **CP2** | 程式碼變更後 | 編譯 + 測試驗證 |
| **CP3** | Milestone 完成後 | 確認目標、**方向校正**、下一步 |
| **CP3.5** | Memory 文件創建後 | 立即同步 index.md |
| **CP4** | 迭代完成後 | 涌現機會檢查（選擇性） |
| **CP5** | PDCA Check 失敗時 | 失敗後驗屍，生成結構化 Lesson |
| **CP6** 🏥 | 每 5 次迭代後 | 專案健檢（Scope、方向、終止檢查） |

## Memory System (Git-based)

```
📁 .claude/memory/
├── index.md          ← Quick index (auto-maintained)
├── learnings/        ← Knowledge: solutions, best practices
├── decisions/        ← ADR: architecture decision records
├── failures/         ← Failures: lessons learned, pitfalls
├── patterns/         ← Reasoning: reusable thinking patterns
├── strategies/       ← Strategies: task-specific strategy pools
├── discoveries/      ← Emergence: unexpected findings
└── skill-metrics/    ← Performance: skill effectiveness tracking
```

### Advantages

- ✅ Git version control - track history, rollback changes
- ✅ Cross-tool sharing - Claude Code ↔ Copilot ↔ Cursor
- ✅ Offline available - no external services required
- ✅ Team collaboration - PR review memory changes
- ✅ Fast Grep search - standard tools work
- ✅ Project portable - memory travels with repo

## Emergence Levels (涌現等級)

| Level | 名稱 | 行為 | 觸發 |
|-------|------|------|------|
| 0 | 基礎 | 嚴格執行指定任務 | 預設 |
| 1 | 探索 | 完成後探索相關改進 | `--explore` |
| 2 | 涌現 | 主動尋找跨領域連結 | `--emergence` |
| 3 | 自主 | 自主發現和追求創新 | `--autonomous` |

## Module Documentation

| Module | Description |
|--------|-------------|
| [00-getting-started](./skills/00-getting-started/) | 入門與環境設定 |
| [01-core](./skills/01-core/) | 核心流程（PSB + PDCA） |
| [02-checkpoints](./skills/02-checkpoints/) | 強制檢查點（護欄） |
| [03-memory](./skills/03-memory/) | 記憶系統操作 |
| [04-emergence](./skills/04-emergence/) | 涌現機制 |
| [05-integration](./skills/05-integration/) | 外部工具整合 |
| [06-scaling](./skills/06-scaling/) | 大規模專案優化 |
| [99-evolution](./skills/99-evolution/) | 自我進化機制 |

## Contributing

歡迎貢獻！請遵循以下流程：

1. Fork this repo
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Make your changes
4. Run validation: `./scripts/check-env.sh && ./scripts/validate-memory.sh`
5. Commit your changes (`git commit -m 'feat: add amazing feature'`)
6. Push to the branch (`git push origin feature/amazing-feature`)
7. Open a Pull Request

### Commit Convention

```
feat: 新功能
fix: 修復
docs: 文檔更新
refactor: 重構
chore: 雜項
```

## Related Projects

| Project | Description |
|---------|-------------|
| [claude-domain-skills](https://github.com/miles990/claude-domain-skills) | 16 non-technical domain skills |
| [claude-software-skills](https://github.com/miles990/claude-software-skills) | Software development skills |
| [skillpkg](https://github.com/anthropics/skillpkg) | Skill package manager |

## References

- [Reflexion Paper](https://arxiv.org/abs/2303.11366)
- [OpenAI Self-Evolving Agents Cookbook](https://cookbook.openai.com/examples/partners/self_evolving_agents/autonomous_agent_retraining)
- [Andrew Ng - Agentic Design Patterns](https://www.deeplearning.ai/the-batch/agentic-design-patterns-part-2-reflection/)
- [makepad-skills](https://github.com/ZhangHanDong/makepad-skills) - Atomic architecture inspiration

## License

MIT
