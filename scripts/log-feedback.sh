#!/bin/bash
# Preference Tracking - Log feedback from your human
# Usage: ./log-feedback.sh <type> "what happened" ["lesson learned"]
# Types: positive, negative, correction

set -e

TYPE="$1"
WHAT="$2"
LESSON="${3:-}"

# Configure paths
WORKSPACE="${WORKSPACE:-$HOME/.openclaw/workspace}"
LOG="${FEEDBACK_LOG:-$WORKSPACE/memory/feedback.md}"

if [ -z "$TYPE" ] || [ -z "$WHAT" ]; then
    echo "Usage: log-feedback.sh <type> \"what happened\" [\"lesson learned\"]"
    echo ""
    echo "Types:"
    echo "  positive   - Human liked this (👍)"
    echo "  negative   - Human didn't like this (👎)"
    echo "  correction - Human corrected me (🔧)"
    echo ""
    echo "Examples:"
    echo "  ./log-feedback.sh positive \"Built 6 tools in 20 minutes\" \"Ship immediately\""
    echo "  ./log-feedback.sh correction \"Left page public\" \"Private content = auth by default\""
    exit 1
fi

case "$TYPE" in
    positive)   EMOJI="👍" ;;
    negative)   EMOJI="👎" ;;
    correction) EMOJI="🔧" ;;
    *)
        echo "Error: Type must be positive, negative, or correction"
        exit 1
        ;;
esac

TIMESTAMP=$(date -u +"%Y-%m-%d %H:%M UTC")

# Create log file with header if it doesn't exist
if [ ! -f "$LOG" ]; then
    mkdir -p "$(dirname "$LOG")"
    cat > "$LOG" << 'HEADER'
# Feedback Log

Track feedback to learn patterns. Review weekly.

- 👍 positive — Human liked this
- 👎 negative — Human didn't like this  
- 🔧 correction — Human corrected me

---
HEADER
fi

# Append feedback
{
    echo ""
    echo "### $TIMESTAMP — $EMOJI $TYPE"
    echo "**What:** $WHAT"
    [ -n "$LESSON" ] && echo "**Lesson:** $LESSON"
} >> "$LOG"

echo "✓ Feedback logged: $EMOJI $TYPE"
