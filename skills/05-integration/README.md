# 05-integration

> 外部工具整合：skillpkg、PAL、spec-workflow、Hooks

## 本模組包含

| 文件 | 整合對象 | 用途 |
|------|----------|------|
| [skillpkg.md](./_base/skillpkg.md) | skillpkg MCP | Skill 搜尋、安裝、載入 |
| [pal-tools.md](./_base/pal-tools.md) | PAL MCP | 多模型協作、深度分析 |
| [spec-workflow.md](./_base/spec-workflow.md) | spec-workflow MCP | 需求到實作轉換 |
| [hooks.md](./_base/hooks.md) | Claude Code Hooks | 自動化觸發 |

## 整合概覽

```
┌─────────────┐     ┌─────────────┐     ┌─────────────┐
│  skillpkg   │     │    PAL      │     │ spec-flow   │
│  技能管理   │     │  多模型協作  │     │  結構化規劃  │
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

在 [community/](./community/) 目錄添加你的整合配置、工具腳本等。
