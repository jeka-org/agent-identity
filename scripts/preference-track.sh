#!/bin/bash
# preference-track.sh — Track learned preferences from corrections
# Usage: preference-track.sh add|list|check|remove "preference" [--context "why"]

set -e

ACTION="${1:-}"
PREF_FILE="${MEMORY_DIR:-memory}/preferences.json"

# Ensure directory exists
mkdir -p "$(dirname "$PREF_FILE")"

# Initialize file if needed
if [[ ! -f "$PREF_FILE" ]]; then
  echo '{"preferences":[]}' > "$PREF_FILE"
fi

case "$ACTION" in
  add)
    PREFERENCE="${2:-}"
    CONTEXT=""
    shift 2 || true
    
    while [[ $# -gt 0 ]]; do
      case $1 in
        --context) CONTEXT="$2"; shift 2 ;;
        *) shift ;;
      esac
    done
    
    if [[ -z "$PREFERENCE" ]]; then
      echo "Error: Preference text required"
      echo "Usage: preference-track.sh add \"preference\" [--context \"why\"]"
      exit 1
    fi
    
    TIMESTAMP=$(date -u +"%Y-%m-%dT%H:%M:%SZ")
    
    # Add preference using jq if available, otherwise use simple append
    if command -v jq &> /dev/null; then
      TEMP=$(mktemp)
      jq --arg pref "$PREFERENCE" --arg ctx "$CONTEXT" --arg ts "$TIMESTAMP" \
        '.preferences += [{"text": $pref, "context": $ctx, "learned": $ts}]' \
        "$PREF_FILE" > "$TEMP" && mv "$TEMP" "$PREF_FILE"
    else
      # Fallback: simple text append
      echo "$TIMESTAMP | $PREFERENCE | $CONTEXT" >> "${PREF_FILE%.json}.txt"
      echo "Note: Install jq for better JSON handling"
    fi
    
    echo "✓ Preference added: $PREFERENCE"
    [[ -n "$CONTEXT" ]] && echo "  Context: $CONTEXT"
    ;;
    
  list)
    echo "=== LEARNED PREFERENCES ==="
    echo ""
    if command -v jq &> /dev/null; then
      jq -r '.preferences[] | "• \(.text)\n  Context: \(.context)\n  Learned: \(.learned)\n"' "$PREF_FILE" 2>/dev/null || echo "No preferences stored."
    else
      cat "${PREF_FILE%.json}.txt" 2>/dev/null || cat "$PREF_FILE" 2>/dev/null || echo "No preferences stored."
    fi
    ;;
    
  check)
    TEXT="${2:-}"
    if [[ -z "$TEXT" ]]; then
      echo "Usage: preference-track.sh check \"text to check\""
      exit 1
    fi
    
    echo "Checking against preferences..."
    VIOLATIONS=0
    
    if command -v jq &> /dev/null; then
      while IFS= read -r pref; do
        if echo "$TEXT" | grep -qi "$pref" 2>/dev/null; then
          echo "⚠️  Potential violation: $pref"
          VIOLATIONS=$((VIOLATIONS + 1))
        fi
      done < <(jq -r '.preferences[].text' "$PREF_FILE" 2>/dev/null)
    fi
    
    if [[ $VIOLATIONS -eq 0 ]]; then
      echo "✓ No preference violations detected"
    else
      echo ""
      echo "Found $VIOLATIONS potential violation(s)"
    fi
    ;;
    
  remove)
    PATTERN="${2:-}"
    if [[ -z "$PATTERN" ]]; then
      echo "Usage: preference-track.sh remove \"pattern\""
      exit 1
    fi
    
    if command -v jq &> /dev/null; then
      TEMP=$(mktemp)
      jq --arg pat "$PATTERN" '.preferences = [.preferences[] | select(.text | test($pat; "i") | not)]' \
        "$PREF_FILE" > "$TEMP" && mv "$TEMP" "$PREF_FILE"
      echo "✓ Removed preferences matching: $PATTERN"
    else
      echo "Error: jq required for remove operation"
      exit 1
    fi
    ;;
    
  *)
    echo "Usage: preference-track.sh add|list|check|remove \"preference\" [--context \"why\"]"
    echo ""
    echo "Commands:"
    echo "  add      Add a new learned preference"
    echo "  list     Show all preferences"
    echo "  check    Check text against preferences"
    echo "  remove   Remove preferences matching pattern"
    exit 1
    ;;
esac
