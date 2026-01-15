# Checkpoint 1: 任務開始前 - 主動查 Memory

> 🚨 **強制檢查點** - 不可跳過

## 規則

🔍 **任務開始前（強制）**

執行任何任務前，必須先搜尋相關經驗：
- [ ] 搜尋相關記憶（優先 Memory MCP，回退 Grep）
- [ ] 搜尋失敗經驗（避免重複踩坑）
- [ ] 有找到 → 閱讀並應用
- [ ] 沒找到 → 記錄「無相關經驗」，繼續執行

❌ **禁止**：不查 memory 就開始執行
✅ **必須**：每個任務開始前都執行搜尋

## 搜尋方式

### 方式一：Memory MCP（推薦）

若 Memory MCP 可用，使用 FTS5 全文搜尋（更快、更精確）：

```python
# 1. 搜尋相關記憶
memory_search({
    "query": "關鍵字1 OR 關鍵字2",  # 支援 FTS5 語法
    "scope": "global",               # 跨專案搜尋
    "limit": 10
})

# 2. 搜尋類似失敗經驗
failure_search({
    "query": "可能的錯誤類型",
    "limit": 5
})
```

**FTS5 搜尋語法**：
- `word1 word2` - 同時包含
- `word1 OR word2` - 任一包含
- `"exact phrase"` - 精確匹配

### 方式二：Grep（回退方案）

若 Memory MCP 不可用：

```python
# 使用 Grep 工具搜尋
Grep(
    pattern="關鍵字1|關鍵字2",
    path=".claude/memory/",
    output_mode="files_with_matches"
)

# 找到後讀取內容
Read(file_path=".claude/memory/learnings/xxx.md")
```

## 為什麼重要

1. **避免重複踩坑** - 過去的失敗經驗能防止再次犯錯
2. **加速執行** - 過去成功的方法可以直接複用
3. **持續改進** - 每次都站在過去經驗的基礎上
4. **跨專案學習** - Memory MCP 自動共享所有專案經驗
