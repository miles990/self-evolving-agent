# Changelog

All notable changes to this project will be documented in this file.

## [3.7.1] - 2026-01-08

### Added - Checkpoint 3.5: Memory 同步

基於 evolve-trader 專案的實際失敗經驗，新增強制 Memory 同步檢查點：

- **Checkpoint 3.5: Memory 同步 - 即時更新 index.md**
  - 背景：創建多個 memory 文件（learnings, failures, decisions）後忘記更新 index.md
  - 用戶反饋：「我看.claude/memory沒有新的紀錄」
  - 原因：儲存與索引是兩個分離的動作，容易忽略後者
  - 解決：強制要求 Write memory → Edit index → 驗證 三步一體

### Changed
- 版本號從 3.7.0 更新至 3.7.1
- 強制檢查點從 3 個增至 3.5 個（新增 Memory 同步）

### Lessons Learned
- 從 evolve-trader 專案 ADR-043~045 優化過程中發現此模式
- 失敗記錄：`.claude/memory/failures/2026-01-08-forget-to-update-index.md`

---

## [3.5.1] - 2026-01-07

### Added - Auto Domain Detection
- **自動領域識別機制**
  - 從任務描述提取關鍵詞
  - 透過 skillpkg triggers 搜尋匹配的領域 skill
  - 自動載入相關領域知識
  - 支援多領域同時載入

- **領域 Skills 整合**
  - 支援 `claude-domain-skills` (非技術領域)
  - 支援 `claude-software-skills` (技術領域)
  - 16 個領域 skills 可用：
    - Finance: quant-trading, investment-analysis
    - Business: product-management, project-management, marketing, sales, strategy
    - Creative: game-design, ui-ux-design, brainstorming, storytelling, visual-media
    - Professional: research-analysis, knowledge-management
    - Lifestyle: personal-growth, side-income

- **新增範例文檔**
  - `examples/auto-domain-detection.md` - 自動領域識別使用範例

### Changed
- 核心流程新增 Auto Domain Detection 階段
- 更新 README 說明自動領域識別功能
- triggers 格式相容 skillpkg 1.0 schema

### Reference
- [claude-domain-skills](https://github.com/miles990/claude-domain-skills)
- [skillpkg](https://github.com/anthropics/skillpkg)

---

## [3.4.0] - 2026-01-07

### Added - Boris Cherny Tips 整合

基於 Claude Code 創作者 Boris Cherny 分享的 13 條使用技巧，新增以下功能：

- **強化驗證迴圈（Tip #13）**
  - PDCA Check 階段加入自動化驗證策略
  - 自動執行測試、構建、Lint、型別檢查
  - Boris: "給 Claude 驗證工作的方式，品質提升 2-3 倍"

- **Subagent 策略（Tip #8）**
  - `verify-app`: 驗證應用程式正確運作
  - `code-simplifier`: 簡化複雜程式碼
  - `build-validator`: 驗證構建流程
  - 新增 `.claude/memory/strategies/subagents.md` 策略定義

- **Hooks 整合（Tips #9, #12）**
  - PostToolUse hook: 自動格式化程式碼
  - Stop hook: 任務完成時執行驗證
  - 配置範例和使用建議

- **長時間任務處理（Tip #12）**
  - ralph-wiggum plugin 整合
  - Background Agent 使用指南
  - Permission 優化建議（/permissions vs --dangerously-skip-permissions）

### Reference
- [Boris Cherny Threads Post](https://www.threads.com/@boris_cherny/post/DTBVlMIkpcm)
- 學習記錄：`.claude/memory/learnings/2025-01-07-boris-cherny-claude-code-tips.md`

---

## [3.3.1] - 2026-01-06

### Added
- **標準化完成輸出格式**
  - `✅ GOAL ACHIEVED: [目標]` - 目標達成
  - `⏸️ NEED HUMAN: [原因]` - 需要人工介入
  - `❌ CANNOT COMPLETE: [原因]` - 無法完成
  - 方便識別和未來工具整合

### Cleanup
- 移除 `.claude/memory/` 範本（應在使用者專案）
- 移除 `drafts/` 目錄（屬於其他專案）
- 移除空的 `.github/` 目錄

---

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
- **Git-based Memory** - 記憶目錄從 `.claude/memory/` 改為 `.claude/memory/`
- 相容 GitHub Copilot Agent Skills（共用 `.github/` 目錄）
- 跨工具記憶共享：Claude Code, Copilot, Cursor

### New Memory Structure
```
📁 .claude/memory/
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
