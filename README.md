# Self-Evolving Agent

> A Claude Code skill that enables autonomous goal achievement through iterative learning and self-improvement.

```
Goal → Assess Capabilities → Acquire Skills → Execute → Diagnose → Multi-Strategy Retry → Structured Memory → Until Success
```

## Features

- **Zero External Dependencies** - Works out of the box, no MCP installation required
- **Capability Boundary Awareness** - Self-assess what you know vs. what you need to learn
- **Knowledge Auto-Acquisition** - Use WebSearch + Context7 to learn new knowledge on-demand
- **Failure Mode Diagnosis** - Classify failures (5 types) and apply targeted fixes
- **Multi-Strategy Mechanism** - Never repeat failed strategies, maintain a strategy pool
- **Local File Memory** - Store experiences in searchable local files (.claude/memory/)
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
│                  Self-Evolving Loop v3.0                       │
│                                                                 │
│    ┌──────────┐                                                │
│    │   Goal   │                                                │
│    └────┬─────┘                                                │
│         ↓                                                       │
│    ┌──────────────┐                                            │
│    │ Capability   │  ← Assess what you know vs. need           │
│    │ Assessment   │                                            │
│    └──────┬───────┘                                            │
│           ↓                                                     │
│    ┌──────────────┐     ┌──────────────┐                       │
│    │ Skill        │ ──→ │   Verify     │  ← Integrate skillpkg │
│    │ Acquisition  │     │   Learning   │                       │
│    └──────────────┘     └──────┬───────┘                       │
│         ↓                      ↓                               │
│    ┌──────────┐     ┌──────────┐     ┌──────────────┐          │
│    │   Plan   │ ──→ │    Do    │ ──→ │    Check     │          │
│    └──────────┘     └──────────┘     └──────┬───────┘          │
│         ↑                                    │                  │
│         │           ┌──────────────┐         │                  │
│         └────────── │ Multi-Strategy│ ←──────┘                 │
│                     │ Selection     │                           │
│                     └──────┬───────┘                            │
│                            │                                    │
│                     ┌──────▼───────┐                            │
│                     │ Structured   │  ← Searchable experience  │
│                     │ Memory       │                            │
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

## Memory System (Local Files)

The agent uses **local markdown files** as its memory layer - zero external dependencies, pure file-based storage.

### Memory Architecture

```
📁 .claude/memory/
├── experiences.md    ← Solutions, failures, lessons learned
├── strategies.md     ← Strategy tracking, success rates
└── learnings.md      ← New skills, discoveries, notes
```

| Layer | Purpose | Storage |
|-------|---------|---------|
| Experiences | Solutions, best practices, failures | `.claude/memory/experiences.md` |
| Strategies | Strategy tracking, improvements | `.claude/memory/strategies.md` |
| Learnings | New knowledge, discoveries | `.claude/memory/learnings.md` |
| Session | Current context, temp data | Conversation |

### Local Memory Advantages

- ✅ Zero external dependencies (no MCP required)
- ✅ Pure text format (Git-friendly, easy backup)
- ✅ Fast Grep search across all memories
- ✅ Copy to any project instantly

## References

- [Reflexion Paper](https://arxiv.org/abs/2303.11366)
- [OpenAI Self-Evolving Agents Cookbook](https://cookbook.openai.com/examples/partners/self_evolving_agents/autonomous_agent_retraining)
- [Andrew Ng - Agentic Design Patterns](https://www.deeplearning.ai/the-batch/agentic-design-patterns-part-2-reflection/)

## License

MIT
