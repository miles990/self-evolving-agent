---
name: skill-creator
version: 1.0.0
description: 引導式建立新 Skill 的完整工作流
triggers: [new-skill, create-skill, 建立skill, 新增skill]
---

# Skill Creator

> 完整工作流：引導式訪談 → 分析生成 → 驗證 → 發布到 GitHub

## 使用方式

```bash
/evolve --new-skill "skill 名稱"
```

## 四階段流程

### Stage 1: 引導式訪談

向使用者提問，收集需求：

1. **問題定義**：這個 skill 要解決什麼問題？
2. **目標使用者**：新手 / 進階 / 專家？
3. **前置需求**：需要什麼 MCP servers 或 CLI tools？
4. **參考來源**：有沒有類似的 skill 可以參考？

輸出：內部需求文件

### Stage 2: 分析 + 生成

**搜尋順序**：

1. **優先搜尋官方 Skill Repos**：
   - [claude-domain-skills](https://github.com/miles990/claude-domain-skills) — 領域知識 skills
   - [claude-software-skills](https://github.com/miles990/claude-software-skills) — 軟體開發 skills
2. 如無適合，搜尋 GitHub 上其他 skills
3. **如都無適合參考，使用 4C 方法自行研究**：
   - 載入 `methodology/knowledge-acquisition-4c` skill（from claude-domain-skills）
   - **Collect**：WebSearch / WebFetch 收集官方文檔、最佳實踐
   - **Curate**：篩選高品質來源，去除噪音
   - **Contextualize**：分析領域核心概念和常見流程
   - **Codify**：整理成 skill 可用的知識結構

**生成流程**：

4. 選擇適合的範本（basic / advanced）
5. 生成 SKILL.md 初稿
6. 建立目錄結構（如需要 scripts/templates）

輸出：完整的 skill 目錄

### Stage 3: 驗證

檢查清單：
- [ ] SKILL.md frontmatter 格式正確
- [ ] 必要欄位存在（name, description, version）
- [ ] 模擬使用情境，確認指令清楚
- [ ] 如有 scripts，確認可執行

輸出：驗證報告

### Stage 4: 發布到 GitHub

1. 詢問：建立新 repo 或加入現有 repo？
2. 生成 README.md
3. git init + commit + push
4. 輸出安裝指令

輸出：
```
✅ Skill 已發布！

GitHub: https://github.com/<user>/<repo>
安裝: /plugin install <user>/<repo>
```

## 範本選擇指南

| 情況 | 範本 |
|------|------|
| 簡單指令、無依賴 | basic-skill.md |
| 需要 MCP、有複雜流程 | advanced-skill.md |

## 驗證腳本

```bash
./scripts/validate-skill.sh <skill-directory>
```

## 發布腳本

```bash
./scripts/publish-skill.sh <skill-directory> [--new-repo]
```
