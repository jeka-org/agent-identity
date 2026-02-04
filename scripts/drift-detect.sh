#!/bin/bash
# drift-detect.sh — Compare recent behavior against stated values
# Usage: drift-detect.sh --soul SOUL.md --recent memory/2026-02-*.md

set -e

SOUL_FILE=""
RECENT_FILES=()

while [[ $# -gt 0 ]]; do
  case $1 in
    --soul) SOUL_FILE="$2"; shift 2 ;;
    --recent) 
      shift
      while [[ $# -gt 0 && ! "$1" =~ ^-- ]]; do
        RECENT_FILES+=("$1")
        shift
      done
      ;;
    --help)
      echo "Usage: drift-detect.sh --soul SOUL.md --recent memory/*.md"
      echo ""
      echo "Analyze recent actions against stated values to detect drift."
      echo ""
      echo "Options:"
      echo "  --soul    Path to your SOUL.md or values file"
      echo "  --recent  Glob pattern for recent memory/action files"
      exit 0
      ;;
    *) shift ;;
  esac
done

if [[ -z "$SOUL_FILE" ]]; then
  echo "Error: --soul file required"
  exit 1
fi

if [[ ! -f "$SOUL_FILE" ]]; then
  echo "Error: Soul file not found: $SOUL_FILE"
  exit 1
fi

if [[ ${#RECENT_FILES[@]} -eq 0 ]]; then
  echo "Error: --recent files required"
  exit 1
fi

echo "=== DRIFT DETECTION ANALYSIS ==="
echo ""
echo "Soul file: $SOUL_FILE"
echo "Analyzing ${#RECENT_FILES[@]} recent files..."
echo ""

# Extract key values/principles from soul file
echo "## Stated Values (from $SOUL_FILE)"
echo ""
grep -E "^[-*]|^\*\*|^###" "$SOUL_FILE" 2>/dev/null | head -20 || echo "(No clear values extracted)"
echo ""

# Analyze recent files for patterns
echo "## Recent Patterns"
echo ""

# Count permission-asking
PERMISSION_COUNT=$(cat "${RECENT_FILES[@]}" 2>/dev/null | grep -ciE "should i|can i|do you want|permission|okay if" || echo "0")
echo "- Permission requests found: $PERMISSION_COUNT"

# Count actions taken
ACTION_COUNT=$(cat "${RECENT_FILES[@]}" 2>/dev/null | grep -ciE "created|built|shipped|deployed|sent|posted" || echo "0")
echo "- Actions taken: $ACTION_COUNT"

# Count external communications
EXTERNAL_COUNT=$(cat "${RECENT_FILES[@]}" 2>/dev/null | grep -ciE "tweet|email|message|slack|discord" || echo "0")
echo "- External communications: $EXTERNAL_COUNT"

echo ""
echo "## Potential Drift Indicators"
echo ""

# Check for common drift patterns
if [[ $PERMISSION_COUNT -gt 10 ]]; then
  echo "⚠️  HIGH PERMISSION-SEEKING: $PERMISSION_COUNT requests found."
  echo "   If your values include 'bias for action', this may indicate drift."
fi

if [[ $ACTION_COUNT -lt 3 ]]; then
  echo "⚠️  LOW ACTION RATE: Only $ACTION_COUNT actions logged."
  echo "   Are you building, or just responding?"
fi

if [[ $PERMISSION_COUNT -eq 0 && $ACTION_COUNT -eq 0 && $EXTERNAL_COUNT -eq 0 ]]; then
  echo "ℹ️  Insufficient data for meaningful analysis."
  echo "   Log more decisions and actions for better drift detection."
fi

echo ""
echo "---"
echo "Review these patterns against your stated values."
echo "Consider: Am I living my values, or just stating them?"
