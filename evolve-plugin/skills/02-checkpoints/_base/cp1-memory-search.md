# Checkpoint 1: 任務開始前 - 主動查 Memory

> 🚨 **強制檢查點** - 不可跳過

## 規則

🔍 **任務開始前（強制）**

執行任何任務前，必須先搜尋相關經驗：
- [ ] `Grep(pattern="關鍵字", path=".claude/memory/")`
- [ ] 有找到 → 閱讀並應用
- [ ] 沒找到 → 記錄「無相關經驗」，繼續執行

❌ **禁止**：不查 memory 就開始執行
✅ **必須**：每個任務開始前都執行搜尋

## 搜尋範例

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
