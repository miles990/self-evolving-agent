# 技能習得流程

> 遇到無法完成的任務時，自動搜尋並學習新技能

## 習得流程

```
┌─────────────────────────────────────────────────────────────────┐
│  技能習得流程                                                   │
│                                                                 │
│  1. 識別技能缺口                                                │
│     - 「我無法完成 X 因為我不知道如何 Y」                       │
│     - 區分：缺「知識」還是缺「工具」                            │
│                                                                 │
│  2. 搜尋已有經驗（Repo Memory）                                 │
│     Grep(pattern="Y", path=".claude/memory/")                   │
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
│     Write(.claude/memory/learnings/{date}-{skill}.md)           │
│     - 記錄情境 + skill + 效果                                   │
│     - 更新 index.md                                             │
└─────────────────────────────────────────────────────────────────┘
```

## 自動領域識別

從任務描述提取關鍵詞，自動搜尋匹配的領域 skill：

```
用戶任務：「幫我建立一個量化交易回測系統」

Step 1: recommend_skills({ goal: "量化交易回測系統" })
        → 分析關鍵詞：量化、交易、回測、系統

Step 2: 獲得推薦結果
        domain_skills: quant-trading (85% confidence)
        software_skills: python, database

Step 3: 自動載入
        load_skill("quant-trading")
        load_skill("python")
```

### 研究模式

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

## 學習驗證流程

安裝新 skill 後，必須驗證真的學會才能應用：

```
1. 安裝 Skill
   install_skill({ source: "skill-name" })

2. 載入 Instructions
   load_skill({ id: "skill-name" })

3. 設計簡單驗證任務
   • 範圍小、可快速完成
   • 涵蓋核心能力
   • 有明確的成功標準

4. 執行驗證
   例：生成一張簡單的測試圖片

5. 評估結果
   ✅ 成功 → 加入 confident_in，繼續主任務
   ❌ 失敗 → 重新學習或嘗試其他 skill
```

## 能力評估思考框架

```yaml
task: "[分析用戶的任務後填入]"

capability_assessment:
  confident_in:
    - skill: "[技能名稱]"
      level: "熟練 / 基本 / 略知"

  uncertain_about:
    - skill: "[技能名稱]"
      reason: "[為什麼不確定]"

  definitely_need:
    - "[需要的技能或知識]"

  action_plan:
    - step: "[下一步行動]"
      tool: "[使用的工具]"
```
