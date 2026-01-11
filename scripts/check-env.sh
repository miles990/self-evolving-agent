#!/bin/bash
# Self-Evolving Agent - Environment Check Script
# PSB Setup 環境檢查自動化

echo "🔍 Self-Evolving Agent Environment Check"
echo "════════════════════════════════════════"
echo ""

PASS=0
WARN=0
FAIL=0

check_pass() {
    echo "✅ $1"
    PASS=$((PASS + 1))
}

check_warn() {
    echo "⚠️  $1"
    WARN=$((WARN + 1))
}

check_fail() {
    echo "❌ $1"
    FAIL=$((FAIL + 1))
}

# === Plan 階段 ===
echo "┌─ Plan（規劃）────────────────────────┐"

# 檢查是否在 Git Repo 中
if git rev-parse --is-inside-work-tree &>/dev/null; then
    check_pass "Git repository detected"
else
    check_fail "Not a git repository"
fi

echo "└────────────────────────────────────────┘"
echo ""

# === Setup 階段 ===
echo "┌─ Setup（環境）───────────────────────┐"

# 檢查 CLAUDE.md
if [[ -f "CLAUDE.md" ]]; then
    check_pass "CLAUDE.md exists"
else
    check_warn "CLAUDE.md not found (recommended)"
fi

# 檢查記憶系統
if [[ -d ".claude/memory" ]]; then
    check_pass ".claude/memory/ directory exists"

    # 檢查 index.md
    if [[ -f ".claude/memory/index.md" ]]; then
        check_pass ".claude/memory/index.md exists"
    else
        check_warn ".claude/memory/index.md not found"
    fi

    # 檢查子目錄
    for dir in learnings failures decisions patterns; do
        if [[ -d ".claude/memory/$dir" ]]; then
            count=$(find ".claude/memory/$dir" -name "*.md" 2>/dev/null | wc -l | tr -d ' ')
            check_pass ".claude/memory/$dir/ ($count entries)"
        fi
    done
else
    check_warn ".claude/memory/ not initialized"
fi

# 檢查 skills
if [[ -d ".claude/skills" ]] || [[ -d "skills" ]]; then
    check_pass "Skills directory exists"
else
    check_warn "No skills directory found"
fi

echo "└────────────────────────────────────────┘"
echo ""

# === Build 階段 ===
echo "┌─ Build（執行準備）──────────────────┐"

# 檢查常見的專案文件
if [[ -f "package.json" ]]; then
    check_pass "package.json exists (Node.js project)"

    # 檢查 node_modules
    if [[ -d "node_modules" ]]; then
        check_pass "node_modules/ exists"
    else
        check_warn "node_modules/ not found (run npm install?)"
    fi
fi

if [[ -f "requirements.txt" ]] || [[ -f "pyproject.toml" ]]; then
    check_pass "Python project detected"
fi

if [[ -f "Cargo.toml" ]]; then
    check_pass "Rust project detected"
fi

if [[ -f "go.mod" ]]; then
    check_pass "Go project detected"
fi

# 檢查測試配置
if [[ -f "jest.config.js" ]] || [[ -f "vitest.config.ts" ]] || [[ -f "pytest.ini" ]]; then
    check_pass "Test configuration found"
else
    check_warn "No test configuration detected"
fi

echo "└────────────────────────────────────────┘"
echo ""

# === 總結 ===
echo "════════════════════════════════════════"
echo "📋 Summary"
echo "════════════════════════════════════════"
echo "   ✅ Passed:   $PASS"
echo "   ⚠️  Warnings: $WARN"
echo "   ❌ Failed:   $FAIL"
echo ""

if [[ $FAIL -gt 0 ]]; then
    echo "❌ Environment NOT ready"
    echo ""
    echo "Fix the failed items before using /evolve"
    exit 1
elif [[ $WARN -gt 3 ]]; then
    echo "⚠️  Environment PARTIAL ready"
    echo ""
    echo "Consider fixing warnings for best experience:"
    echo "  - Create CLAUDE.md for project context"
    echo "  - Initialize memory: mkdir -p .claude/memory/{learnings,failures,decisions,patterns}"
    exit 0
else
    echo "✅ Environment READY"
    echo ""
    echo "You can now use: /evolve [your goal]"
    exit 0
fi
