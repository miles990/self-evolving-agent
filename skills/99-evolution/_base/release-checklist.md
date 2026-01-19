# 版本發布檢查清單

> 發布新版本時的強制檢查流程
>
> **強制執行**：每次發布必須完成所有檢查項目

## 發布前檢查

### 1. 工作區狀態

```bash
# 確認工作區乾淨
git status
# 應顯示: nothing to commit, working tree clean
```

- [ ] Git 工作區乾淨（無未提交變更）
- [ ] 在 main 分支上
- [ ] 已 pull 最新變更

### 2. 版本一致性

```bash
# 執行版本檢查
./scripts/check-version.sh
```

檢查以下文件版本一致：

| 文件 | 位置 |
|------|------|
| skills/SKILL.md | frontmatter `version:` |
| .claude-plugin/plugin.json | `"version":` |
| .claude-plugin/marketplace.json | `"version":` |
| README.md | badge `version-X.Y.Z-blue` |

### 3. CHANGELOG 完整性

- [ ] CHANGELOG.md 已更新
- [ ] 版本號正確
- [ ] 日期正確
- [ ] 變更內容完整

### 4. 功能驗證

```bash
# 執行環境檢查
./scripts/check-env.sh
```

- [ ] 環境檢查通過
- [ ] 核心功能正常

## 發布流程

### Step 1: 更新版本號

```bash
./scripts/update-version.sh X.Y.Z
```

此命令會自動更新：
- skills/SKILL.md
- .claude-plugin/plugin.json
- .claude-plugin/marketplace.json
- README.md badge

### Step 2: 更新 CHANGELOG

手動編輯 `CHANGELOG.md`，遵循格式：

```markdown
## [X.Y.Z] - YYYY-MM-DD

### Added
- 新功能描述

### Changed
- 變更描述

### Fixed
- 修復描述
```

### Step 3: 提交變更

```bash
git add -A
git commit -m "chore: bump version to vX.Y.Z"
```

### Step 4: 建立 Git Tag

```bash
git tag -a vX.Y.Z -m "Release vX.Y.Z: [簡短描述]"
```

### Step 5: 推送到遠端

```bash
git push origin main
git push origin vX.Y.Z
```

### Step 6: 建立 GitHub Release

```bash
gh release create vX.Y.Z \
  --title "vX.Y.Z: [標題]" \
  --notes-file RELEASE_NOTES.md
```

或使用自動生成：

```bash
gh release create vX.Y.Z --generate-notes
```

## 發布後驗證

### 1. 版本確認

- [ ] GitHub Release 頁面顯示正確版本
- [ ] Git tag 存在且指向正確 commit
- [ ] README badge 顯示新版本

### 2. Plugin 安裝測試

```bash
# 測試安裝
claude mcp add-plugin self-evolving-agent -s miles990

# 驗證版本
/evolve --version
```

### 3. 功能測試

- [ ] `/evolve` 命令正常執行
- [ ] 核心流程無錯誤

## 版本號規則

遵循 [Semantic Versioning](https://semver.org/)：

| 版本類型 | 格式 | 時機 |
|----------|------|------|
| Major | X.0.0 | 重大架構變更、不相容更新 |
| Minor | X.Y.0 | 新功能、向下相容 |
| Patch | X.Y.Z | Bug 修復、小幅改進 |

### 版本號範例

- `5.9.0` → `5.10.0`: 新增功能
- `5.9.0` → `5.9.1`: Bug 修復
- `5.9.0` → `6.0.0`: 重大架構變更

## 緊急回滾

若發布後發現重大問題：

```bash
# 刪除 release
gh release delete vX.Y.Z --yes

# 刪除 tag
git tag -d vX.Y.Z
git push origin :refs/tags/vX.Y.Z

# 回滾 commit
git revert HEAD
git push
```

## 自動化腳本

### 完整發布腳本（建議）

```bash
#!/bin/bash
# release.sh - 一鍵發布腳本

VERSION=$1

if [ -z "$VERSION" ]; then
  echo "Usage: ./scripts/release.sh X.Y.Z"
  exit 1
fi

# 1. 更新版本
./scripts/update-version.sh $VERSION

# 2. 確認變更
echo "請確認 CHANGELOG.md 已更新，然後按 Enter 繼續..."
read

# 3. 提交
git add -A
git commit -m "chore: bump version to v$VERSION"

# 4. 建立 tag
git tag -a v$VERSION -m "Release v$VERSION"

# 5. 推送
git push origin main
git push origin v$VERSION

# 6. 建立 release
gh release create v$VERSION --generate-notes

echo "✅ v$VERSION 發布完成！"
```

## 相關文件

- [CHANGELOG.md](../../../CHANGELOG.md) - 變更紀錄
- [update-version.sh](../../../scripts/update-version.sh) - 版本更新腳本
- [check-version.sh](../../../scripts/check-version.sh) - 版本檢查腳本
