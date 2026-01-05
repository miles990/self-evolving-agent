---
name: evolve
version: 3.1.0
description: 自我進化 Agent：給定目標，自主學習並迭代改進直到完成。觸發詞：evolve、進化、自我學習、迭代改進、達成目標。
---
# Self-Evolving Agent v3.1

> 給定目標 → 評估能力 → 習得技能 → 執行 → 診斷 → 多策略重試 → Repo 記憶 → 直到成功

## 核心理念

```
┌─────────────────────────────────────────────────────────────────┐
│                  Self-Evolving Loop v3.1                        │
│                                                                 │
│    ┌──────────┐                                                │
│    │   目標   │                                                │
│    └────┬─────┘                                                │
│         ↓                                                       │
│    ┌──────────────┐                                            │
│    │ 能力邊界評估 │  ← 先評估自己會什麼、缺什麼                │
│    └──────┬───────┘                                            │
│           ↓                                                     │
│    ┌──────────────┐     ┌──────────────┐                       │
│    │ Skill 習得   │ ──→ │   驗證學習   │                       │
│    │ (recommend/  │     │   (簡單測試) │                       │
│    │  install)    │     └──────┬───────┘                       │
│    └──────────────┘            ↓                               │
│         ↓                                                       │
│    ┌──────────┐     ┌──────────┐     ┌──────────────┐          │
│    │   Plan   │ ──→ │    Do    │ ──→ │    Check     │          │
│    │  (規劃)  │     │  (執行)  │     │  (失敗診斷)  │          │
│    └──────────┘     └──────────┘     └──────┬───────┘          │
│         ↑                                    │                  │
│         │           ┌──────────────┐         │                  │
│         └────────── │ 多策略選擇   │ ←───────┘                  │
│                     │ (策略池機制) │                            │
│                     └──────┬───────┘                            │
│                            │                                    │
│                     ┌──────▼───────┐                            │
│                     │  Repo-based  │  ← v3.0: Git 版本控制記憶  │
│                     │    Memory    │                            │
│                     └──────────────┘                            │
│                                                                 │
│    重複直到：目標達成 或 達到最大迭代次數                       │
└─────────────────────────────────────────────────────────────────┘
```

## v3.0 更新重點

| 能力 | 說明 |
|------|------|
| **Repo-based Memory** | 記憶存於 `.github/memory/`，Git 版本控制，跨工具共享 |
| **Skill 自動習得** | 整合 skillpkg MCP，自動搜尋/安裝/載入 skills |
| **失敗模式診斷** | 分類失敗類型，針對性處理 |
| **能力邊界感知** | 執行前評估自己會什麼、缺什麼 |
| **多策略嘗試** | 不重複同一策略，從策略池選擇 |
| **結構化經驗** | Markdown 格式，可用 Grep 檢索 |

## 使用方式

```
觸發詞：/evolve [目標描述]

範例：
/evolve 建立一個能自動生成遊戲道具圖片的 ComfyUI 工作流程
/evolve 優化這段程式碼的效能，目標是降低 50% 執行時間
/evolve 為這個專案建立完整的測試覆蓋率達到 80%
```

---

## Phase 0: 初始化記憶系統

首次使用時，檢查並建立記憶目錄結構：

```bash
# 檢查記憶目錄是否存在
ls .github/memory/ 2>/dev/null || echo "需要初始化"
```

若不存在，建立以下結構：

```
.github/memory/
├── index.md              # 快速索引（必須維護）
├── learnings/            # 學習記錄
│   └── .gitkeep
├── decisions/            # 決策記錄 (ADR)
│   └── .gitkeep
├── failures/             # 失敗經驗
│   └── .gitkeep
├── patterns/             # 推理模式
│   └── .gitkeep
└── strategies/           # 策略記錄
    └── .gitkeep
```

**初始化 index.md 模板：**

```markdown
# 專案記憶索引

> 自動維護，請勿手動編輯主要區塊

## 最近學習
<!-- LEARNINGS_START -->
<!-- LEARNINGS_END -->

## 重要決策
<!-- DECISIONS_START -->
<!-- DECISIONS_END -->

## 失敗經驗
<!-- FAILURES_START -->
<!-- FAILURES_END -->

## 推理模式
<!-- PATTERNS_START -->
<!-- PATTERNS_END -->

## 標籤索引
<!-- TAGS_START -->
<!-- TAGS_END -->
```

---

## Phase 1: 目標分析

```markdown
0. 目標明確性檢查（優先執行）
   ┌─────────────────────────────────────────────────────────┐
   │  檢查項目：                                             │
   │  □ 有具體的成功標準嗎？                                │
   │  □ 有可量化的驗收條件嗎？                              │
   │  □ 範圍是否明確？                                      │
   │  □ 有技術/資源約束嗎？                                 │
   │  □ 有時間/品質偏好嗎？                                 │
   └─────────────────────────────────────────────────────────┘

   若有 ≥2 項不明確 → 使用 AskUserQuestion 確認
   若只有 1 項不明確 → 用【假設】補齊，列出假設內容
   若全部明確 → 直接進入目標解析

1. 解析目標
   - 最終成功標準是什麼？
   - 如何驗證目標達成？
   - 有哪些約束條件？

2. 分解子目標
   - 將大目標拆成可執行的步驟
   - 識別依賴關係
   - 設定每個步驟的驗收標準

3. 評估現有能力
   - 需要哪些技能/工具？
   - 哪些已具備？哪些需要學習？
```

### 目標確認問卷（使用 AskUserQuestion）

當目標不明確時，**一次收齊**關鍵資訊：

```markdown
┌─────────────────────────────────────────────────────────────────┐
│  ❓ 需要確認目標細節                                           │
│                                                                 │
│  您的目標：[用戶輸入的原始目標]                                 │
│                                                                 │
│  請幫我確認以下幾點：                                           │
│                                                                 │
│  1. 成功標準                                                    │
│     □ 能正常運作即可                                           │
│     □ 需要特定效能指標（請說明）                               │
│     □ 需要通過測試/驗收條件（請說明）                          │
│                                                                 │
│  2. 範圍限制                                                    │
│     □ 只處理核心功能                                           │
│     □ 需要完整實作（含邊界情況）                               │
│     □ 需要考慮擴展性                                           │
│                                                                 │
│  3. 品質 vs 速度                                                │
│     □ 快速完成優先（可接受後續優化）                           │
│     □ 品質優先（寧可慢也要做好）                               │
│     □ 平衡                                                     │
│                                                                 │
│  4. 其他約束                                                    │
│     □ 無特別限制                                               │
│     □ 有（請說明：技術棧/相容性/資源限制）                     │
└─────────────────────────────────────────────────────────────────┘
```

### 不明確目標範例

| 用戶輸入 | 缺少的資訊 | 需要確認 |
|----------|------------|----------|
| 「優化效能」 | 優化什麼？目標數值？ | ✅ |
| 「做一個網站」 | 什麼功能？什麼風格？ | ✅ |
| 「修好這個 bug」 | bug 現象？預期行為？ | ✅ |
| 「把這段程式碼重構成 TypeScript，要有型別定義」 | 全部明確 | ❌ |
| 「建立登入功能，要有 JWT 和刷新 token」 | 全部明確 | ❌ |

---

## Phase 1.5: 能力邊界評估

執行任務前，先進行自我能力評估。以下是評估時使用的**思考框架**：

```yaml
# ========================================
# 能力評估思考框架（範例，實際內容依任務而定）
# ========================================
task: "[分析用戶的任務後填入]"

capability_assessment:
  # 確定會的（根據實際情況填寫）
  confident_in:
    - skill: "[技能名稱]"
      level: "熟練 / 基本 / 略知"

  # 不確定的
  uncertain_about:
    - skill: "[技能名稱]"
      reason: "[為什麼不確定]"

  # 確定需要學習的
  definitely_need:
    - "[需要的技能或知識]"

  # 行動計劃
  action_plan:
    - step: "[下一步行動]"
      tool: "[使用的工具]"
```

**範例**（當任務是「用 ComfyUI 生成遊戲道具」時）：
```yaml
task: "用 ComfyUI 生成遊戲道具圖片"

capability_assessment:
  confident_in:
    - skill: "Python 程式設計"
      level: "熟練"
  uncertain_about:
    - skill: "ComfyUI 工作流程"
      reason: "從未使用過"
  definitely_need:
    - "ComfyUI 節點操作知識"
  action_plan:
    - step: "搜尋過去經驗"
      tool: "Grep .github/memory/"
    - step: "搜尋 ComfyUI 相關 skill"
      tool: "recommend_skill"
```

**評估流程：**
```
任務分析 → 列出需要的能力 → 自評每項能力
    ↓
┌───────────────────────────────────────────┐
│  對於每項「不確定」或「確定需要」的能力：  │
│                                           │
│  1. Grep 搜尋 .github/memory/ 查找經驗    │
│  2. 沒有經驗 → recommend_skill 搜尋       │
│  3. 找到 skill → install + verify        │
│  4. 驗證通過 → 加入 confident_in         │
└───────────────────────────────────────────┘
    ↓
所有關鍵能力都在 confident_in → 開始執行
```

---

## Phase 2: 執行循環（PDCA）

每個子目標執行以下循環：

```markdown
┌─ Plan（規劃）─────────────────────────────────────────┐
│  - 制定具體執行計劃                                   │
│  - 預測可能的問題                                     │
│  - 準備備選方案                                       │
└───────────────────────────────────────────────────────┘
                          ↓
┌─ Do（執行）───────────────────────────────────────────┐
│  - 按計劃執行                                         │
│  - 記錄執行過程                                       │
│  - 收集中間結果                                       │
└───────────────────────────────────────────────────────┘
                          ↓
┌─ Check（評估）────────────────────────────────────────┐
│  - 結果是否符合預期？                                 │
│  - 如果失敗，分析原因                                 │
│  - 評估：完全成功 / 部分成功 / 失敗                  │
└───────────────────────────────────────────────────────┘
                          ↓
┌─ Act（改進）──────────────────────────────────────────┐
│  如果成功：                                           │
│  - 記錄成功經驗到 .github/memory/learnings/           │
│  - 更新 index.md                                      │
│  - 進入下一個子目標                                   │
│                                                       │
│  如果失敗：                                           │
│  - 反思：為什麼失敗？                                 │
│  - 學習：需要什麼新知識/技能？                       │
│  - 搜索：查找相關資料                                 │
│  - 更新：改進執行策略                                 │
│  - 記錄失敗到 .github/memory/failures/                │
│  - 重試：帶著新知識重新執行                           │
└───────────────────────────────────────────────────────┘
```

---

## Phase 3: 反思與學習（Reflexion）

```markdown
每次失敗後的反思流程：

1. 失敗分析
   - 錯誤類型是什麼？（邏輯/語法/環境/理解）
   - 根本原因是什麼？
   - 是否遺漏了什麼？

2. 知識補充
   - 需要學習什麼？
   - 使用 WebSearch 搜索相關資料
   - 閱讀文檔或範例

3. 策略調整
   - 原策略哪裡有問題？
   - 新策略是什麼？
   - 如何避免同樣的錯誤？

4. 記憶更新
   - 將學到的經驗寫入 .github/memory/
   - 格式：[情境] → [錯誤] → [解決方案]
   - 更新 index.md 索引
```

---

## Phase 4: 記憶系統 (Repo-based Memory)

```markdown
Repo-based 記憶架構：

┌─ .github/memory/learnings/ ──────────────────────────┐
│  知識記憶（Knowledge Memory）                         │
│  - Codebase 知識、業務邏輯                            │
│  - 成功的解決方案、最佳實踐                           │
│  - 過去的互動經驗                                     │
│  格式：{date}-{slug}.md                               │
│  搜尋：Grep pattern=關鍵字 path=.github/memory/       │
└───────────────────────────────────────────────────────┘

┌─ .github/memory/patterns/ ───────────────────────────┐
│  推理記憶（Reasoning Patterns）                       │
│  - AI 推理步驟和問題解決模式                          │
│  - 策略演進記錄                                       │
│  - 可複用的思考框架                                   │
│  格式：{category}-{name}.md                           │
│  搜尋：Grep pattern=模式名 path=.github/memory/patterns/│
└───────────────────────────────────────────────────────┘

┌─ .github/memory/failures/ ───────────────────────────┐
│  失敗記憶（Failure Memory）                           │
│  - 失敗的嘗試和原因                                   │
│  - 避免重複踩坑                                       │
│  格式：{date}-{slug}.md                               │
│  搜尋：Grep pattern=錯誤關鍵字 path=.github/memory/failures/│
└───────────────────────────────────────────────────────┘

┌─ .github/memory/decisions/ ──────────────────────────┐
│  決策記錄（ADR - Architecture Decision Records）      │
│  - 重要的技術決策                                     │
│  - 選擇原因和取捨                                     │
│  格式：{number}-{title}.md                            │
│  搜尋：Grep pattern=決策關鍵字 path=.github/memory/decisions/│
└───────────────────────────────────────────────────────┘

┌─ .github/memory/strategies/ ─────────────────────────┐
│  策略記錄（Strategy Memory）                          │
│  - 各種任務類型的策略池                               │
│  - 策略成功率統計                                     │
│  格式：{task-type}.md                                 │
│  搜尋：Grep pattern=策略名 path=.github/memory/strategies/│
└───────────────────────────────────────────────────────┘

Repo-based 優勢：
✓ Git 版本控制，可追溯歷史
✓ 跨工具共享（Claude Code ↔ Copilot ↔ Cursor）
✓ 離線可用，無需外部服務
✓ 團隊協作，PR 審核記憶變更
✓ 可用標準工具搜尋（Grep/Glob）
✓ 專案相關，隨 repo 遷移
```

---

## 記憶操作指南

### 搜尋記憶

```python
# 搜尋學習記錄
Grep(
    pattern="ComfyUI",
    path=".github/memory/learnings/",
    output_mode="files_with_matches"
)

# 搜尋失敗經驗
Grep(
    pattern="memory leak|記憶體",
    path=".github/memory/failures/",
    output_mode="content",
    C=3  # 顯示上下文
)

# 搜尋推理模式
Grep(
    pattern="節點載入",
    path=".github/memory/patterns/"
)

# 全域搜尋（所有記憶）
Grep(
    pattern="關鍵字",
    path=".github/memory/"
)
```

### 儲存學習記錄

```python
# 檔名格式：{date}-{slug}.md
Write(
    file_path=".github/memory/learnings/2025-01-05-comfyui-rembg.md",
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

## 相關檔案
- `workflows/game-assets.json`
"""
)

# 更新 index.md
Edit(
    file_path=".github/memory/index.md",
    old_string="<!-- LEARNINGS_START -->",
    new_string="""<!-- LEARNINGS_START -->
- [ComfyUI 透明背景](learnings/2025-01-05-comfyui-rembg.md) - comfyui, rembg, 遊戲素材"""
)
```

### 儲存失敗經驗

```python
Write(
    file_path=".github/memory/failures/2025-01-05-comfyui-memory-leak.md",
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

### 儲存推理模式

```python
Write(
    file_path=".github/memory/patterns/debug-node-loading.md",
    content="""---
category: debugging
name: 節點載入失敗診斷
applicable_to: [comfyui, node-based-tools]
---

# 節點載入失敗診斷模式

## 觸發條件
當遇到「節點載入失敗」、「模型未找到」等錯誤時

## 診斷步驟
1. 檢查檔案路徑是否正確
2. 確認檔案是否存在於預期目錄
3. 檢查節點類型是否匹配（如 LoraLoader vs Load LoRA）
4. 確認模型格式是否相容
5. 檢查是否缺少依賴節點

## 常見解決方案
- 重新安裝節點套件
- 檢查 models/ 目錄結構
- 使用 ComfyUI-Manager 重新載入

## 成功率
此模式解決問題的成功率：85%
"""
)
```

### 儲存策略記錄

```python
Write(
    file_path=".github/memory/strategies/image-generation.md",
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
- **失敗記錄**: 記憶體洩漏問題（待解決）

### S2: Stable Diffusion API
- **優先級**: 2
- **適用**: 無本地 GPU、需要穩定性
- **成功率**: 95%
- **需求**: API Key, 網路連線
- **缺點**: 費用較高

### S3: DALL-E + 後處理
- **優先級**: 3
- **適用**: 快速原型、概念驗證
- **成功率**: 90%
- **需求**: OpenAI API Key
- **缺點**: 風格控制較弱

## 策略選擇邏輯
1. 有 GPU → 優先 S1
2. 無 GPU 或 S1 失敗 → S2
3. 需要快速出結果 → S3
"""
)
```

---

## 自我進化機制

### 1. 技能習得（整合 skillpkg MCP）

```markdown
當遇到無法完成的任務時：

┌─────────────────────────────────────────────────────────────────┐
│  技能習得流程 v3.0                                              │
│                                                                 │
│  1. 識別技能缺口                                                │
│     - 「我無法完成 X 因為我不知道如何 Y」                       │
│     - 區分：缺「知識」還是缺「工具」                            │
│                                                                 │
│  2. 搜尋已有經驗（Repo Memory）                                 │
│     Grep(pattern="Y", path=".github/memory/")                   │
│     - 有經驗 → 直接應用                                         │
│     - 無經驗 → 繼續步驟 3                                       │
│                                                                 │
│  3. 搜尋可用 Skill                                              │
│     recommend_skill({ query: "Y", criteria: "popular" })        │
│     - 評估推薦的 skill 是否適用                                 │
│     - 查看 alternatives 比較選擇                                │
│                                                                 │
│  4. 安裝 Skill                                                  │
│     install_skill({ source: "best-skill-name" })                │
│     - 從 Registry / GitHub / URL 安裝                           │
│                                                                 │
│  5. 載入並學習                                                  │
│     load_skill({ id: "best-skill-name" })                       │
│     - 仔細閱讀 instructions                                     │
│     - 理解使用方式和限制                                        │
│                                                                 │
│  6. 驗證學習                                                    │
│     - 用簡單任務測試是否學會                                    │
│     - 成功 → 應用到實際任務                                     │
│     - 失敗 → 重新學習或換 skill                                 │
│                                                                 │
│  7. 記錄學習經驗                                                │
│     Write(.github/memory/learnings/{date}-{skill}.md)           │
│     - 記錄情境 + skill + 效果                                   │
│     - 更新 index.md                                             │
└─────────────────────────────────────────────────────────────────┘
```

**Skill 習得範例：**
```
任務：用 ComfyUI 生成遊戲道具

1. 識別缺口：不會 ComfyUI
2. Grep(pattern="ComfyUI", path=".github/memory/") → 無結果
3. recommend_skill({ query: "ComfyUI game assets" })
   → 推薦：comfyui-expert (⭐4.9, 2.1k downloads)
4. install_skill({ source: "comfyui-expert" })
   → 安裝成功
5. load_skill({ id: "comfyui-expert" })
   → 學習 instructions
6. 驗證：生成一張簡單測試圖
   → 成功！
7. Write(.github/memory/learnings/2025-01-05-comfyui-expert.md)
   → 記錄經驗
```

### 2. 失敗模式診斷

失敗時先分類，再針對性處理：

```
┌─────────────────────────────────────────────────────────────────┐
│  失敗類型分類表                                                 │
│                                                                 │
│  類型 A: 知識缺口                                               │
│  ├─ 症狀：不知道怎麼做、沒見過這種問題                         │
│  ├─ 診斷：缺少領域知識或工具使用經驗                           │
│  └─ 處方：recommend_skill → install → learn                    │
│                                                                 │
│  類型 B: 執行錯誤                                               │
│  ├─ 症狀：知道怎麼做但做錯了、語法錯誤、參數錯誤               │
│  ├─ 診斷：粗心或理解不完整                                     │
│  └─ 處方：重新閱讀文檔、仔細檢查參數                           │
│                                                                 │
│  類型 C: 環境問題                                               │
│  ├─ 症狀：依賴缺失、版本不符、權限不足                         │
│  ├─ 診斷：環境配置問題                                         │
│  └─ 處方：修復環境、安裝依賴、切換版本                         │
│                                                                 │
│  類型 D: 策略錯誤                                               │
│  ├─ 症狀：方法正確但不適合當前情境                             │
│  ├─ 診斷：選錯了解決方案                                       │
│  └─ 處方：切換到策略池中的其他策略                             │
│                                                                 │
│  類型 E: 資源限制                                               │
│  ├─ 症狀：記憶體不足、API 限制、時間超時                       │
│  ├─ 診斷：硬體或服務限制                                       │
│  └─ 處方：優化資源使用、分批處理、換用輕量方案                 │
└─────────────────────────────────────────────────────────────────┘
```

**診斷流程：**
```
失敗發生 → 收集錯誤訊息 → 分類失敗類型 → 選擇對應處方 → 執行修復
     │
     └─ 記錄到 .github/memory/failures/（避免重複踩坑）
```

### 3. 多策略機制

不重複嘗試同一個失敗策略，維護策略池進行智慧選擇：

```markdown
策略池結構（存於 .github/memory/strategies/{task-type}.md）：

┌─────────────────────────────────────────────────────────────────┐
│  strategy_pool:                                                 │
│    current_task: "批量生成遊戲道具圖片"                         │
│                                                                 │
│    available_strategies:                                        │
│      - id: "s1"                                                 │
│        name: "ComfyUI + RemBG"                                  │
│        status: "untried"                                        │
│        priority: 1                                              │
│        requirements: ["comfyui", "rembg"]                       │
│                                                                 │
│      - id: "s2"                                                 │
│        name: "Stable Diffusion API + 透明背景模型"               │
│        status: "untried"                                        │
│        priority: 2                                              │
│        requirements: ["sd-api-key"]                             │
│                                                                 │
│      - id: "s3"                                                 │
│        name: "DALL-E + 後處理去背"                               │
│        status: "untried"                                        │
│        priority: 3                                              │
│        requirements: ["openai-key"]                             │
│                                                                 │
│    tried_strategies:                                            │
│      - id: "s1"                                                 │
│        result: "failed"                                         │
│        reason: "ComfyUI 安裝失敗"                               │
│        do_not_retry_until: "環境問題解決"                       │
└─────────────────────────────────────────────────────────────────┘

策略選擇邏輯：
1. 從 available_strategies 按 priority 排序
2. 跳過 status = "failed" 且 do_not_retry_until 未滿足的
3. 選擇第一個可行的策略
4. 如果所有策略都失敗 → 詢問用戶或搜尋新策略
```

### 4. 結構化經驗格式

經驗必須用可檢索的格式儲存：

```yaml
# .github/memory/learnings/{date}-{slug}.md 模板
---
date: "2025-01-05"
tags: [tag1, tag2, tag3]
task: "任務描述"
status: "resolved | unresolved | partial"
---

# 標題

## 情境
[描述遇到這個問題的背景]

## 問題
[具體的問題描述]
- 症狀 1
- 症狀 2

## 解決方案
[詳細的解決步驟]
1. 步驟一
2. 步驟二
3. 步驟三

## 驗證
[如何確認問題已解決]
✅ 成功 / ❌ 失敗

## 注意事項
[額外的注意事項或限制]

## 相關檔案
- `path/to/file1`
- `path/to/file2`
```

### 5. 學習驗證流程

安裝新 skill 後，必須驗證真的學會才能應用：

```
┌─────────────────────────────────────────────────────────────────┐
│  學習驗證流程                                                   │
│                                                                 │
│  1. 安裝 Skill                                                  │
│     install_skill({ source: "comfyui-expert" })                 │
│                                                                 │
│  2. 載入 Instructions                                           │
│     load_skill({ id: "comfyui-expert" })                        │
│                                                                 │
│  3. 設計簡單驗證任務                                            │
│     ┌─────────────────────────────────────┐                    │
│     │  驗證任務應該：                      │                    │
│     │  • 範圍小、可快速完成               │                    │
│     │  • 涵蓋核心能力                     │                    │
│     │  • 有明確的成功標準                 │                    │
│     └─────────────────────────────────────┘                    │
│                                                                 │
│  4. 執行驗證                                                    │
│     ┌─────────────────────────────────────┐                    │
│     │  例：生成一張簡單的測試圖片          │                    │
│     │      檢查是否符合預期格式           │                    │
│     └─────────────────────────────────────┘                    │
│                                                                 │
│  5. 評估結果                                                    │
│     ✅ 成功 → 加入 confident_in，繼續主任務                    │
│     ❌ 失敗 → 重新學習或嘗試其他 skill                         │
└─────────────────────────────────────────────────────────────────┘
```

### 6. 策略進化

```markdown
追蹤每種策略的成功率（存於 .github/memory/strategies/）：

策略選擇邏輯：
- 優先選擇成功率高的策略
- 失敗時切換到備選策略（參考多策略機制）
- 新情境時嘗試類比已知策略
- 所有策略都失敗時，搜尋新策略或詢問用戶
```

### 7. Prompt 自我優化

```markdown
根據執行結果調整自己的 Prompt：

原始 Prompt：
「生成一個遊戲道具圖片」

失敗後反思：
「生成的圖片背景不透明，不適合遊戲使用」

優化後 Prompt：
「生成一個遊戲道具圖片，要求：
 - 透明背景（PNG 格式）
 - 256x256 解析度
 - 卡通風格」

儲存優化後的 Prompt 模板到 .github/memory/patterns/
```

---

## 停止條件

```markdown
Agent 在以下情況停止：

✅ 成功條件：
   - 所有子目標完成
   - 驗收標準通過

❌ 失敗條件：
   - 達到最大迭代次數（預設 10 次）
   - 連續 3 次相同錯誤
   - 用戶手動中止

⚠️ 暫停條件：
   - 需要用戶決策
   - 需要外部資源
   - 風險操作需確認
```

---

## 與用戶的互動

```markdown
進度報告（每個主要步驟後）：
┌─────────────────────────────────────────────────────┐
│  📊 進度更新                                        │
│                                                     │
│  目標：建立 ComfyUI 工作流程                        │
│  進度：███████░░░ 70%                               │
│                                                     │
│  ✅ 已完成：                                        │
│     - 安裝 ComfyUI                                  │
│     - 下載基礎模型                                  │
│     - 建立基本工作流程                              │
│                                                     │
│  🔄 進行中：                                        │
│     - 加入 LoRA 支援                                │
│                                                     │
│  ⏳ 待完成：                                        │
│     - 批量生成功能                                  │
│     - 輸出格式優化                                  │
│                                                     │
│  📝 學習記錄：                                      │
│     - 發現：LoRA 需要特定節點                       │
│     - 解決：安裝 ComfyUI-Manager                    │
│     - 已儲存到：.github/memory/learnings/           │
└─────────────────────────────────────────────────────┘

需要確認時：
┌─────────────────────────────────────────────────────┐
│  ❓ 需要您的決定                                    │
│                                                     │
│  我嘗試了兩種方法都失敗了：                         │
│  1. 直接載入模型 → 記憶體不足                       │
│  2. 使用低精度模型 → 品質不佳                       │
│                                                     │
│  建議選項：                                         │
│  A. 使用雲端 GPU（需要費用）                        │
│  B. 降低輸出解析度（512→256）                       │
│  C. 換用更小的模型                                  │
│                                                     │
│  您希望怎麼做？                                     │
└─────────────────────────────────────────────────────┘
```

---

## 實作注意事項

### 安全機制

```markdown
1. 迭代上限
   - 防止無限循環
   - 預設最大 10 次嘗試

2. 範圍限制
   - 不執行危險操作（rm -rf 等）
   - 重要操作需用戶確認

3. 資源監控
   - 追蹤 API 呼叫次數
   - 避免過度消耗

4. 回滾機制
   - 每次重大變更前備份
   - 失敗時可以回滾
```

### 效能優化

```markdown
1. 快取成功經驗
   - 避免重複學習相同內容
   - 優先搜尋 .github/memory/

2. 平行執行
   - 獨立的子任務可平行處理

3. 早期失敗檢測
   - 快速識別不可行的方向

4. 漸進式複雜度
   - 先嘗試簡單方案
   - 失敗後再嘗試複雜方案
```

---

## 與現有系統整合

### 整合 PAL 工具（可選）

```python
# 深度思考複雜問題
await mcp__pal__thinkdeep({
    "step": "分析為什麼批量生成會失敗",
    "findings": "記憶體在第 5 張圖時耗盡",
    "hypothesis": "沒有正確釋放 GPU 記憶體",
    ...
})

# 多模型驗證方案
await mcp__pal__consensus({
    "step": "評估三種解決方案的可行性",
    "models": [
        {"model": "gpt-5", "stance": "for"},
        {"model": "gemini-2.5-pro", "stance": "against"}
    ],
    ...
})
```

### 整合 GitHub Copilot Agent Skills

由於記憶存於 `.github/memory/`，GitHub Copilot 也能讀取這些經驗：

```
.github/
├── skills/           # Copilot Agent Skills
│   └── your-skills/
└── memory/           # 共享記憶（Claude + Copilot 都能用）
    └── ...
```

---

## 範例執行過程

```markdown
用戶：/evolve 建立一個能批量生成遊戲道具圖片的系統

Agent：
📋 目標分析完成

目標：建立批量遊戲道具圖片生成系統
驗收標準：
- 能一次生成 10+ 張道具圖片
- 風格一致
- 背景透明
- 解析度 512x512

🔍 搜尋過去經驗...
Grep(pattern="遊戲道具|圖片生成", path=".github/memory/")
→ 無相關記錄

子目標：
1. ✅ 確認 ComfyUI 環境
2. 🔄 建立基礎工作流程
3. ⏳ 加入風格控制（LoRA）
4. ⏳ 實作批量生成
5. ⏳ 輸出格式處理

---

🔄 執行子目標 2：建立基礎工作流程

Plan：建立 text-to-image 基本流程
Do：[建立工作流程...]
Check：❌ 失敗 - 生成的圖片有背景

📝 反思：
- 問題：預設輸出不是透明背景
- 原因：沒有使用適當的模型和後處理
- 學習需求：如何生成透明背景圖片

🔍 搜索中...
[WebSearch: "ComfyUI transparent background PNG game assets"]

📚 學到：
- 需要使用 Remove Background 節點
- 或使用專門的 icon 生成模型

Act：更新策略，加入背景移除步驟

💾 記錄失敗經驗
Write(.github/memory/failures/2025-01-05-comfyui-background.md)

---

🔄 重試子目標 2

Plan：加入 RemBG 節點移除背景
Do：[更新工作流程...]
Check：✅ 成功 - 背景已透明

💾 儲存成功經驗
Write(.github/memory/learnings/2025-01-05-comfyui-rembg.md)
Edit(.github/memory/index.md) → 更新索引

---

繼續下一個子目標...
```

---

## 相關資源

- [Reflexion Paper](https://arxiv.org/abs/2303.11366)
- [OpenAI Self-Evolving Agents Cookbook](https://cookbook.openai.com/examples/partners/self_evolving_agents/autonomous_agent_retraining)
- [Andrew Ng - Agentic Design Patterns](https://www.deeplearning.ai/the-batch/agentic-design-patterns-part-2-reflection/)
- [AutoPDL Paper](https://arxiv.org/abs/2504.04365)
- [GitHub Copilot Agent Skills](https://docs.github.com/en/copilot/concepts/agents/about-agent-skills)
