# Quick Start Guide

> 5 分鐘上手 Self-Evolving Agent

## 安裝

```bash
# 使用 skillpkg 安裝（推薦）
mcp__skillpkg__install_skill({ source: "github:miles990/self-evolving-agent" })

# 或使用 claude-starter-kit
npx claude-starter-kit
```

## 基本使用

```
/evolve [你的目標]
```

### 範例

```bash
# 效能優化
/evolve 優化 UserList 組件，目標首次渲染 < 100ms

# 學習新技術
/evolve 用 ComfyUI 建立遊戲素材生成工作流程

# 重構程式碼
/evolve 將這個模組重構為 TypeScript，加入完整型別定義
```

## 自動領域識別

Agent 會自動識別任務關鍵詞並載入相關領域知識：

| 說 | 載入 |
|----|------|
| 「分析財報」 | finance/investment-analysis |
| 「規劃 Sprint」 | business/project-management |
| 「設計 UI」 | creative/ui-ux-design |
| 「寫小說大綱」 | creative/storytelling |

## 核心流程

```
目標 → 自動領域識別 → 能力評估 → 技能習得 → PDCA 執行 → 記憶儲存
```

## 記憶系統

經驗會自動儲存到 `.claude/memory/`：

```
.claude/memory/
├── learnings/    # 成功經驗
├── failures/     # 失敗教訓
├── patterns/     # 推理模式
└── index.md      # 快速索引
```

## 進階技巧

### 明確的目標描述

```bash
# ❌ 模糊
/evolve 優化效能

# ✅ 明確
/evolve 優化 UserList 組件
       目標：首次渲染 < 100ms
       約束：不改變 API 介面
       驗證：使用 React DevTools Profiler
```

### 查看可用領域

16 個領域 skills 可自動載入：

- **Finance**: quant-trading, investment-analysis
- **Business**: marketing, sales, product-management, project-management, strategy
- **Creative**: game-design, ui-ux-design, brainstorming, storytelling, visual-media
- **Professional**: research-analysis, knowledge-management
- **Lifestyle**: personal-growth, side-income

## 相關文檔

- [完整使用手冊](../USAGE.md)
- [基本範例](../examples/basic-usage.md)
- [自動領域識別範例](../examples/auto-domain-detection.md)
- [失敗處理範例](../examples/failure-handling.md)
- [Memory 管理範例](../examples/memory-management.md)
- [變更日誌](../CHANGELOG.md)
