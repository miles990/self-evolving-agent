# 02-checkpoints

> 強制檢查點：品質護欄，不可跳過

## 本模組包含

| 文件 | 檢查點 | 時機 |
|------|--------|------|
| [cp1-memory-search.md](./_base/cp1-memory-search.md) | CP1 | 任務開始前 |
| [cp2-build-test.md](./_base/cp2-build-test.md) | CP2 | 程式碼變更後 |
| [cp3-milestone-confirm.md](./_base/cp3-milestone-confirm.md) | CP3 | Milestone 完成後 |
| [cp3.5-memory-sync.md](./_base/cp3.5-memory-sync.md) | CP3.5 | Memory 創建後 |
| [cp4-emergence-check.md](./_base/cp4-emergence-check.md) | CP4 | 迭代完成後（選擇性） |

## 檢查點總覽

```
CP1: 搜尋 Memory     → 避免重複犯錯
CP2: 編譯 + 測試    → 確保程式碼品質
CP3: 確認目標       → 確保方向正確
CP3.5: 同步 index   → 確保 Memory 可搜尋
CP4: 涌現檢查       → 發現改進機會
```

## 重要提醒

**CP1-CP3.5 為強制檢查點，不可跳過！**

## 社群貢獻

在 [community/](./community/) 目錄添加你的自定義檢查點。
