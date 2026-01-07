# Auto Domain Detection Examples (v3.5)

> 自動識別任務所需的領域知識，無需手動指定 skill

## How It Works

```
用戶任務 → 提取關鍵詞 → 搜尋匹配 skill → 自動載入 → 執行任務
                ↓
        「財報分析」 → triggers: [財報, 投資, 估值]
                ↓
        載入: finance/investment-analysis
```

## Example 1: Financial Analysis (自動識別)

```
User: /evolve 分析台積電 2024 年財報，評估投資價值

Agent:
🔍 Auto Domain Detection

任務關鍵詞: 財報, 分析, 投資, 評估
搜尋匹配 skills...

Found: finance/investment-analysis
  triggers: [財報, 投資, 估值, ROE, DCF, 本益比]
  match_score: 0.85

📚 Loading domain skill...
✅ investment-analysis loaded

---
📋 Goal Analysis (with domain knowledge)

Goal: 分析台積電財報並評估投資價值

Using investment-analysis framework:
1. 財務報表分析 (Income, Balance, Cash Flow)
2. 關鍵指標計算 (ROE, ROIC, Margins)
3. 估值模型 (DCF, P/E Comparison)
4. 投資建議

Starting execution...
```

## Example 2: Project Management (自動識別)

```
User: /evolve 規劃新產品開發的 Sprint，第一個 MVP 目標 4 週完成

Agent:
🔍 Auto Domain Detection

任務關鍵詞: 規劃, Sprint, MVP, 產品開發
搜尋匹配 skills...

Found: business/project-management
  triggers: [Scrum, Sprint, 甘特圖, 敏捷, agile]
  match_score: 0.78

Found: business/product-management
  triggers: [PRD, 產品, OKR, roadmap]
  match_score: 0.65

📚 Loading domain skills...
✅ project-management loaded (primary)
✅ product-management loaded (secondary)

---
📋 Goal Analysis (with domain knowledge)

Goal: 4 週 MVP Sprint 規劃

Using Scrum framework:
1. Sprint Planning
   - Product Backlog → Sprint Backlog
   - Story Points 估算
2. 里程碑設定
   - Week 1-2: Core features
   - Week 3: Integration
   - Week 4: Testing & Polish
3. 風險管理
   - 識別潛在障礙
   - 準備備案

Generating Sprint plan...
```

## Example 3: Research Analysis (自動識別)

```
User: /evolve 做一份競品分析報告，比較我們和 Notion、Obsidian 的差異

Agent:
🔍 Auto Domain Detection

任務關鍵詞: 競品, 分析, 報告, 比較
搜尋匹配 skills...

Found: professional/research-analysis
  triggers: [研究, 競品, 調研, 分析報告]
  match_score: 0.92

📚 Loading domain skill...
✅ research-analysis loaded

---
📋 Goal Analysis (with domain knowledge)

Goal: 競品分析報告 (vs Notion, Obsidian)

Using competitive analysis framework:
1. 分析維度
   - 產品功能
   - 用戶體驗
   - 商業模式
   - 市場定位
   - 技術架構
2. 競品矩陣
3. SWOT 分析
4. 洞察與建議

Starting research...
```

## Example 4: UI/UX Design (自動識別)

```
User: /evolve 重新設計登入頁面，要符合 WCAG 無障礙標準

Agent:
🔍 Auto Domain Detection

任務關鍵詞: 設計, 登入, WCAG, 無障礙
搜尋匹配 skills...

Found: creative/ui-ux-design
  triggers: [UI, UX, 無障礙, accessibility, WCAG]
  match_score: 0.88

📚 Loading domain skill...
✅ ui-ux-design loaded

---
📋 Goal Analysis (with domain knowledge)

Goal: WCAG-compliant 登入頁面設計

Using UI/UX design principles:
1. WCAG 2.1 AA 檢查清單
   - 對比度 ≥ 4.5:1
   - Focus 指示明顯
   - 所有功能可用鍵盤操作
2. 設計原則
   - 一致性
   - 可見性
   - 回饋
3. 無障礙實作
   - aria-label
   - semantic HTML
   - 錯誤提示

Starting design...
```

## Example 5: No Match (優雅降級)

```
User: /evolve 幫我整理房間的收納系統

Agent:
🔍 Auto Domain Detection

任務關鍵詞: 整理, 房間, 收納
搜尋匹配 skills...

No matching domain skill found.
(lifestyle 領域尚未實現)

📝 Proceeding without domain skill
→ Will use general knowledge
→ Can still complete task

---
📋 Goal Analysis

Goal: 房間收納系統規劃

Sub-goals:
1. 評估現有空間
2. 分類物品
3. 規劃收納區域
4. 執行整理

Note: 此任務沒有特定領域 skill，
      使用通用知識執行。
      如需專業收納建議，可安裝 lifestyle 領域 skill。

Starting execution...
```

## Available Domain Skills

| 領域 | Triggers 範例 | 說明 |
|------|---------------|------|
| `finance/quant-trading` | 量化, backtest, 策略 | 量化交易 |
| `finance/investment-analysis` | 財報, 投資, 估值 | 投資分析 |
| `business/product-management` | PRD, OKR, 路線圖 | 產品管理 |
| `business/project-management` | Scrum, Sprint, 甘特圖 | 專案管理 |
| `business/marketing` | 行銷, CAC, 漏斗 | 行銷策略 |
| `creative/game-design` | 遊戲, 關卡, 平衡 | 遊戲設計 |
| `creative/ui-ux-design` | UI, UX, 無障礙 | 介面設計 |
| `professional/research-analysis` | 研究, 競品, 調研 | 研究分析 |

## Tips

1. **自然描述任務** - 不需要刻意使用特定關鍵詞，自然語言即可
2. **多領域支援** - 一個任務可以載入多個相關領域 skill
3. **優雅降級** - 沒有匹配的 skill 也不會阻斷執行
4. **手動指定** - 如果自動識別不準確，可以手動安裝特定 skill
