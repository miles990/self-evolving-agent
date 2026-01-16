#!/bin/bash
# sync-skills.sh - 從 GitHub 同步 skill 到 sqlite-memory
#
# 用途：將遠端 skill repos 的 metadata 索引到本地 sqlite-memory
# 這樣 evolve CP1 就能自動推薦相關 skill
#
# 使用方式：
#   ./scripts/sync-skills.sh              # 同步所有 repos
#   ./scripts/sync-skills.sh --software   # 只同步 software skills
#   ./scripts/sync-skills.sh --domain     # 只同步 domain skills
#   ./scripts/sync-skills.sh --list       # 列出已索引的 skills

set -e

# 配置
CACHE_DIR="${HOME}/.claude/skill-cache"
SOFTWARE_REPO="https://github.com/miles990/claude-software-skills.git"
DOMAIN_REPO="https://github.com/miles990/claude-domain-skills.git"
DB_PATH="${HOME}/.claude/claude.db"

# 顏色
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

log_info() { echo -e "${BLUE}[INFO]${NC} $1"; }
log_success() { echo -e "${GREEN}[OK]${NC} $1"; }
log_warn() { echo -e "${YELLOW}[WARN]${NC} $1"; }
log_error() { echo -e "${RED}[ERROR]${NC} $1"; }

# 確保快取目錄存在
mkdir -p "$CACHE_DIR"

# 轉義 SQL 字串中的單引號
escape_sql() {
    echo "$1" | sed "s/'/''/g"
}

# 解析 SKILL.md 並直接寫入資料庫
parse_and_index_skill() {
    local skill_file="$1"
    local repo_name="$2"
    local skill_path="$3"

    if [[ ! -f "$skill_file" ]]; then
        return 1
    fi

    # 提取 frontmatter（YAML 格式）
    local in_frontmatter=false
    local name=""
    local description=""
    local version=""
    local triggers=""

    while IFS= read -r line || [[ -n "$line" ]]; do
        if [[ "$line" == "---" ]]; then
            if $in_frontmatter; then
                break
            else
                in_frontmatter=true
                continue
            fi
        fi

        if $in_frontmatter; then
            # 解析 YAML 格式的 key: value
            if [[ "$line" =~ ^name:\ *(.*)$ ]]; then
                name="${BASH_REMATCH[1]}"
                # 移除引號
                name="${name#\"}"
                name="${name%\"}"
                name="${name#\'}"
                name="${name%\'}"
            elif [[ "$line" =~ ^description:\ *(.*)$ ]]; then
                description="${BASH_REMATCH[1]}"
                description="${description#\"}"
                description="${description%\"}"
            elif [[ "$line" =~ ^version:\ *(.*)$ ]]; then
                version="${BASH_REMATCH[1]}"
            elif [[ "$line" =~ ^triggers:\ *(.*)$ ]]; then
                triggers="${BASH_REMATCH[1]}"
            fi
        fi
    done < "$skill_file"

    # 如果沒有 name，使用目錄名
    if [[ -z "$name" ]]; then
        name=$(basename "$(dirname "$skill_file")")
    fi

    # 如果沒有 version，使用 1.0.0
    if [[ -z "$version" ]]; then
        version="1.0.0"
    fi

    # 從路徑提取 category
    local category
    category=$(echo "$skill_path" | cut -d'/' -f1)

    # 構建 memory key
    local key="skill:${repo_name}:${category}:${name}"

    # 構建 content（簡化格式）
    local content="name: ${name}
repo: github:miles990/${repo_name}
path: ${skill_path}
category: ${category}
triggers: ${triggers}"

    # 轉義 SQL 特殊字元
    local escaped_key=$(escape_sql "$key")
    local escaped_content=$(escape_sql "$content")
    local escaped_name=$(escape_sql "$name")

    # 構建 tags JSON
    local tags="[\"skill\",\"${category}\",\"${repo_name}\"]"

    # 寫入 sqlite-memory
    sqlite3 "$DB_PATH" "INSERT OR REPLACE INTO memory (key, content, tags, scope, source, updated_at) VALUES ('${escaped_key}', '${escaped_content}', '${tags}', 'global', 'sync-skills', datetime('now'));"

    # 獲取剛插入的 rowid
    local rowid
    rowid=$(sqlite3 "$DB_PATH" "SELECT id FROM memory WHERE key = '${escaped_key}';")

    # 更新 FTS 索引（先刪除再插入）
    sqlite3 "$DB_PATH" "INSERT INTO memory_fts(memory_fts, rowid, key, content, tags) VALUES ('delete', ${rowid}, '${escaped_key}', '${escaped_content}', '${tags}');" 2>/dev/null || true
    sqlite3 "$DB_PATH" "INSERT INTO memory_fts(rowid, key, content, tags) VALUES (${rowid}, '${escaped_key}', '${escaped_content}', '${tags}');"

    echo "  ✓ ${category}/${name}"
    return 0
}

# 同步單個 repo
sync_repo() {
    local repo_url="$1"
    local repo_name="$2"
    local cache_path="$CACHE_DIR/$repo_name"

    log_info "同步 $repo_name..."

    if [[ -d "$cache_path" ]]; then
        # 更新現有 repo
        log_info "更新快取: $cache_path"
        (cd "$cache_path" && git pull --quiet) || {
            log_warn "更新失敗，重新克隆"
            rm -rf "$cache_path"
            git clone --quiet --depth 1 "$repo_url" "$cache_path"
        }
    else
        # 克隆新 repo
        log_info "克隆 repo: $repo_url"
        git clone --quiet --depth 1 "$repo_url" "$cache_path"
    fi

    log_success "同步完成: $repo_name"
}

# 索引 skills 到 sqlite-memory
index_skills() {
    local cache_path="$1"
    local repo_name="$2"
    local count=0

    log_info "索引 $repo_name 的 skills..."

    # 查找所有 SKILL.md 文件
    while IFS= read -r skill_file; do
        # 計算相對路徑
        local rel_path="${skill_file#$cache_path/}"
        local skill_path=$(dirname "$rel_path")

        # 跳過根目錄的 SKILL.md 和隱藏目錄
        if [[ "$skill_path" == "." ]] || [[ "$skill_path" == *"/.claude"* ]] || [[ "$skill_path" == ".claude"* ]]; then
            continue
        fi

        # 解析並索引
        if parse_and_index_skill "$skill_file" "$repo_name" "$skill_path"; then
            ((count++))
        fi
    done < <(find "$cache_path" -name "SKILL.md" -type f 2>/dev/null)

    log_success "索引完成: $count skills"
    echo "$count"
}

# 列出已索引的 skills
list_indexed_skills() {
    log_info "已索引的 skills:"
    echo ""

    sqlite3 -header -column "$DB_PATH" <<EOF
SELECT
    key,
    substr(content, 1, 60) as preview,
    updated_at
FROM memory
WHERE key LIKE 'skill:%'
ORDER BY key;
EOF

    echo ""
    local count
    count=$(sqlite3 "$DB_PATH" "SELECT COUNT(*) FROM memory WHERE key LIKE 'skill:%';")
    log_info "共 $count 個 skills 已索引"
}

# 清除索引
clear_index() {
    log_warn "清除所有 skill 索引..."
    sqlite3 "$DB_PATH" "DELETE FROM memory WHERE key LIKE 'skill:%';"
    log_success "索引已清除"
}

# 主函數
main() {
    local sync_software=false
    local sync_domain=false
    local list_only=false
    local clear_only=false

    # 解析參數
    while [[ $# -gt 0 ]]; do
        case $1 in
            --software)
                sync_software=true
                shift
                ;;
            --domain)
                sync_domain=true
                shift
                ;;
            --list)
                list_only=true
                shift
                ;;
            --clear)
                clear_only=true
                shift
                ;;
            --help|-h)
                echo "用法: $0 [選項]"
                echo ""
                echo "選項:"
                echo "  --software   只同步 software skills"
                echo "  --domain     只同步 domain skills"
                echo "  --list       列出已索引的 skills"
                echo "  --clear      清除所有索引"
                echo "  --help       顯示此幫助"
                exit 0
                ;;
            *)
                log_error "未知選項: $1"
                exit 1
                ;;
        esac
    done

    # 確保資料庫存在
    if [[ ! -f "$DB_PATH" ]]; then
        log_error "sqlite-memory 資料庫不存在: $DB_PATH"
        log_info "請先啟動 sqlite-memory-mcp 或手動初始化"
        exit 1
    fi

    if $list_only; then
        list_indexed_skills
        exit 0
    fi

    if $clear_only; then
        clear_index
        exit 0
    fi

    # 如果沒有指定，同步所有
    if ! $sync_software && ! $sync_domain; then
        sync_software=true
        sync_domain=true
    fi

    local total=0

    if $sync_software; then
        sync_repo "$SOFTWARE_REPO" "claude-software-skills"
        local sw_count
        sw_count=$(index_skills "$CACHE_DIR/claude-software-skills" "claude-software-skills")
        ((total += sw_count)) || true
    fi

    if $sync_domain; then
        sync_repo "$DOMAIN_REPO" "claude-domain-skills"
        local dm_count
        dm_count=$(index_skills "$CACHE_DIR/claude-domain-skills" "claude-domain-skills")
        ((total += dm_count)) || true
    fi

    echo ""
    log_success "同步完成！"
    log_info "使用 memory_search 搜尋 skills"
}

main "$@"
