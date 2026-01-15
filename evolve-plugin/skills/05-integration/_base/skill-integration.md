# Skill 整合（Plugin 方式）

> 使用 Claude Code Plugin 系統搜尋、安裝、載入 skills

## 基本操作

### 搜尋 Skill

```bash
# 在 Claude Code 中使用
/plugin
# → 選擇 Discover tab 瀏覽可用 skills

# 或使用 WebSearch 工具
WebSearch({ query: "Claude Code skill flame game flutter" })
```

### 安裝 Skill

```bash
# 從官方 Marketplace 安裝
/plugin install {skill-name}@{marketplace-name}

# 範例：安裝 document-skills
/plugin install document-skills@anthropic-agent-skills

# 範例：安裝 evolve
/plugin marketplace add miles990/evolve-plugin
/plugin install evolve@evolve-plugin
```

### 載入 Skill

Skills 安裝後會自動載入。只需在對話中提及 skill 名稱，Claude 會自動識別並載入。

```
# 使用 Skill 工具載入
Skill({ skill: "skill-name" })
```

### 查看已安裝

```bash
# 在 Claude Code 中
/plugin
# → 選擇 Manage tab 查看已安裝的 plugins/skills
```

## 自動領域識別流程

```
用戶任務：「幫我建立一個量化交易回測系統」
                    ↓
Step 1: 搜尋相關 skills
        WebSearch({ query: "quant trading Claude skill" })
        或 /plugin → Discover
                    ↓
Step 2: 安裝推薦的 skill
        /plugin install quant-trading@{marketplace}
                    ↓
Step 3: 使用 Skill
        Skill({ skill: "quant-trading" })
                    ↓
Step 4: 帶著領域知識執行任務
```

## 推薦 Skill 來源

| Marketplace | 說明 |
|-------------|------|
| `anthropic-agent-skills` | 官方 Anthropic skills |
| `miles990/evolve-plugin` | Self-Evolving Agent |
| `miles990/claude-software-skills` | 軟體開發技術 |
| `miles990/claude-domain-skills` | 非技術領域知識 |

## 研究模式

當整體信心度 < 50% 時，自動進入研究模式：

```
overall_confidence: 0.35 (< 0.5 閾值)
research_mode: true
research_suggestions:
  • WebSearch 搜尋 skill 或最佳實踐
  • Context7 查詢技術文檔
  • 詢問用戶澄清具體需求

→ 不盲目執行，先補充知識再繼續
```

## SKILL.md 格式

```yaml
---
name: skill-name
version: "1.0.0"
description: 技能描述
triggers: [觸發詞1, 觸發詞2]
keywords: [關鍵字1, 關鍵字2]
---

# Skill 標題

## 說明
[技能內容...]
```

## 與 evolve 整合

技能習得流程：

1. **識別缺口** - 「我無法完成 X 因為我不知道 Y」
2. **搜尋記憶** - `Grep(pattern="Y", path=".claude/memory/")`
3. **搜尋 Skill** - WebSearch 或 `/plugin` Discover tab
4. **安裝** - `/plugin install {skill}@{marketplace}`
5. **載入** - `Skill({ skill: "..." })` 或直接提及 skill 名稱
6. **驗證** - 用簡單任務測試
7. **記錄** - 寫入 .claude/memory/learnings/
