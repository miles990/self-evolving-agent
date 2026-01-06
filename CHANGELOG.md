# Changelog

All notable changes to this project will be documented in this file.

## [3.3.0] - 2026-01-06

### Added
- **強制檢查點（Mandatory Checkpoints）**
  - Checkpoint 1: 任務開始前 - 主動查 Memory
  - Checkpoint 2: 程式碼變更後 - 編譯 + 測試必須通過
  - Checkpoint 3: Milestone 完成後 - 目標確認

- **Memory 生命週期管理**
  - 整理策略：合併、標註過時、加上下文、刪除
  - 觸發時機：Milestone 完成、條目超過 20 筆、新舊衝突、定期整理
  - Memory 整理 Checklist

- **index.md Metadata**
  - Last curated: 上次整理日期
  - Total entries: 總條目數
  - Next review: 下次整理日期
  - 統計區塊

### Changed
- 從「指南」變「護欄」：強制檢查點不可跳過
- Memory 不再只進不出，需要定期去蕪存菁

### Philosophy
- AI 的價值：0 → 60 分（基礎產出）
- 人類的價值：60 → 100 分（品質、判斷、細節）
- AI 是放大器，不是替代品

---

## [3.2.0] - 2026-01-06

### Added
- **核心哲學：AI 協作的抽象化範式**
  - MCP = 能力邊界（能做什麼）
  - Tools = 具體實作（怎麼做）
  - Skill = 領域知識（何時用什麼）— 封裝好的判斷力
  - CLAUDE.md = 上下文約束（專案規範）

- **PSB System 整合**
  - Plan-Setup-Build 環境準備流程
  - 在寫第一行程式碼前，先確保環境就緒
  - 7 步驟環境檢查清單

- **Phase -1: 環境準備**
  - Git Repo 檢查
  - CLAUDE.md 專案記憶
  - 記憶系統初始化
  - MCP 配置（可選）
  - Slash Commands 設定（可選）

- **設計原則**
  - 有主見的設計：合理預設值 > 讓 AI 選擇
  - 深且窄：專注 10% 高價值任務
  - 預期失敗：設計優雅降級
  - 增強回饋：執行中提醒目標和進度

### Changed
- 核心理念圖表更新為 PSB + PDCA 整合框架
- README 新增 Core Philosophy 區塊
- 流程從 `Goal → ...` 改為 `PSB Setup → Goal → ...`

### Reference
- [PSB System (HackMD)](https://hackmd.io/@eBrqaOowRWWfcAjhMNwlvg/HkNuCGcEZl)
- [Agent Design is Still Hard 2025](https://ihower.tw/blog/13513-agent-design-is-still-hard-2025)

---

## [3.1.0] - 2025-01-05

### Changed
- **Repo-based Memory** - 記憶目錄從 `.claude/memory/` 改為 `.github/memory/`
- 相容 GitHub Copilot Agent Skills（共用 `.github/` 目錄）
- 跨工具記憶共享：Claude Code, Copilot, Cursor

### New Memory Structure
```
📁 .github/memory/
├── index.md          ← 快速索引（自動維護）
├── learnings/        ← 學習記錄
├── decisions/        ← 決策記錄 (ADR)
├── failures/         ← 失敗經驗
├── patterns/         ← 推理模式
└── strategies/       ← 策略記錄
```

### Added
- Phase 0: 初始化記憶系統
- 完整的記憶操作指南（Grep/Write/Edit 範例）
- index.md 索引機制
- 結構化經驗模板（frontmatter + markdown）

### Benefits
- Git 版本控制，可追溯歷史
- 團隊協作，PR 審核記憶變更
- 專案相關，隨 repo 遷移
- 離線可用，無需外部服務

---

## [3.0.0] - 2025-01-05

### Breaking Changes
- **Zero External Dependencies** - Removed all external MCP dependencies
- **Local File Memory** - Replaced Cipher MCP with local markdown files

### Changed
- Memory system: Cipher MCP → Local files (`.claude/memory/`)
- Skill acquisition: skillpkg → WebSearch + Context7
- All external tool references updated to use built-in tools only

### New Memory System
```
📁 .claude/memory/
├── experiences.md    ← Solutions, failures, lessons learned
├── strategies.md     ← Strategy tracking, success rates
└── learnings.md      ← New skills, discoveries, notes
```

### Benefits
- Works out of the box, no installation required
- Pure text format, Git-friendly
- Fast Grep search
- Copy to any project instantly

### Migration from v2.x
1. Export any existing Cipher memories manually
2. Paste into `.claude/memory/experiences.md` or `learnings.md`
3. No configuration changes needed

---

## [2.1.0] - 2025-01-03

### Added
- **Cipher MCP Integration** - Replaced claude-dev-memory with Cipher as the memory system
- **Dual Memory Architecture** - System 1 (Knowledge) + System 2 (Reflection)
- **New Memory Tools**:
  - `cipher_memory_search` - Search stored knowledge
  - `cipher_extract_and_operate_memory` - Store and retrieve experiences
  - `cipher_store_reasoning_memory` - Store reasoning patterns
  - `cipher_search_reasoning_patterns` - Search reasoning history

### Changed
- Memory system migration from claude-dev-memory to Cipher
- Updated all memory tool references in SKILL.md
- Updated README with Cipher installation instructions

### Benefits
- Cross-IDE memory sync (Cursor ↔ VS Code ↔ Claude Code)
- Team shared memory (Workspace Memory)
- Auto-learns development patterns
- Zero configuration setup

## [2.0.0] - 2025-01-02

### Added
- **Capability Boundary Assessment** - Self-evaluate skills before execution
- **Skill Auto-Acquisition** - Integration with skillpkg MCP for on-demand skill learning
- **Failure Mode Diagnosis** - Classify failures into 5 types (Knowledge Gap, Execution Error, Environment Issue, Strategy Error, Resource Limit)
- **Multi-Strategy Mechanism** - Strategy pool to avoid repeating failed approaches
- **Structured Experience Format** - Searchable experience storage for future retrieval
- **Learning Verification** - Verify newly acquired skills before applying

### Changed
- Enhanced PDCA loop with diagnostic feedback
- Improved goal clarity checking with user questionnaire
- Better progress reporting format

## [1.0.0] - 2024-12-31

### Added
- Initial Self-Evolving Agent implementation
- Basic PDCA (Plan-Do-Check-Act) loop
- Memory integration (Core + Archival)
- Goal decomposition and sub-goal tracking
- Reflexion-based learning mechanism
