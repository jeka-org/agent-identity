#!/bin/bash
# Session Bridging - Generate "previously on..." context brief
# Usage: ./session-bridge.sh [days]

set -e

DAYS="${1:-3}"

# Configure these paths for your setup
WORKSPACE="${WORKSPACE:-$HOME/.openclaw/workspace}"
MEMORY_DIR="${MEMORY_DIR:-$WORKSPACE/memory}"
DECISIONS_FILE="${DECISIONS_FILE:-$MEMORY_DIR/decisions.md}"
GOALS_FILE="${GOALS_FILE:-$MEMORY_DIR/daily-goals.md}"

echo "# Session Bridge — Recent Context"
echo ""
echo "_Generated: $(date -u +'%Y-%m-%d %H:%M UTC')_"
echo ""

# Scan recent daily memory files
for i in $(seq 0 $((DAYS-1))); do
    # Cross-platform date handling
    if date -v-${i}d +%Y-%m-%d >/dev/null 2>&1; then
        DATE=$(date -v-${i}d +%Y-%m-%d)  # macOS
    else
        DATE=$(date -d "$i days ago" +%Y-%m-%d)  # Linux
    fi
    
    FILE="$MEMORY_DIR/$DATE.md"
    
    if [ -f "$FILE" ]; then
        echo "## $DATE"
        # Extract structure: headers and bold key points
        grep -E "^##|^###|^\*\*[A-Z]" "$FILE" 2>/dev/null | head -15 || true
        echo ""
    fi
done

# Recent decisions
if [ -f "$DECISIONS_FILE" ]; then
    echo "## Recent Decisions"
    grep "^## [0-9]" "$DECISIONS_FILE" 2>/dev/null | tail -5 || echo "_No decisions logged_"
    echo ""
fi

# Current goals
if [ -f "$GOALS_FILE" ]; then
    echo "## Open Goals"
    grep "^\- \[ \]" "$GOALS_FILE" 2>/dev/null | head -10 || echo "_No open goals_"
    echo ""
fi

echo "---"
echo "_Use this context to orient yourself. Don't re-read everything._"
