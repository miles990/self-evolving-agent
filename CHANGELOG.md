# Changelog

All notable changes to this project will be documented in this file.

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
