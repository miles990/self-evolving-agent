# 記憶系統結構

> Git-based Memory：版本控制、可追溯、可協作

## 目錄結構

```
.claude/memory/
├── index.md              # 快速索引（必須維護）
├── learnings/            # 學習記錄
│   └── {date}-{slug}.md
├── decisions/            # 決策記錄 (ADR)
│   └── {number}-{title}.md
├── failures/             # 失敗經驗
│   └── {date}-{slug}.md
├── patterns/             # 推理模式
│   └── {category}-{name}.md
├── strategies/           # 策略記錄
│   └── {task-type}.md
├── discoveries/          # 涌現發現
│   └── {date}-{name}.md
├── lessons/              # CP5 結構化教訓（失敗後驗屍）
│   └── {date}-{failure-id}.md
└── skill-metrics/        # 技能效果追蹤
    ├── index.md
    ├── by-task-type/
    └── by-skill/
```

## 各層用途

| 層 | 用途 | 檔名格式 |
|---|------|----------|
| **learnings** | 解決方案、最佳實踐、成功經驗 | `{date}-{slug}.md` |
| **decisions** | 架構決策記錄 (ADR)、技術選型 | `{number}-{title}.md` |
| **failures** | 失敗經驗、踩坑記錄、教訓 | `{date}-{slug}.md` |
| **patterns** | 可複用的推理模式、思考框架 | `{category}-{name}.md` |
| **strategies** | 任務類型的策略池、成功率統計 | `{task-type}.md` |
| **discoveries** | 涌現發現、跨領域連結、意外洞察 | `{date}-{name}.md` |
| **lessons** | CP5 結構化教訓、失敗後驗屍 | `{date}-{failure-id}.md` |
| **skill-metrics** | 技能效果追蹤、排行榜 | 依結構 |

## Git-based 優勢

- ✅ **版本控制** - 追蹤歷史、可回滾
- ✅ **跨工具共享** - Claude Code ↔ Copilot ↔ Cursor
- ✅ **離線可用** - 無需外部服務
- ✅ **團隊協作** - PR 審核記憶變更
- ✅ **快速搜尋** - 標準 Grep 工具
- ✅ **專案可攜** - 記憶隨 repo 遷移

## 搜尋範例

```python
# 搜尋學習記錄
Grep(pattern="ComfyUI", path=".claude/memory/learnings/")

# 搜尋失敗經驗
Grep(pattern="memory leak", path=".claude/memory/failures/")

# 全域搜尋
Grep(pattern="關鍵字", path=".claude/memory/")
```
