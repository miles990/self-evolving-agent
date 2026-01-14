# Checkpoint 3.5: Memory 同步

> 創建 Memory 文件後，**立即**同步 index.md

## 觸發時機

當執行以下操作後：
- Write 到 `.claude/memory/learnings/*.md`
- Write 到 `.claude/memory/failures/*.md`
- Write 到 `.claude/memory/decisions/*.md`
- Write 到 `.claude/memory/patterns/*.md`

## 強制步驟

```
Step 1: Write memory file
        ↓
Step 2: Edit index.md (添加條目)
        ↓
Step 3: Verify (確認 index.md 已更新)
```

## 範例

```python
# Step 1: 創建 memory 文件
Write(
    file_path=".claude/memory/learnings/2026-01-11-new-learning.md",
    content="..."
)

# Step 2: 立即更新 index.md（不可省略！）
Edit(
    file_path=".claude/memory/index.md",
    old_string="<!-- LEARNINGS_START -->",
    new_string="<!-- LEARNINGS_START -->\n- [New Learning](learnings/2026-01-11-new-learning.md) - tag1, tag2"
)

# Step 3: 驗證
Read(file_path=".claude/memory/index.md")
```

## 常見錯誤

| 錯誤 | 後果 | 預防 |
|------|------|------|
| 忘記更新 index | 記憶無法被搜尋到 | Write 後立即 Edit |
| 批次更新 index | 可能遺漏某些條目 | 每個 Write 配對一個 Edit |
| index 格式錯誤 | 破壞索引結構 | 使用標準格式 |

## 背景

此檢查點源自 evolve-trader 專案的實際失敗經驗：
- 創建多個 memory 文件後忘記更新 index.md
- 用戶反饋：「我看 .claude/memory 沒有新的紀錄」
- 根本原因：儲存與索引是兩個分離的動作，容易忽略後者
