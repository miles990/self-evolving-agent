# 社群貢獻指南

> 如何為 Self-Evolving Agent 貢獻內容

## 貢獻位置

所有社群貢獻放在 `community/` 目錄：

```
skills/
├── 01-core/
│   ├── _base/           # ❌ 不要修改（官方內容）
│   └── community/       # ✅ 在這裡貢獻
│       └── your-file.md
```

## 貢獻流程

### 1. Fork 專案

```bash
git clone https://github.com/YOUR_USERNAME/self-evolving-agent.git
```

### 2. 創建貢獻文件

在對應模組的 `community/` 目錄下創建你的文件：

```bash
# 範例：貢獻一個新的 PDCA 變體
touch skills/01-core/community/my-pdca-variant.md
```

### 3. 使用標準格式

```markdown
---
name: my-pdca-variant
author: your-name
date: YYYY-MM-DD
description: 一句話描述你的貢獻
tags: [pdca, variant, 標籤]
---

# 標題

## 說明
[你的內容...]

## 使用場景
[何時使用...]

## 範例
[具體範例...]
```

### 4. 提交 PR

```bash
git add skills/*/community/
git commit -m "feat(community): add my-pdca-variant"
git push origin main
# 在 GitHub 上創建 Pull Request
```

## 貢獻類型

| 模組 | 可以貢獻什麼 |
|------|-------------|
| 00-getting-started | 入門教程、環境配置範例 |
| 01-core | PDCA 變體、目標分析模板 |
| 02-checkpoints | 自定義檢查點 |
| 03-memory | 記憶模板、索引工具 |
| 04-emergence | 涌現模式、路由策略 |
| 05-integration | 工具整合配置 |
| 99-evolution | 進化策略、修正模式 |

## 品質標準

- [ ] 有清晰的 frontmatter（name, author, date, description）
- [ ] 有具體的使用場景說明
- [ ] 有可執行的範例
- [ ] 不與官方 `_base/` 內容重複
- [ ] 經過實際測試

## 常見問題

**Q: 我可以修改 `_base/` 的內容嗎？**

A: 不建議。如果你發現 bug，請提 Issue。如果想改進，請在 `community/` 創建替代版本。

**Q: 我的貢獻會被合併到 `_base/` 嗎？**

A: 優秀的社群貢獻可能會被整合到官方內容，但這需要維護者評估。
