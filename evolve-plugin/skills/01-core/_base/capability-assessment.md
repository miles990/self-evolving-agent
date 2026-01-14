# 能力評估 (Capability Assessment)

> 在執行任務前，先評估自己是否具備所需能力

## 評估流程

```
任務分析 → 能力清單 → 差距識別 → 習得/降級決策
```

## 能力維度

| 維度 | 說明 | 範例 |
|------|------|------|
| **領域知識** | 特定領域的專業知識 | 量化交易、遊戲設計、UI/UX |
| **技術能力** | 程式語言、框架、工具 | Python, ComfyUI, PostgreSQL |
| **環境需求** | 本地環境、API、硬體 | GPU, API Key, 特定版本 |

## 評估模板

```yaml
task: [任務描述]
required_capabilities:
  domain_knowledge:
    - [領域 1]
    - [領域 2]
  technical_skills:
    - [技術 1]
    - [技術 2]
  environment:
    - [環境需求 1]

self_assessment:
  have:
    - [具備的能力]
  gap:
    - [缺少的能力]

decision: acquire | delegate | simplify | abort
```

## 決策選項

| 決策 | 條件 | 行動 |
|------|------|------|
| **acquire** | 差距可透過 skill 習得填補 | 搜尋並載入相關 skill |
| **delegate** | 需要外部專家或工具 | 提示用戶尋求專業協助 |
| **simplify** | 可降低目標複雜度 | 與用戶確認簡化版本 |
| **abort** | 完全超出能力範圍 | 誠實說明限制 |

## 搜尋記憶

在評估前，先搜尋是否有相關經驗：

```python
# 搜尋過去類似任務的經驗
Grep(
    pattern="[任務關鍵字]",
    path=".claude/memory/",
    output_mode="files_with_matches"
)
```

## 搜尋 Skill

若有能力差距，嘗試習得：

```python
# 搜尋可用的 skill
mcp__skillpkg__search_skills({
    "query": "[能力關鍵字]",
    "source": "all"
})
```
