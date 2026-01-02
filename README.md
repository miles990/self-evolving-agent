# Self-Evolving Agent

> A Claude Code skill that enables autonomous goal achievement through iterative learning and self-improvement.

```
Goal → Assess Capabilities → Acquire Skills → Execute → Diagnose → Multi-Strategy Retry → Structured Memory → Until Success
```

## Features

- **Capability Boundary Awareness** - Self-assess what you know vs. what you need to learn
- **Skill Auto-Acquisition** - Integrate with skillpkg to search/install/load skills on-demand
- **Failure Mode Diagnosis** - Classify failures and apply targeted fixes
- **Multi-Strategy Mechanism** - Never repeat failed strategies, maintain a strategy pool
- **Structured Experience** - Store experiences in a searchable format for future retrieval
- **Learning Verification** - Verify skills are actually learned before applying them

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
│                  Self-Evolving Loop v2.1                       │
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

## Memory Integration (Cipher MCP)

The agent uses **Cipher** as its memory layer - an opensource memory system designed for coding agents.

### Dual Memory Architecture

| Layer | Purpose | Tool |
|-------|---------|------|
| System 1: Knowledge | Codebase knowledge, solutions, best practices | `cipher_memory_search`, `cipher_extract_and_operate_memory` |
| System 2: Reflection | Reasoning patterns, problem-solving strategies | `cipher_store_reasoning_memory`, `cipher_search_reasoning_patterns` |
| Session | Current context, temporary data | Conversation |

### Cipher Advantages

- ✅ Cross-IDE sync (Cursor ↔ VS Code ↔ Claude Code)
- ✅ Team shared memory (Workspace Memory)
- ✅ Auto-learns development patterns
- ✅ Zero configuration

### Installation

```bash
npm install -g @byterover/cipher
```

Add to `.mcp.json`:
```json
{
  "mcpServers": {
    "cipher": {
      "command": "cipher",
      "args": ["--mode", "mcp"]
    }
  }
}
```

## References

- [Reflexion Paper](https://arxiv.org/abs/2303.11366)
- [OpenAI Self-Evolving Agents Cookbook](https://cookbook.openai.com/examples/partners/self_evolving_agents/autonomous_agent_retraining)
- [Andrew Ng - Agentic Design Patterns](https://www.deeplearning.ai/the-batch/agentic-design-patterns-part-2-reflection/)

## License

MIT
