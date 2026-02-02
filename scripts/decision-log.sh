#!/bin/bash
# Decision Journaling - Log decisions with reasoning
# Usage: ./decision-log.sh "decision" "reasoning" ["context"] ["tags"] [weight]

set -e

DECISION="$1"
REASONING="$2"
CONTEXT="${3:-}"
TAGS="${4:-}"
WEIGHT="${5:-3}"

# Configure these paths for your setup
WORKSPACE="${WORKSPACE:-$HOME/.openclaw/workspace}"
LOG="${DECISION_LOG:-$WORKSPACE/memory/decisions.md}"

if [ -z "$DECISION" ] || [ -z "$REASONING" ]; then
    echo "Usage: decision-log.sh \"decision\" \"reasoning\" [\"context\"] [\"tags\"] [weight]"
    echo ""
    echo "Examples:"
    echo "  ./decision-log.sh \"Use cron instead of heartbeat\" \"Needs exact timing\""
    echo "  ./decision-log.sh \"Ship now\" \"No reason to wait\" \"Building toolkit\" \"shipping\" 5"
    exit 1
fi

TIMESTAMP=$(date -u +"%Y-%m-%d %H:%M UTC")
DATE=$(date +%Y-%m-%d)

# Create log file with header if it doesn't exist
if [ ! -f "$LOG" ]; then
    mkdir -p "$(dirname "$LOG")"
    cat > "$LOG" << 'HEADER'
# Decision Log

Significant decisions with reasoning. So future-me knows *why*, not just *what*.

---
HEADER
fi

# Append decision
{
    echo ""
    echo "## $DATE — $DECISION"
    echo ""
    echo "**When:** $TIMESTAMP"
    echo "**Decision:** $DECISION"
    echo "**Reasoning:** $REASONING"
    [ -n "$CONTEXT" ] && echo "**Context:** $CONTEXT"
    [ -n "$TAGS" ] && echo "**Tags:** $TAGS"
    echo "**Outcome:** _(pending)_"
} >> "$LOG"

echo "✓ Decision logged: $DECISION"
