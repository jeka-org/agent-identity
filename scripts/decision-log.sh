#!/bin/bash
# decision-log.sh — Log decisions with reasoning for future reference
# Usage: decision-log.sh "decision" [--reasoning "why"] [--alternatives "options"] [--confidence high|medium|low]

set -e

DECISION=""
REASONING=""
ALTERNATIVES=""
CONFIDENCE="medium"
MEMORY_DIR="${MEMORY_DIR:-memory/decisions}"

while [[ $# -gt 0 ]]; do
  case $1 in
    --reasoning) REASONING="$2"; shift 2 ;;
    --alternatives) ALTERNATIVES="$2"; shift 2 ;;
    --confidence) CONFIDENCE="$2"; shift 2 ;;
    --help)
      echo "Usage: decision-log.sh \"decision\" [--reasoning \"why\"] [--alternatives \"options\"] [--confidence high|medium|low]"
      echo ""
      echo "Log decisions with context for future reference."
      echo ""
      echo "Options:"
      echo "  --reasoning     Why this decision was made"
      echo "  --alternatives  Other options considered"
      echo "  --confidence    Confidence level (high/medium/low)"
      exit 0
      ;;
    *) 
      if [[ -z "$DECISION" ]]; then
        DECISION="$1"
      fi
      shift
      ;;
  esac
done

if [[ -z "$DECISION" ]]; then
  echo "Error: Decision text required"
  echo "Usage: decision-log.sh \"decision\" [--reasoning \"why\"]"
  exit 1
fi

# Create memory directory if needed
mkdir -p "$MEMORY_DIR"

# Generate filename with timestamp
TIMESTAMP=$(date -u +"%Y-%m-%dT%H:%M:%SZ")
DATE=$(date -u +"%Y-%m-%d")
FILENAME="$MEMORY_DIR/$DATE.md"

# Build entry
ENTRY="## $TIMESTAMP

**Decision:** $DECISION
"

if [[ -n "$REASONING" ]]; then
  ENTRY+="**Reasoning:** $REASONING
"
fi

if [[ -n "$ALTERNATIVES" ]]; then
  ENTRY+="**Alternatives considered:** $ALTERNATIVES
"
fi

ENTRY+="**Confidence:** $CONFIDENCE

---
"

# Append to daily file
echo "$ENTRY" >> "$FILENAME"

echo "✓ Decision logged to $FILENAME"
echo "  Decision: $DECISION"
echo "  Confidence: $CONFIDENCE"
