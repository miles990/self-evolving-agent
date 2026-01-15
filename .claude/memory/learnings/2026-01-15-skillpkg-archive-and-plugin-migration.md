# skillpkg Archive 與 Plugin Migration

> 日期：2026-01-15
> 標籤：skillpkg, plugin, migration, archive, claude-code

## 背景

skillpkg 專案的核心功能已被 Claude Code 官方 Plugin Marketplace 取代，因此按照原定計劃進行 Archive。

## 關鍵洞察

### 1. Plugin Marketplace 取代 skillpkg MCP

| skillpkg MCP | Plugin Marketplace |
|-------------|-------------------|
| `mcp__skillpkg__search_skills` | WebSearch + `/plugin` Discover |
| `mcp__skillpkg__install_skill` | `/plugin install {plugin}@{marketplace}` |
| `mcp__skillpkg__load_skill` | 自動載入（提及 skill 名稱即可） |
| `mcp__skillpkg__sync_skills` | 自動同步 |

### 2. Skills → Plugin 格式轉換

建立了 `convert-to-plugin.sh` 腳本，可自動轉換：

```bash
./convert-to-plugin.sh <skills-repo-path> --marketplace
```

**必要文件結構：**
```
repo/
├── .claude-plugin/
│   └── marketplace.json      # marketplace 級別
├── category-a/
│   ├── .claude-plugin/
│   │   └── plugin.json       # plugin 級別（每個分類都需要）
│   └── skill-1/
│       └── SKILL.md
```

### 3. marketplace.json 格式

```json
{
  "$schema": "https://anthropic.com/claude-code/marketplace.schema.json",
  "name": "repo-name",
  "owner": { "name": "...", "email": "..." },
  "plugins": [
    {
      "name": "category-name",
      "description": "描述",
      "source": "./category-path",
      "category": "development"
    }
  ]
}
```

**關鍵：** 每個 `source` 目錄都需要自己的 `.claude-plugin/plugin.json`

## 已完成事項

1. ✅ 更新 skillpkg README 加入 Archive 公告
2. ✅ 將 evolve 中所有 skillpkg 引用替換為 Plugin 方法
3. ✅ 建立 `convert-to-plugin.sh` 轉換腳本
4. ✅ 轉換 claude-software-skills（6 分類，54 skills）
5. ✅ 轉換 claude-domain-skills（6 分類，24 skills）

## 遷移後的 Skill 載入方式

```bash
# 1. 添加 marketplace
/plugin marketplace add miles990/claude-software-skills

# 2. 安裝特定 plugin
/plugin install software-design@claude-software-skills

# 3. 使用 skill（自動載入）
# 只需在對話中提及 skill 名稱
```

## 教訓

1. **格式驗證很重要** - 第一版 marketplace.json 格式錯誤（用了 `skills` 而非 `source`）
2. **每層都需要 manifest** - marketplace.json 和每個 plugin.json 都必須存在
3. **自動化腳本省時** - 手動轉換 78 個 skills 會很耗時

## 參考

- Plugin 官方文檔：https://code.claude.com/docs/en/discover-plugins
- 官方 marketplace 格式：`~/.claude/plugins/marketplaces/claude-plugins-official/.claude-plugin/marketplace.json`
