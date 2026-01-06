# Self-Evolving Agent

> A Claude Code skill that enables autonomous goal achievement through iterative learning and self-improvement.

```
PSB Setup → Goal Analysis → Assess Capabilities → Acquire Skills → PDCA Execute → Diagnose → Multi-Strategy Retry → Repo Memory → Until Success
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

## Features

### v3.2 新增
- **PSB Integration** - Plan-Setup-Build 環境準備，確保環境就緒再執行
- **Design Principles** - 有主見的設計、深且窄、預期失敗、增強回饋
- **Phase -1** - 7 步驟環境檢查清單

### 核心功能
- **Zero External Dependencies** - Works out of the box, no MCP installation required
- **Capability Boundary Awareness** - Self-assess what you know vs. what you need to learn
- **Knowledge Auto-Acquisition** - Use WebSearch + skillpkg to learn new knowledge on-demand
- **Failure Mode Diagnosis** - Classify failures (5 types) and apply targeted fixes
- **Multi-Strategy Mechanism** - Never repeat failed strategies, maintain a strategy pool
- **Repo-based Memory** - Store experiences in `.github/memory/` with Git version control
- **Learning Verification** - Verify knowledge is actually learned before applying it

## Installation

### Option 1: Copy to your project

```bash
# Copy SKILL.md to your Claude Code skills directory
cp SKILL.md /path/to/your/project/.claude/skills/self-evolving-agent/SKILL.md
```

### Option 2: Use with skillpkg (coming soon)

```bash
# Install via skillpkg
skillpkg install github:user/self-evolving-agent
```

## Usage

Trigger the agent with `/evolve`:

```
/evolve [your goal description]
```

### Examples

```bash
# Simple goal
/evolve Optimize this React component's performance

# Complex goal
/evolve Build a ComfyUI workflow that generates game asset images
       with transparent backgrounds, consistent style, and batch processing

# Learning goal
/evolve Research and implement WebSocket real-time communication
```

## How It Works

```
┌─────────────────────────────────────────────────────────────────┐
│                  Self-Evolving Loop v3.2                        │
│                  (PSB + PDCA Integration)                       │
│                                                                 │
│  ╔═══════════════════════════════════════════════════════════╗ │
│  ║  PSB System (環境準備)                                     ║ │
│  ║  Plan (目標) → Setup (環境) → Build (執行)                 ║ │
│  ╚═══════════════════════════════════════════════════════════╝ │
│                            ↓                                    │
│    ┌──────────┐                                                │
│    │   Goal   │  ← Phase 1: Goal Analysis                      │
│    └────┬─────┘                                                │
│         ↓                                                       │
│    ┌──────────────┐                                            │
│    │ Capability   │  ← Phase 1.5: Assess what you know vs need │
│    │ Assessment   │                                            │
│    └──────┬───────┘                                            │
│           ↓                                                     │
│    ┌──────────────┐     ┌──────────────┐                       │
│    │ Skill        │ ──→ │   Verify     │  ← Integrate skillpkg │
│    │ Acquisition  │     │   Learning   │                       │
│    └──────────────┘     └──────┬───────┘                       │
│         ↓                      ↓                               │
│  ╔═══════════════════════════════════════════════════════════╗ │
│  ║  PDCA Cycle                                                ║ │
│  ║  Plan → Do → Check → Act → (repeat)                        ║ │
│  ║       ↑                  │                                 ║ │
│  ║       └── Multi-Strategy ←┘                                ║ │
│  ╚═══════════════════════════════════════════════════════════╝ │
│                            │                                    │
│                     ┌──────▼───────┐                            │
│                     │ Repo-based   │  ← .github/memory/         │
│                     │ Memory       │    Git version controlled  │
│                     └──────────────┘                            │
│                                                                 │
│    Repeat until: Goal achieved OR max iterations reached       │
└─────────────────────────────────────────────────────────────────┘
```

## Documentation

- [SKILL.md](./SKILL.md) - Complete skill definition and instructions
- [USAGE.md](./USAGE.md) - Detailed usage guide with examples

## Stop Conditions

| Condition | Action |
|-----------|--------|
| All sub-goals completed | Success - End |
| Max iterations (10) reached | Pause and report |
| 3 consecutive same errors | Pause and ask user |
| User manual stop | Save progress and exit |

## Memory System (Repo-based)

The agent uses **Git-versioned markdown files** in `.github/memory/` as its memory layer - zero external dependencies, Git version controlled, team shareable.

### Memory Architecture

```
📁 .github/memory/
├── index.md          ← Quick index (auto-maintained)
├── learnings/        ← Knowledge: solutions, best practices
├── decisions/        ← ADR: architecture decision records
├── failures/         ← Failures: lessons learned, pitfalls
├── patterns/         ← Reasoning: reusable thinking patterns
└── strategies/       ← Strategies: task-specific strategy pools
```

| Layer | Purpose | Storage |
|-------|---------|---------|
| Learnings | Solutions, best practices | `.github/memory/learnings/` |
| Decisions | Architecture decisions (ADR) | `.github/memory/decisions/` |
| Failures | Lessons learned, pitfalls | `.github/memory/failures/` |
| Patterns | Reusable reasoning patterns | `.github/memory/patterns/` |
| Strategies | Task-specific strategy pools | `.github/memory/strategies/` |
| Session | Current context, temp data | Conversation |

### Repo-based Memory Advantages

- ✅ Git version control - track history, rollback changes
- ✅ Cross-tool sharing - Claude Code ↔ Copilot ↔ Cursor
- ✅ Offline available - no external services required
- ✅ Team collaboration - PR review memory changes
- ✅ Fast Grep search - standard tools work
- ✅ Project portable - memory travels with repo

## References

- [Reflexion Paper](https://arxiv.org/abs/2303.11366)
- [OpenAI Self-Evolving Agents Cookbook](https://cookbook.openai.com/examples/partners/self_evolving_agents/autonomous_agent_retraining)
- [Andrew Ng - Agentic Design Patterns](https://www.deeplearning.ai/the-batch/agentic-design-patterns-part-2-reflection/)

## License

MIT
