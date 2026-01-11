# 記憶操作指南

> 如何讀取、儲存、搜尋記憶

## 搜尋記憶

```python
# 搜尋學習記錄
Grep(
    pattern="ComfyUI",
    path=".claude/memory/learnings/",
    output_mode="files_with_matches"
)

# 搜尋失敗經驗（帶上下文）
Grep(
    pattern="memory leak|記憶體",
    path=".claude/memory/failures/",
    output_mode="content",
    C=3  # 顯示上下文
)

# 搜尋推理模式
Grep(
    pattern="節點載入",
    path=".claude/memory/patterns/"
)

# 全域搜尋（所有記憶）
Grep(
    pattern="關鍵字",
    path=".claude/memory/"
)
```

## 儲存學習記錄

```python
# 檔名格式：{date}-{slug}.md
Write(
    file_path=".claude/memory/learnings/2025-01-05-comfyui-rembg.md",
    content="""---
date: 2025-01-05
tags: [comfyui, rembg, 透明背景, 遊戲素材]
task: 生成透明背景遊戲道具
status: resolved
---

# ComfyUI 生成透明背景圖片

## 情境
需要批量生成遊戲道具圖片，要求 PNG 透明背景

## 問題
預設輸出有白色背景，不適合遊戲使用

## 解決方案
1. 安裝 ComfyUI-Manager
2. 搜尋並安裝 RemBG 節點
3. 在工作流程最後加入 RemBG 節點
4. 輸出格式設為 PNG

## 驗證
✅ 成功生成透明背景圖片

## 注意事項
- 需要 4GB+ GPU 記憶體
- 處理速度約 2秒/張
"""
)

# ⚠️ 重要：立即更新 index.md（Checkpoint 3.5）
Edit(
    file_path=".claude/memory/index.md",
    old_string="<!-- LEARNINGS_START -->",
    new_string="""<!-- LEARNINGS_START -->
- [ComfyUI 透明背景](learnings/2025-01-05-comfyui-rembg.md) - comfyui, rembg"""
)
```

## 儲存失敗經驗

```python
Write(
    file_path=".claude/memory/failures/2025-01-05-comfyui-memory-leak.md",
    content="""---
date: 2025-01-05
tags: [comfyui, memory-leak, gpu]
task: 批量生成圖片
status: unresolved
---

# ComfyUI 批量生成時記憶體洩漏

## 症狀
批量生成到第 5 張圖片時 GPU 記憶體耗盡

## 嘗試過的方案
1. ❌ 降低解析度 → 只延後問題
2. ❌ 使用 fp16 → 仍然洩漏
3. ⏳ 每張圖後手動清理 → 待測試

## 根本原因
ComfyUI 節點沒有正確釋放中間張量

## 待解決
- [ ] 研究 ComfyUI 記憶體管理機制
- [ ] 嘗試 --lowvram 參數
"""
)
```

## 儲存策略記錄

```python
Write(
    file_path=".claude/memory/strategies/image-generation.md",
    content="""---
task_type: 圖片生成
last_updated: 2025-01-05
---

# 圖片生成策略池

## 策略列表

### S1: ComfyUI + RemBG (推薦)
- **優先級**: 1
- **適用**: 需要透明背景、批量生成
- **成功率**: 80%
- **需求**: GPU 4GB+, ComfyUI 環境

### S2: Stable Diffusion API
- **優先級**: 2
- **適用**: 無本地 GPU、需要穩定性
- **成功率**: 95%
- **需求**: API Key

## 策略選擇邏輯
1. 有 GPU → 優先 S1
2. 無 GPU 或 S1 失敗 → S2
"""
)
```

## 記錄模板

### 學習記錄模板

```yaml
---
date: "YYYY-MM-DD"
tags: [tag1, tag2]
task: "任務描述"
status: "resolved | unresolved | partial"
---

# 標題

## 情境
[背景描述]

## 問題
[具體問題]

## 解決方案
[詳細步驟]

## 驗證
✅ 成功 / ❌ 失敗

## 注意事項
[額外注意事項]
```

### 失敗記錄模板

```yaml
---
date: "YYYY-MM-DD"
tags: [tag1, tag2]
task: "任務描述"
status: "unresolved"
---

# 標題

## 症狀
[問題現象]

## 嘗試過的方案
1. ❌ 方案 A → 結果
2. ⏳ 方案 B → 待測試

## 根本原因
[分析結果]

## 待解決
- [ ] 下一步行動
```
