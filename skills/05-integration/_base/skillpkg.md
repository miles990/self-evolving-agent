# skillpkg 整合

> 使用 skillpkg MCP 自動搜尋、安裝、載入 skills

## 基本操作

### 搜尋 Skill

```python
# 按關鍵字搜尋
mcp__skillpkg__search_skills({
    "query": "ComfyUI game assets",
    "source": "all"  # all, local, github
})

# 獲得推薦
mcp__skillpkg__recommend_skill({
    "query": "如何生成遊戲道具圖片",
    "criteria": "popular"  # auto, popular, highest_rated, newest
})
```

### 安裝 Skill

```python
# 從 GitHub 安裝
mcp__skillpkg__install_skill({
    "source": "github:user/repo",
    "scope": "local"  # local (專案) 或 global (~/.skillpkg)
})

# 從 URL 安裝
mcp__skillpkg__install_skill({
    "source": "https://example.com/SKILL.md"
})
```

### 載入 Skill

```python
# 載入已安裝的 skill
mcp__skillpkg__load_skill({
    "id": "skill-name"
})

# 載入後會獲得 skill 的完整 instructions
```

### 查看已安裝

```python
# 列出所有已安裝的 skills
mcp__skillpkg__list_skills({
    "scope": "all"  # local, global, all
})

# 查看特定 skill 資訊
mcp__skillpkg__skill_info({
    "name": "skill-name"
})
```

## 自動領域識別流程

```
用戶任務：「幫我建立一個量化交易回測系統」
                    ↓
Step 1: recommend_skills({ goal: "量化交易回測系統" })
        → 分析關鍵詞：量化、交易、回測
                    ↓
Step 2: 獲得推薦結果
        domain_skills: quant-trading (85% confidence)
        software_skills: python, database
                    ↓
Step 3: 自動載入
        load_skill("quant-trading")
        load_skill("python")
                    ↓
Step 4: 帶著領域知識執行任務
```

## 研究模式

當整體信心度 < 50% 時，自動進入研究模式：

```
overall_confidence: 0.35 (< 0.5 閾值)
research_mode: true
research_suggestions:
  • 搜尋外部 skill 倉庫
  • Web 搜尋最佳實踐
  • 詢問用戶澄清具體需求

→ 不盲目執行，先補充知識再繼續
```

## SKILL.md 格式

```yaml
---
schema: "1.0"
name: skill-name
version: "1.0.0"
description: 技能描述
triggers: [觸發詞1, 觸發詞2, trigger1, trigger2]
keywords: [關鍵字1, 關鍵字2]
dependencies:
  - other-skill
---

# Skill 標題

## 說明
[技能內容...]
```

## 與 evolve 整合

技能習得流程：

1. **識別缺口** - 「我無法完成 X 因為我不知道 Y」
2. **搜尋記憶** - `Grep(pattern="Y", path=".claude/memory/")`
3. **搜尋 Skill** - `recommend_skill({ query: "Y" })`
4. **安裝** - `install_skill({ source: "..." })`
5. **載入** - `load_skill({ id: "..." })`
6. **驗證** - 用簡單任務測試
7. **記錄** - 寫入 .claude/memory/learnings/
