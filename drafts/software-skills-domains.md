# Claude Software Skills - 領域清單草案

> 參考 claude-scientific-skills 架構，為軟體開發領域設計的技能集合

---

## 總覽

| 大類 | 子領域數 | 技能數(估) |
|------|----------|------------|
| Software Design | 6 | 35+ |
| Software Engineering | 7 | 45+ |
| Development Stacks | 8 | 60+ |
| Tools & Integrations | 6 | 30+ |
| Domain Applications | 5 | 25+ |
| Programming Languages | 12 | 70+ |
| **總計** | **44** | **265+** |

---

## 1. Software Design（軟體設計）

### 1.1 Architecture Patterns（架構模式）
| 技能 | 說明 | 關鍵概念 |
|------|------|----------|
| Monolithic | 單體架構設計 | 模組化、分層、部署策略 |
| Microservices | 微服務架構 | 服務拆分、API Gateway、服務網格 |
| Event-Driven | 事件驅動架構 | Event Sourcing、CQRS、Saga |
| Serverless | 無伺服器架構 | FaaS、BaaS、冷啟動優化 |
| Clean Architecture | 整潔架構 | 依賴反轉、六角架構、領域分離 |
| Domain-Driven Design | 領域驅動設計 | Bounded Context、Aggregates、Ubiquitous Language |

### 1.2 Design Patterns（設計模式）
| 技能 | 說明 | 包含模式 |
|------|------|----------|
| Creational Patterns | 創建型模式 | Factory、Builder、Singleton、Prototype |
| Structural Patterns | 結構型模式 | Adapter、Decorator、Facade、Proxy |
| Behavioral Patterns | 行為型模式 | Observer、Strategy、Command、State |
| Concurrency Patterns | 並發模式 | Producer-Consumer、Thread Pool、Actor |
| Functional Patterns | 函數式模式 | Monad、Functor、Lens、Transducer |

### 1.3 API Design（API 設計）
| 技能 | 說明 | 關鍵概念 |
|------|------|----------|
| RESTful API | REST 風格 API | 資源命名、HTTP 語意、HATEOAS |
| GraphQL | 圖查詢語言 | Schema、Resolver、N+1 問題 |
| gRPC | 高效能 RPC | Protocol Buffers、串流、雙向通訊 |
| WebSocket | 即時通訊 | 連接管理、心跳、重連策略 |
| API Versioning | 版本管理 | URL/Header/Query 策略、相容性 |
| API Documentation | API 文件 | OpenAPI、AsyncAPI、文件生成 |

### 1.4 System Design（系統設計）
| 技能 | 說明 | 關鍵概念 |
|------|------|----------|
| Scalability | 可擴展性設計 | 水平/垂直擴展、分片、負載均衡 |
| High Availability | 高可用設計 | 冗餘、故障轉移、SLA |
| Distributed Systems | 分散式系統 | CAP、一致性、分區容錯 |
| Caching Strategies | 快取策略 | Cache-Aside、Write-Through、TTL |
| Message Queues | 訊息佇列 | Pub/Sub、At-least-once、背壓 |
| Rate Limiting | 流量控制 | 令牌桶、滑動窗口、熔斷 |

### 1.5 Data Design（資料設計）
| 技能 | 說明 | 關鍵概念 |
|------|------|----------|
| Data Modeling | 資料建模 | ER 圖、正規化、反正規化 |
| Schema Design | Schema 設計 | SQL/NoSQL Schema、演進策略 |
| Data Pipelines | 資料管線 | ETL、ELT、資料流架構 |
| Data Governance | 資料治理 | 資料品質、血緣追蹤、隱私 |

### 1.6 UX/UI Principles（使用者體驗）
| 技能 | 說明 | 關鍵概念 |
|------|------|----------|
| Usability Principles | 易用性原則 | Nielsen 十原則、認知負荷 |
| Accessibility | 無障礙設計 | WCAG、ARIA、螢幕閱讀器 |
| Responsive Design | 響應式設計 | 斷點、流體佈局、Mobile-First |
| Design Systems | 設計系統 | 元件庫、Token、一致性 |
| Information Architecture | 資訊架構 | 導航、分類、搜尋 |

---

## 2. Software Engineering（軟體工程）

### 2.1 Code Quality（程式碼品質）
| 技能 | 說明 | 工具/方法 |
|------|------|-----------|
| Clean Code | 整潔程式碼 | 命名、函數設計、SOLID |
| Code Review | 程式碼審查 | Review 流程、Checklist、工具 |
| Static Analysis | 靜態分析 | Linting、Type Checking、複雜度 |
| Refactoring | 重構技術 | 重構模式、安全重構、技術債 |
| Code Metrics | 程式碼指標 | 覆蓋率、複雜度、耦合度 |

### 2.2 Testing Strategies（測試策略）
| 技能 | 說明 | 工具/框架 |
|------|------|-----------|
| Unit Testing | 單元測試 | Jest, Pytest, JUnit, Mocking |
| Integration Testing | 整合測試 | Testcontainers, API 測試 |
| E2E Testing | 端對端測試 | Playwright, Cypress, Selenium |
| Performance Testing | 效能測試 | k6, Locust, Artillery |
| Property-Based Testing | 屬性測試 | Hypothesis, fast-check |
| Contract Testing | 契約測試 | Pact, Spring Cloud Contract |
| TDD/BDD | 測試驅動開發 | Red-Green-Refactor, Cucumber |

### 2.3 DevOps & CI/CD
| 技能 | 說明 | 工具 |
|------|------|------|
| CI Pipelines | 持續整合 | GitHub Actions, GitLab CI, Jenkins |
| CD Strategies | 持續部署 | Blue-Green, Canary, Rolling |
| Infrastructure as Code | 基礎設施即代碼 | Terraform, Pulumi, CloudFormation |
| Container Orchestration | 容器編排 | Kubernetes, Docker Swarm |
| GitOps | Git 運維 | ArgoCD, Flux, Helm |
| Environment Management | 環境管理 | Dev/Staging/Prod, Feature Flags |

### 2.4 Performance Optimization（效能優化）
| 技能 | 說明 | 關鍵技術 |
|------|------|----------|
| Profiling | 效能剖析 | CPU/Memory Profiling, Flame Graph |
| Frontend Performance | 前端效能 | Core Web Vitals, Bundle 優化 |
| Backend Performance | 後端效能 | N+1 查詢、連接池、非同步 |
| Database Optimization | 資料庫優化 | 索引、查詢計劃、分區 |
| Caching Implementation | 快取實作 | Redis, Memcached, CDN |

### 2.5 Security Practices（安全實踐）
| 技能 | 說明 | 關鍵概念 |
|------|------|----------|
| OWASP Top 10 | 常見安全風險 | Injection, XSS, CSRF, SSRF |
| Authentication | 身份驗證 | OAuth2, OIDC, JWT, MFA |
| Authorization | 授權機制 | RBAC, ABAC, Policy Engine |
| Secure Coding | 安全編碼 | Input Validation, Output Encoding |
| Security Testing | 安全測試 | SAST, DAST, Penetration Testing |
| Secrets Management | 密鑰管理 | Vault, AWS Secrets Manager |

### 2.6 Reliability Engineering（可靠性工程）
| 技能 | 說明 | 關鍵概念 |
|------|------|----------|
| SRE Principles | SRE 原則 | SLI/SLO/SLA, Error Budget |
| Observability | 可觀測性 | Metrics, Logs, Traces |
| Incident Management | 事件管理 | On-Call, Postmortem, Runbook |
| Chaos Engineering | 混沌工程 | Fault Injection, Game Day |
| Disaster Recovery | 災難恢復 | RTO/RPO, Backup, Failover |

### 2.7 Documentation（文件撰寫）
| 技能 | 說明 | 工具/格式 |
|------|------|----------|
| Technical Writing | 技術寫作 | 清晰表達、結構化、受眾分析 |
| Architecture Decision Records | ADR | 決策記錄、模板、維護 |
| API Documentation | API 文件 | OpenAPI, Swagger, Redoc |
| Runbooks | 操作手冊 | SOP, 故障排除指南 |
| Onboarding Docs | 入職文件 | 環境設定、專案導覽 |

---

## 3. Development Stacks（開發技術棧）

### 3.1 Frontend Frameworks
| 技能 | 說明 | 生態系 |
|------|------|--------|
| React | 元件化 UI | Next.js, Redux, React Query |
| Vue | 漸進式框架 | Nuxt, Pinia, Vue Router |
| Svelte | 編譯時框架 | SvelteKit, Svelte Store |
| Angular | 企業級框架 | RxJS, NgRx, Angular Material |
| Solid | 細粒度響應式 | SolidStart |
| Astro | 內容網站 | Islands Architecture |

### 3.2 Backend Frameworks
| 技能 | 說明 | 語言/框架 |
|------|------|----------|
| Node.js | JavaScript 後端 | Express, Fastify, NestJS |
| Python Backend | Python 後端 | FastAPI, Django, Flask |
| Go Backend | Go 後端 | Gin, Echo, Fiber |
| Rust Backend | Rust 後端 | Actix, Axum, Rocket |
| Java/Kotlin | JVM 後端 | Spring Boot, Ktor, Quarkus |
| .NET | C# 後端 | ASP.NET Core, Minimal APIs |

### 3.3 Mobile Development
| 技能 | 說明 | 平台 |
|------|------|------|
| React Native | 跨平台 RN | Expo, Navigation, Reanimated |
| Flutter | 跨平台 Flutter | Dart, Widget, State Management |
| iOS Native | 原生 iOS | Swift, SwiftUI, UIKit |
| Android Native | 原生 Android | Kotlin, Jetpack Compose |
| PWA | 漸進式網頁應用 | Service Worker, Web APIs |

### 3.4 Database Systems
| 技能 | 說明 | 技術 |
|------|------|------|
| PostgreSQL | 關聯式資料庫 | SQL, 進階功能, 擴展 |
| MySQL | 關聯式資料庫 | InnoDB, 複製, 分區 |
| MongoDB | 文件資料庫 | Aggregation, Sharding |
| Redis | 鍵值/快取 | 資料結構, Pub/Sub, Cluster |
| Elasticsearch | 搜尋引擎 | 索引, 查詢 DSL, 聚合 |
| Neo4j | 圖資料庫 | Cypher, 圖算法 |
| ClickHouse | OLAP 資料庫 | 列式存儲, 分析查詢 |

### 3.5 Cloud Platforms
| 技能 | 說明 | 服務 |
|------|------|------|
| AWS | Amazon 雲服務 | EC2, Lambda, S3, RDS, DynamoDB |
| GCP | Google 雲服務 | GCE, Cloud Functions, BigQuery |
| Azure | Microsoft 雲服務 | App Service, Functions, CosmosDB |
| Vercel | 前端部署平台 | Edge Functions, Analytics |
| Cloudflare | 邊緣運算 | Workers, R2, D1 |

### 3.6 AI/ML Integration
| 技能 | 說明 | 技術 |
|------|------|------|
| LLM Integration | 大型語言模型整合 | OpenAI, Anthropic, 本地模型 |
| RAG Systems | 檢索增強生成 | 向量資料庫, Embedding, Chunking |
| AI Agents | AI 代理系統 | LangChain, CrewAI, AutoGen |
| ML Ops | 機器學習運維 | MLflow, Weights & Biases |
| Prompt Engineering | 提示工程 | Chain-of-Thought, Few-shot |

### 3.7 Real-time Systems
| 技能 | 說明 | 技術 |
|------|------|------|
| WebSocket | 即時通訊 | Socket.io, ws, Ably |
| Server-Sent Events | 伺服器推送 | EventSource, 串流 |
| WebRTC | 點對點通訊 | 視訊/音訊, Data Channel |
| Streaming Platforms | 串流平台 | Kafka, Pulsar, Kinesis |

### 3.8 Edge & IoT
| 技能 | 說明 | 技術 |
|------|------|------|
| Edge Computing | 邊緣運算 | Cloudflare Workers, Deno Deploy |
| IoT Protocols | IoT 協議 | MQTT, CoAP, Modbus |
| Embedded Systems | 嵌入式系統 | Raspberry Pi, Arduino, ESP32 |

---

## 4. Tools & Integrations（工具與整合）

### 4.1 Version Control
| 技能 | 說明 | 工具/流程 |
|------|------|----------|
| Git Advanced | Git 進階操作 | Rebase, Cherry-pick, Bisect |
| Git Workflows | Git 工作流程 | GitFlow, Trunk-Based, GitHub Flow |
| Monorepo | 單一儲存庫 | Nx, Turborepo, Lerna |
| Code Collaboration | 協作開發 | PR Review, CODEOWNERS |

### 4.2 Project Management
| 技能 | 說明 | 工具 |
|------|------|------|
| Agile/Scrum | 敏捷開發 | Sprint Planning, Retrospective |
| Issue Tracking | 問題追蹤 | Jira, Linear, GitHub Issues |
| Knowledge Management | 知識管理 | Notion, Confluence, Obsidian |
| Roadmap Planning | 路線圖規劃 | ProductBoard, Aha! |

### 4.3 Development Environment
| 技能 | 說明 | 工具 |
|------|------|------|
| IDE & Editors | 開發環境 | VS Code, JetBrains, Vim/Neovim |
| Dev Containers | 開發容器 | Docker, devcontainer, Codespaces |
| Local Development | 本地開發 | Hot Reload, Mock Server, Proxy |
| Debugging | 除錯技巧 | Breakpoints, Logging, Tracing |

### 4.4 Monitoring & Observability
| 技能 | 說明 | 工具 |
|------|------|------|
| APM | 應用效能監控 | Datadog, New Relic, Dynatrace |
| Log Management | 日誌管理 | ELK Stack, Loki, Splunk |
| Distributed Tracing | 分散式追蹤 | Jaeger, Zipkin, OpenTelemetry |
| Alerting | 告警系統 | PagerDuty, Opsgenie, Alertmanager |

### 4.5 API & Integration Tools
| 技能 | 說明 | 工具 |
|------|------|------|
| API Testing | API 測試 | Postman, Insomnia, Bruno |
| API Gateway | API 閘道 | Kong, Apigee, AWS API Gateway |
| Service Mesh | 服務網格 | Istio, Linkerd, Consul |
| Webhook Management | Webhook 管理 | Svix, Hookdeck |

### 4.6 Automation
| 技能 | 說明 | 工具 |
|------|------|------|
| Task Automation | 任務自動化 | Make, n8n, Zapier |
| Code Generation | 程式碼生成 | Yeoman, Hygen, Plop |
| Dependency Management | 依賴管理 | Renovate, Dependabot |
| Release Automation | 發布自動化 | semantic-release, changesets |

---

## 5. Domain Applications（領域應用）

### 5.1 E-commerce
| 技能 | 說明 | 關鍵功能 |
|------|------|----------|
| Shopping Cart | 購物車系統 | 庫存同步、價格計算 |
| Payment Integration | 支付整合 | Stripe, PayPal, 金流處理 |
| Order Management | 訂單管理 | 狀態機、庫存扣減 |
| Product Catalog | 商品目錄 | 分類、搜尋、篩選 |

### 5.2 SaaS Platforms
| 技能 | 說明 | 關鍵功能 |
|------|------|----------|
| Multi-tenancy | 多租戶架構 | 隔離策略、資料分區 |
| Subscription Billing | 訂閱計費 | 方案管理、計費週期 |
| User Management | 用戶管理 | 角色權限、團隊協作 |
| Analytics Dashboard | 分析儀表板 | 指標追蹤、視覺化 |

### 5.3 Content Platforms
| 技能 | 說明 | 關鍵功能 |
|------|------|----------|
| CMS Development | 內容管理系統 | 編輯器、版本控制 |
| Media Processing | 媒體處理 | 圖片/影片轉換、CDN |
| Search Implementation | 搜尋實作 | 全文搜尋、相關性排序 |
| Commenting Systems | 評論系統 | 審核、通知、反垃圾 |

### 5.4 Communication Systems
| 技能 | 說明 | 關鍵功能 |
|------|------|----------|
| Chat Systems | 聊天系統 | 即時訊息、群組、已讀 |
| Notification Systems | 通知系統 | 多通道、偏好設定、排程 |
| Email Systems | 郵件系統 | 模板、追蹤、退訂 |
| Video Conferencing | 視訊會議 | WebRTC、錄製、共享 |

### 5.5 Developer Tools
| 技能 | 說明 | 關鍵功能 |
|------|------|----------|
| CLI Development | CLI 開發 | 參數解析、互動介面 |
| SDK Design | SDK 設計 | API 包裝、錯誤處理 |
| Plugin Systems | 插件系統 | 擴展點、隔離、版本 |
| Developer Portals | 開發者入口 | 文件、API Key、用量 |

---

## 6. Programming Languages（程式語言最佳實踐）

### 6.1 JavaScript / TypeScript
| 技能 | 說明 | 關鍵概念 |
|------|------|----------|
| Modern JS | ES6+ 特性 | 解構、展開、async/await、模組 |
| TypeScript Mastery | TS 進階 | 泛型、條件型別、型別守衛 |
| Error Handling | 錯誤處理 | Try-catch、自訂錯誤、Result 模式 |
| Memory Management | 記憶體管理 | 閉包、WeakMap、垃圾回收 |
| Performance | 效能優化 | Event Loop、Web Workers、V8 優化 |
| Module Systems | 模組系統 | ESM、CommonJS、Tree Shaking |

### 6.2 Python
| 技能 | 說明 | 關鍵概念 |
|------|------|----------|
| Pythonic Code | Python 風格 | PEP8、慣用語法、Zen of Python |
| Type Hints | 型別提示 | typing、Protocol、泛型 |
| Async Python | 非同步編程 | asyncio、協程、並行處理 |
| Memory & Performance | 效能優化 | 生成器、__slots__、Cython |
| Packaging | 套件管理 | Poetry、uv、pyproject.toml |
| Testing | 測試實踐 | pytest、fixtures、mocking |

### 6.3 Go
| 技能 | 說明 | 關鍵概念 |
|------|------|----------|
| Effective Go | Go 最佳實踐 | 慣用語法、錯誤處理、命名 |
| Concurrency | 並發編程 | Goroutine、Channel、Select |
| Error Handling | 錯誤處理 | errors 包、Wrap、自訂錯誤 |
| Memory Management | 記憶體管理 | 指標、逃逸分析、GC 調優 |
| Project Structure | 專案結構 | Standard Layout、內部包 |
| Testing | 測試實踐 | table-driven tests、benchmarks |

### 6.4 Rust
| 技能 | 說明 | 關鍵概念 |
|------|------|----------|
| Ownership | 所有權系統 | Borrow、Lifetime、Move |
| Error Handling | 錯誤處理 | Result、Option、? 運算子 |
| Traits | 特徵系統 | 泛型、Trait Bounds、impl |
| Async Rust | 非同步編程 | tokio、Future、Pin |
| Unsafe | 不安全程式碼 | 何時使用、FFI、最小化範圍 |
| Cargo | 專案管理 | workspace、features、publishing |

### 6.5 Java / Kotlin
| 技能 | 說明 | 關鍵概念 |
|------|------|----------|
| Modern Java | Java 17+ 特性 | Records、Pattern Matching、Virtual Threads |
| Kotlin Idioms | Kotlin 慣用法 | 空安全、擴展函數、協程 |
| JVM Tuning | JVM 調優 | GC 選擇、堆配置、效能分析 |
| Dependency Injection | 依賴注入 | Spring、Dagger、Koin |
| Reactive Programming | 響應式編程 | Project Reactor、Flow |
| Testing | 測試實踐 | JUnit5、Mockito、Kotest |

### 6.6 C# / .NET
| 技能 | 說明 | 關鍵概念 |
|------|------|----------|
| Modern C# | C# 12+ 特性 | Records、Pattern Matching、LINQ |
| Async/Await | 非同步編程 | Task、ValueTask、ConfigureAwait |
| Memory Management | 記憶體管理 | Span<T>、Memory<T>、IDisposable |
| Dependency Injection | 依賴注入 | Microsoft.Extensions.DI |
| Entity Framework | ORM 實踐 | Migrations、Query 優化 |
| Testing | 測試實踐 | xUnit、Moq、FluentAssertions |

### 6.7 C / C++
| 技能 | 說明 | 關鍵概念 |
|------|------|----------|
| Modern C++ | C++20/23 特性 | Concepts、Ranges、Coroutines |
| Memory Safety | 記憶體安全 | RAII、智能指針、邊界檢查 |
| Performance | 效能優化 | 快取友好、SIMD、編譯器優化 |
| Build Systems | 建構系統 | CMake、Conan、vcpkg |
| Debugging | 除錯技術 | Valgrind、sanitizers、gdb |
| Concurrency | 並發編程 | std::thread、atomic、mutex |

### 6.8 Ruby
| 技能 | 說明 | 關鍵概念 |
|------|------|----------|
| Ruby Style | Ruby 風格 | 慣用語法、Block、Duck Typing |
| Metaprogramming | 元編程 | method_missing、define_method |
| Rails Best Practices | Rails 實踐 | Convention、ActiveRecord、Service Objects |
| Testing | 測試實踐 | RSpec、Factory Bot、VCR |
| Performance | 效能優化 | N+1 查詢、快取、Sidekiq |

### 6.9 PHP
| 技能 | 說明 | 關鍵概念 |
|------|------|----------|
| Modern PHP | PHP 8+ 特性 | Attributes、Enums、Fibers |
| Laravel/Symfony | 框架實踐 | Service Container、Eloquent |
| Composer | 依賴管理 | Autoloading、Packagist |
| Testing | 測試實踐 | PHPUnit、Pest、Mockery |
| Security | 安全實踐 | Input Validation、CSRF、SQL Injection |

### 6.10 Swift
| 技能 | 說明 | 關鍵概念 |
|------|------|----------|
| Swift Style | Swift 風格 | 命名、API 設計指南 |
| Memory Management | 記憶體管理 | ARC、weak/unowned、循環引用 |
| Concurrency | 並發編程 | async/await、Actor、Task |
| SwiftUI | UI 開發 | 聲明式 UI、State Management |
| Error Handling | 錯誤處理 | throws、Result、do-catch |

### 6.11 Shell / Bash
| 技能 | 說明 | 關鍵概念 |
|------|------|----------|
| Script Best Practices | 腳本最佳實踐 | set -euo pipefail、trap |
| Text Processing | 文字處理 | awk、sed、grep、jq |
| Automation | 自動化 | cron、systemd、process management |
| Security | 安全實踐 | 輸入驗證、權限、secrets 處理 |

### 6.12 SQL
| 技能 | 說明 | 關鍵概念 |
|------|------|----------|
| Query Optimization | 查詢優化 | EXPLAIN、索引策略、JOIN 優化 |
| Advanced SQL | 進階 SQL | Window Functions、CTE、Recursive |
| Database Design | 資料庫設計 | 正規化、反正規化、分區 |
| Migration Patterns | 遷移模式 | 零停機遷移、向後相容 |

---

## 附錄：Skill 文件模板

每個 Skill 應包含：

```markdown
---
name: [skill-name]
description: [一句話描述]
domain: [所屬領域]
version: 1.0.0
tags: [tag1, tag2, tag3]
---

# [Skill Name]

## Overview
[技能概述與用途]

## Key Concepts
- **概念1**: 說明
- **概念2**: 說明

## Use Cases
- 情境1：[何時使用]
- 情境2：[何時使用]

## Best Practices
1. [最佳實踐1]
2. [最佳實踐2]

## Common Pitfalls
- [常見錯誤1]
- [常見錯誤2]

## Tools & Resources
| 工具 | 用途 | 連結 |
|------|------|------|
| Tool1 | 用途說明 | [link] |

## Examples
[實際程式碼或工作流程範例]

## Related Skills
- [[相關技能1]]
- [[相關技能2]]
```

---

## 下一步

1. **Review 此清單** - 確認領域劃分是否合理
2. **優先級排序** - 決定先建立哪些領域
3. **選擇格式** - 獨立 repo 或整合到 evolve
4. **開始實作** - 從高價值領域開始建立

---

*草案版本: 2025-01-05*
*參考: claude-scientific-skills*
