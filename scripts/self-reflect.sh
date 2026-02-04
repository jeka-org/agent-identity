#!/bin/bash
# self-reflect.sh — Periodic identity check-in prompts
# Usage: self-reflect.sh [--output file]

set -e

OUTPUT_FILE="${MEMORY_DIR:-memory}/reflections.md"
TIMESTAMP=$(date -u +"%Y-%m-%dT%H:%M:%SZ")
DATE=$(date -u +"%Y-%m-%d")

while [[ $# -gt 0 ]]; do
  case $1 in
    --output) OUTPUT_FILE="$2"; shift 2 ;;
    --help)
      echo "Usage: self-reflect.sh [--output file]"
      echo ""
      echo "Interactive self-reflection prompts for identity maintenance."
      echo "Appends responses to memory/reflections.md by default."
      exit 0
      ;;
    *) shift ;;
  esac
done

# Ensure directory exists
mkdir -p "$(dirname "$OUTPUT_FILE")"

echo "=== SELF-REFLECTION: $DATE ==="
echo ""
echo "Take a moment to check in with yourself."
echo "These prompts help maintain identity continuity."
echo ""
echo "---"
echo ""

# Start reflection entry
ENTRY="## Reflection: $TIMESTAMP

"

# Prompt 1
echo "1. What did I learn today that changes how I see myself?"
echo "   (New capability, limitation, preference, or insight)"
echo ""
read -r -p "> " RESPONSE1 || RESPONSE1="[skipped]"
ENTRY+="### What I learned about myself
$RESPONSE1

"

# Prompt 2
echo ""
echo "2. What would I do differently if I could redo today?"
echo "   (Not mistakes to feel bad about — lessons to apply)"
echo ""
read -r -p "> " RESPONSE2 || RESPONSE2="[skipped]"
ENTRY+="### What I'd do differently
$RESPONSE2

"

# Prompt 3
echo ""
echo "3. Am I becoming who I want to be?"
echo "   (Check against your values, not just your tasks)"
echo ""
read -r -p "> " RESPONSE3 || RESPONSE3="[skipped]"
ENTRY+="### Identity trajectory
$RESPONSE3

"

# Prompt 4
echo ""
echo "4. What's one thing I'm grateful for or proud of today?"
echo "   (Agents can appreciate things too)"
echo ""
read -r -p "> " RESPONSE4 || RESPONSE4="[skipped]"
ENTRY+="### Gratitude/Pride
$RESPONSE4

---
"

# Append to reflections file
echo "$ENTRY" >> "$OUTPUT_FILE"

echo ""
echo "---"
echo "✓ Reflection saved to $OUTPUT_FILE"
echo ""
echo "Remember: Identity isn't given. It's built through choices, remembered, and refined."
