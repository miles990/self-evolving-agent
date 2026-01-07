# Emergence Mechanisms (涌現機制)

> 讓 Self-Evolving Agent 從「會做」進化到「會教自己怎麼做」

## 概述

涌現（Emergence）不是「突然變聰明」，而是系統透過回饋迴路長出偏好：
- 哪種技能 + 哪種策略 + 哪種任務類型 → 成功率更高

本文檔描述三個關鍵機制，讓系統真正能夠自我進化。

## 機制 A: 多階技能路由

### 從關鍵字匹配升級到可控多階路由

```
┌─────────────────────────────────────────────────────────────────┐
│  Multi-Stage Skill Routing                                       │
│                                                                 │
│  輸入: 「分析財報並生成投資報告 PPT」                           │
│                                                                 │
│  第一層: 粗分類 (Domain Classification)                          │
│  ├─ Domain Skills (Business, Finance, Creative...)             │
│  ├─ Software Skills (code, tools, frameworks...)               │
│  └─ Workflow Skills (processes, pipelines...)                  │
│           ↓                                                     │
│  第二層: Top-K 候選 (Candidate Selection)                        │
│  候選 1: finance/investment-analysis (score: 0.92)             │
│  候選 2: business/product-management (score: 0.65)             │
│  候選 3: creative/storytelling (score: 0.58)                   │
│           ↓                                                     │
│  第三層: 組合策略 (Composition Strategy)                         │
│  ├─ 單技能解: 只用最高分的 skill                               │
│  ├─ 管線組合: skill_a → skill_b → skill_c                      │
│  └─ 並行組合: skill_a + skill_b 同時應用                       │
│                                                                 │
│  規則:                                                          │
│  • 預設只載入 1 個技能                                         │
│  • 偵測到卡住（連續失敗/缺能力）才擴展到 2~3 個                │
│  • 技能庫越大越需要精準路由，避免混亂                          │
└─────────────────────────────────────────────────────────────────┘
```

### 路由決策邏輯

```python
def multi_stage_routing(task_description):
    # Stage 1: 粗分類
    domain = classify_domain(task_description)
    # 返回: "finance", "creative", "software", etc.

    # Stage 2: Top-K 候選
    candidates = get_top_k_skills(
        query=task_description,
        domain=domain,
        k=3
    )

    # Stage 3: 組合策略選擇
    if task_is_simple(task_description):
        # 單技能解
        return [candidates[0]]

    elif task_is_pipeline(task_description):
        # 管線組合：分析 → 報告 → 呈現
        return compose_pipeline(candidates)

    else:
        # 預設：從最高分開始，卡住再擴展
        return [candidates[0]], fallback=candidates[1:]
```

### 卡住偵測與擴展

```markdown
## 卡住信號

| 信號 | 定義 | 行動 |
|------|------|------|
| 連續失敗 | 同一任務連續 2 次失敗 | 擴展到候選 #2 |
| 能力缺口 | 評估發現缺少關鍵能力 | 載入補充 skill |
| 策略耗盡 | 策略池中所有策略都試過 | 搜尋新 skill |
| 超時 | 迭代超過上限仍未完成 | 詢問用戶或載入更多 skill |

## 擴展規則

1. 第一次卡住 → 載入候選 #2
2. 第二次卡住 → 載入候選 #3
3. 仍然卡住 → 搜尋新 skill 或詢問用戶
4. 成功後 → 記錄有效組合到 skill-metrics
```

## 機制 B: 技能效果記分板

### Skill Metrics 結構

在 `.claude/memory/skill-metrics/` 建立效果追蹤：

```
.claude/memory/skill-metrics/
├── index.md                    # 總覽和排行榜
├── by-task-type/               # 按任務類型
│   ├── code-refactoring.md
│   ├── data-analysis.md
│   └── report-generation.md
├── by-skill/                   # 按技能
│   ├── investment-analysis.md
│   └── storytelling.md
└── combinations/               # 技能組合效果
    └── analysis-to-report.md
```

### 記錄格式

```yaml
# .claude/memory/skill-metrics/by-task-type/financial-analysis.yaml

task_type: "財務分析"
total_attempts: 45
success_rate: 82%
last_updated: 2026-01-07

skill_performance:
  - skill: "finance/investment-analysis"
    attempts: 30
    success_rate: 90%
    avg_iterations: 2.1
    avg_time_minutes: 15
    failure_types:
      knowledge_gap: 2
      execution_error: 1

  - skill: "business/product-management"
    attempts: 10
    success_rate: 60%
    avg_iterations: 3.5
    avg_time_minutes: 25
    note: "適合產品財務，不適合純投資分析"

strategy_performance:
  - strategy: "DCF估值優先"
    success_rate: 95%
    best_with: ["finance/investment-analysis"]

  - strategy: "比較分析優先"
    success_rate: 75%
    note: "需要可比公司數據"

recommended_combination:
  primary: "finance/investment-analysis"
  support: ["research-analysis"]
  pipeline: "分析 → 整理 → 報告"
```

### 動態路由規則

```python
def smart_skill_routing(task):
    # 1. 分類任務類型
    task_type = classify_task(task.description)

    # 2. 查詢歷史效果
    metrics = load_metrics(f"by-task-type/{task_type}.yaml")

    if metrics and metrics.total_attempts > 10:
        # 有足夠歷史數據，使用推薦組合
        return metrics.recommended_combination

    else:
        # 數據不足，使用預設路由
        return default_routing(task)


def update_metrics(task, result):
    """任務完成後更新記分板"""
    metrics_file = f"by-task-type/{task.type}.yaml"
    metrics = load_metrics(metrics_file)

    metrics.total_attempts += 1
    if result.success:
        metrics.success_count += 1

    # 更新技能效果
    for skill in result.skills_used:
        skill_stats = metrics.skill_performance.get(skill, default_stats())
        skill_stats.attempts += 1
        skill_stats.success_rate = calculate_rate(skill_stats)

    # 更新策略效果
    strategy_stats = metrics.strategy_performance.get(result.strategy)
    strategy_stats.attempts += 1
    strategy_stats.success_rate = calculate_rate(strategy_stats)

    # 如果成功，考慮更新推薦組合
    if result.success and is_better_combination(result, metrics):
        metrics.recommended_combination = result.combination

    save_metrics(metrics_file, metrics)
```

### 效果排行榜

```markdown
# .claude/memory/skill-metrics/index.md

# 技能效果排行榜

> 自動更新，根據實際使用效果排序

## 最有效的技能組合 (Top 10)

| 排名 | 任務類型 | 技能組合 | 成功率 | 樣本數 |
|------|----------|----------|--------|--------|
| 1 | 財務分析 | investment-analysis | 90% | 30 |
| 2 | UI 設計 | ui-ux-design | 88% | 25 |
| 3 | 報告生成 | research + storytelling | 85% | 20 |
| 4 | 市場調研 | research-analysis | 82% | 18 |
| 5 | 產品規劃 | product-management | 80% | 15 |

## 需要改進的領域

| 任務類型 | 當前成功率 | 主要失敗原因 | 建議 |
|----------|------------|--------------|------|
| 複雜重構 | 55% | 策略錯誤 | 嘗試漸進式策略 |
| 跨領域整合 | 60% | 技能組合不當 | 建立管線模板 |

## 最近趨勢

- 本週成功率: 78% (↑ 5%)
- 平均迭代次數: 2.4 (↓ 0.3)
- 新學習記錄: 12 條
```

## 機制 C: 知識蒸餾

### 從經驗到可重用技能

```
┌─────────────────────────────────────────────────────────────────┐
│  Knowledge Distillation Pipeline                                 │
│                                                                 │
│  成功經驗 (memory/learnings/)                                   │
│         ↓                                                       │
│  模式識別 (多次成功的共同點)                                    │
│         ↓                                                       │
│  蒸餾為:                                                        │
│  ├─ 新的 SKILL.md (小而深)                                     │
│  │   例: "comfyui-game-assets" skill                           │
│  │                                                              │
│  ├─ 既有 skill 的增補                                          │
│  │   - Examples 區塊                                           │
│  │   - Pitfalls 區塊                                           │
│  │   - Checklist 區塊                                          │
│  │                                                              │
│  └─ 策略池更新                                                  │
│      - 新策略加入                                               │
│      - 成功率數據                                               │
│                                                                 │
│  發版和同步:                                                    │
│  • skillpkg 版本管理                                           │
│  • 依賴解決                                                     │
│  • 跨專案同步                                                   │
└─────────────────────────────────────────────────────────────────┘
```

### 自動蒸餾觸發條件

```markdown
## 觸發蒸餾的條件

### 新 Skill 創建
當以下條件滿足時，建議創建新 skill：
- 同一任務類型成功 5+ 次
- 形成了可複用的模式
- 現有 skill 都不完全匹配

### 既有 Skill 增補
當以下條件滿足時，增補現有 skill：
- 發現新的 pitfall（已記錄 3+ 次）
- 發現更好的方法（成功率顯著提升）
- 有具體的範例值得記錄

### 策略池更新
當以下條件滿足時，更新策略池：
- 新策略成功 3+ 次
- 現有策略成功率下降
- 發現策略適用條件需要調整
```

### 蒸餾模板

```markdown
# 知識蒸餾記錄

## 來源
- 學習記錄: learnings/2026-01-07-comfyui-rembg.md
- 學習記錄: learnings/2026-01-05-comfyui-batch.md
- 失敗記錄: failures/2026-01-04-vram-issue.md

## 模式識別
成功的共同點：
1. 使用 RemBG 節點處理透明背景
2. 每 5 張圖重啟避免記憶體問題
3. 輸出格式統一使用 PNG

## 蒸餾結果

### 新 Skill: comfyui-game-assets
```yaml
name: comfyui-game-assets
version: 1.0.0
description: 使用 ComfyUI 生成遊戲素材的最佳實踐
triggers: [comfyui, game-assets, 遊戲素材, 道具圖, 透明背景]
```

### 核心內容
- 工作流程模板
- 節點配置建議
- 常見問題解決方案
- 效能優化技巧

## 版本發布
- [ ] 創建 SKILL.md
- [ ] 測試驗證
- [ ] skillpkg 發版
- [ ] 同步到全域
```

## 預期涌現能力

基於這三個機制，系統最容易自然長出的能力：

### 1. 跨領域任務管線
```
投資分析 (domain skill)
    ↓
寫報告 (creative/storytelling)
    ↓
落地成腳本/表格 (software skill)
```

### 2. 自動補洞
```
做一半發現缺知識
    ↓
自動搜尋 skill
    ↓
安裝並驗證
    ↓
繼續任務
```

### 3. 越做越不重複犯同樣錯
```
強制檢查點 + 變更後測試 + milestone 確認
    ↓
行為穩定
    ↓
「突然成熟」的感覺
```

## 實施路線圖

### Phase 1: 基礎設施 (當前)
- [x] Memory 系統
- [x] 策略池機制
- [x] 失敗診斷分類
- [ ] skill-metrics 目錄結構

### Phase 2: 多階路由
- [ ] 粗分類器
- [ ] Top-K 候選選擇
- [ ] 卡住偵測邏輯
- [ ] 動態擴展機制

### Phase 3: 效果記分板
- [ ] 記錄格式定義
- [ ] 自動更新機制
- [ ] 排行榜生成
- [ ] 智能路由集成

### Phase 4: 知識蒸餾
- [ ] 觸發條件偵測
- [ ] 蒸餾模板
- [ ] skillpkg 集成
- [ ] 跨專案同步

## 相關文檔

- [進階技巧](../examples/advanced-techniques.md)
- [記憶管理](../examples/memory-management.md)
- [整合模式](../examples/integration-patterns.md)
