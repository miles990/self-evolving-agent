# 05-integration

> 外部工具整合：Plugin、PAL、spec-workflow、Hooks

## 本模組包含

| 文件 | 整合對象 | 用途 |
|------|----------|------|
| [skill-integration.md](./_base/skill-integration.md) | Claude Code Plugin | Skill 搜尋、安裝、載入 |
| [pal-tools.md](./_base/pal-tools.md) | PAL MCP | 多模型協作、深度分析 |
| [spec-workflow.md](./_base/spec-workflow.md) | spec-workflow MCP | 需求到實作轉換 |
| [hooks.md](./_base/hooks.md) | Claude Code Hooks | 自動化觸發 |

## 整合概覽

```
┌─────────────┐     ┌─────────────┐     ┌─────────────┐
│   Plugin    │     │    PAL      │     │ spec-flow   │
│  Skill 管理 │     │  多模型協作  │     │  結構化規劃  │
└──────┬──────┘     └──────┬──────┘     └──────┬──────┘
       │                   │                   │
       └───────────────────┼───────────────────┘
                           │
                    ┌──────▼──────┐
                    │   evolve    │
                    │  自我進化    │
                    └──────┬──────┘
                           │
                    ┌──────▼──────┐
                    │   Hooks     │
                    │  自動觸發    │
                    └─────────────┘
```

## 社群貢獻

