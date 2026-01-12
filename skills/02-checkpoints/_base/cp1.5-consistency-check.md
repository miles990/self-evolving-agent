# Checkpoint 1.5: 一致性檢查 (Consistency Check)

> 🚨 **強制檢查點** - 不可跳過

## 核心理念

```
先找現有的，再決定要不要新建

❌ 錯誤：直接寫新的 → 事後發現重複
✅ 正確：先搜尋 → 確認沒有 → 才動手
```

## 規則

```
┌─────────────────────────────────────────────────────────────────┐
│  🔗 開始寫程式碼前（強制）                                       │
│                                                                 │
│  在 CP1 (Memory Search) 完成後、實際寫程式碼前，必須執行：       │
│                                                                 │
│  □ 1. 搜尋現有實作                                              │
│       - 用關鍵字搜尋 src/ 或專案程式碼目錄                       │
│       - 有類似實作 → 複用或擴展，不要新建                        │
│       - 無類似實作 → 記錄「已確認無重複」，繼續                  │
│                                                                 │
│  □ 2. 檢查專案慣例 (Pattern)                                    │
│       - 閱讀 CLAUDE.md / README.md / docs/ 中的規範             │
│       - 確認：命名規範、目錄結構、錯誤處理方式                   │
│       - 新程式碼必須符合既有風格                                 │
│                                                                 │
│  □ 3. 檢查相關 Schema / API（如適用）                           │
│       - 若涉及資料結構或 API，搜尋現有定義                       │
│       - 新設計必須與既有介面一致                                 │
│                                                                 │
│  ❌ 禁止：不搜尋就開始寫新實作                                   │
│  ❌ 禁止：發現有類似的還另起爐灶                                 │
│  ✅ 必須：先確認「不是重複造輪子」才動手                         │
│  ✅ 必須：新程式碼符合專案既有風格                               │
└─────────────────────────────────────────────────────────────────┘
```

## 搜尋範例

### 1. 搜尋現有實作

```python
# 搜尋功能相關的程式碼
Grep(
    pattern="formatDate|dateFormat|formatTime",
    path="src/",
    output_mode="files_with_matches"
)

# 搜尋類似的 utility 函數
Grep(
    pattern="export (function|const) .*[Ff]ormat",
    path="src/utils/",
    output_mode="content",
    C=3
)

# 找到後閱讀內容
Read(file_path="src/utils/time.ts")
```

### 2. 檢查專案慣例

```python
# 閱讀專案規範
Read(file_path="CLAUDE.md")
Read(file_path="docs/CONTRIBUTING.md")

# 找類似功能的實作作為參考
Grep(
    pattern="export (function|class)",
    path="src/utils/",
    output_mode="files_with_matches",
    head_limit=5
)
# 然後閱讀其中一個作為風格參考
```

### 3. 檢查 Schema / API

```python
# 搜尋相關型別定義
Grep(
    pattern="interface.*User|type.*User",
    path="src/types/",
    output_mode="content"
)

# 搜尋相關 API 端點
Grep(
    pattern="/api/user|userRouter",
    path="src/",
    output_mode="files_with_matches"
)
```

## 決策樹

```
搜尋結果
    │
    ├─ 找到完全符合的實作
    │   └─ 直接使用，不要新建
    │
    ├─ 找到部分符合的實作
    │   └─ 擴展現有實作，而非新建
    │
    ├─ 找到類似但不同用途的實作
    │   └─ 參考其風格，確保一致性
    │
    └─ 完全沒找到
        └─ 記錄「已確認無重複」，開始新建
```

## 一致性檢查清單

| 檢查項 | 問題 | 若不符合 |
|--------|------|----------|
| **功能重複** | 這個功能是否已經存在？ | 複用現有的 |
| **命名一致** | 命名是否符合專案慣例？ | 調整命名 |
| **位置正確** | 檔案應該放在哪個目錄？ | 放到正確位置 |
| **風格一致** | 是否符合專案程式碼風格？ | 參考現有實作 |
| **介面一致** | API/Schema 是否與現有設計一致？ | 調整設計 |

## 常見違規場景

| 場景 | 問題 | 正確做法 |
|------|------|----------|
| 新增 `formatDate()` | 已有 `src/helpers/time.ts` 的 `formatDateTime()` | 擴展現有函數 |
| 新增 `UserCard` 組件 | 已有 `src/components/cards/` 目錄 | 放到正確目錄 |
| 新增 `fetchUser` API | 已有 `userService.ts` 處理 user 相關 | 加到現有 service |
| 命名為 `get_user_data` | 專案慣例是 camelCase | 改為 `getUserData` |

## 與 CP1 的關係

```
CP1 (Memory Search)          CP1.5 (Consistency Check)
        │                              │
        ▼                              ▼
搜尋「過去經驗」              搜尋「現有程式碼」
.claude/memory/               src/ (專案程式碼)
        │                              │
        └──────────┬───────────────────┘
                   ▼
            兩者都完成後
            才開始寫程式碼
```

## 為什麼重要

1. **避免重複造輪子** - 不要寫已經存在的東西
2. **維持程式碼一致性** - 新舊程式碼風格統一
3. **降低維護成本** - 不會有多個做相同事情的實作
4. **加速開發** - 複用比新建更快
