#!/bin/bash
# relationship-mem.sh — Track relationship context beyond tasks
# Usage: relationship-mem.sh add|get|list "person" [--note "context"] [--joke "shared humor"]

set -e

ACTION="${1:-}"
PERSON="${2:-}"
REL_DIR="${MEMORY_DIR:-memory}/relationships"

# Ensure directory exists
mkdir -p "$REL_DIR"

case "$ACTION" in
  add)
    if [[ -z "$PERSON" ]]; then
      echo "Error: Person name required"
      echo "Usage: relationship-mem.sh add \"person\" [--note \"context\"] [--joke \"humor\"]"
      exit 1
    fi
    
    NOTE=""
    JOKE=""
    shift 2 || true
    
    while [[ $# -gt 0 ]]; do
      case $1 in
        --note) NOTE="$2"; shift 2 ;;
        --joke) JOKE="$2"; shift 2 ;;
        *) shift ;;
      esac
    done
    
    FILENAME="$REL_DIR/$(echo "$PERSON" | tr '[:upper:]' '[:lower:]' | tr ' ' '-').md"
    TIMESTAMP=$(date -u +"%Y-%m-%d")
    
    # Create file with header if new
    if [[ ! -f "$FILENAME" ]]; then
      cat > "$FILENAME" << EOF
# $PERSON

## Context


## Shared History


## Inside Jokes


---
EOF
    fi
    
    # Append note
    if [[ -n "$NOTE" ]]; then
      echo "- [$TIMESTAMP] $NOTE" >> "$FILENAME"
      echo "✓ Added note for $PERSON: $NOTE"
    fi
    
    # Append joke
    if [[ -n "$JOKE" ]]; then
      # Insert into Inside Jokes section
      sed -i.bak "/## Inside Jokes/a\\
- [$TIMESTAMP] $JOKE" "$FILENAME" 2>/dev/null || echo "- [$TIMESTAMP] 😄 $JOKE" >> "$FILENAME"
      rm -f "$FILENAME.bak"
      echo "✓ Added inside joke for $PERSON: $JOKE"
    fi
    ;;
    
  get)
    if [[ -z "$PERSON" ]]; then
      echo "Error: Person name required"
      exit 1
    fi
    
    FILENAME="$REL_DIR/$(echo "$PERSON" | tr '[:upper:]' '[:lower:]' | tr ' ' '-').md"
    
    if [[ -f "$FILENAME" ]]; then
      echo "=== RELATIONSHIP: $PERSON ==="
      echo ""
      cat "$FILENAME"
    else
      echo "No relationship data found for: $PERSON"
      echo "Use 'relationship-mem.sh add \"$PERSON\" --note \"context\"' to start tracking."
    fi
    ;;
    
  list)
    echo "=== TRACKED RELATIONSHIPS ==="
    echo ""
    if ls "$REL_DIR"/*.md 1>/dev/null 2>&1; then
      for file in "$REL_DIR"/*.md; do
        NAME=$(basename "$file" .md | tr '-' ' ')
        LINES=$(wc -l < "$file" | tr -d ' ')
        echo "• $NAME ($LINES lines)"
      done
    else
      echo "No relationships tracked yet."
      echo "Use 'relationship-mem.sh add \"person\" --note \"context\"' to start."
    fi
    ;;
    
  *)
    echo "Usage: relationship-mem.sh add|get|list \"person\" [options]"
    echo ""
    echo "Commands:"
    echo "  add     Add context or joke for a person"
    echo "  get     View all info about a person"
    echo "  list    List all tracked relationships"
    echo ""
    echo "Options:"
    echo "  --note  Add contextual note"
    echo "  --joke  Add inside joke or shared humor"
    exit 1
    ;;
esac
