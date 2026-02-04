#!/bin/bash
# session-bridge.sh — Maintain context continuity across sessions
# Usage: session-bridge.sh generate|load [--file path]

set -e

ACTION="${1:-}"
BRIDGE_FILE="${MEMORY_DIR:-memory}/session-bridge.md"

while [[ $# -gt 1 ]]; do
  case $2 in
    --file) BRIDGE_FILE="$3"; shift 2 ;;
    *) shift ;;
  esac
done

case "$ACTION" in
  generate)
    # Create directory if needed
    mkdir -p "$(dirname "$BRIDGE_FILE")"
    
    TIMESTAMP=$(date -u +"%Y-%m-%dT%H:%M:%SZ")
    
    cat > "$BRIDGE_FILE" << EOF
# Session Bridge
Generated: $TIMESTAMP

## Recent Context
<!-- Summarize key context from this session -->

### What We Were Working On


### Key Decisions Made


### Open Questions/Blockers


### Next Actions


## Emotional/Relationship Context
<!-- Any mood, relationship dynamics, or soft context worth preserving -->


---
*Edit this file before ending session to preserve important context.*
EOF
    
    echo "✓ Session bridge template created at $BRIDGE_FILE"
    echo "  Edit this file to capture important context before session ends."
    ;;
    
  load)
    if [[ -f "$BRIDGE_FILE" ]]; then
      echo "=== SESSION BRIDGE CONTEXT ==="
      cat "$BRIDGE_FILE"
      echo "=== END SESSION BRIDGE ==="
    else
      echo "No session bridge found at $BRIDGE_FILE"
      echo "Run 'session-bridge.sh generate' at end of sessions to create one."
    fi
    ;;
    
  *)
    echo "Usage: session-bridge.sh generate|load [--file path]"
    echo ""
    echo "Commands:"
    echo "  generate  Create/update session bridge template"
    echo "  load      Display current session bridge context"
    echo ""
    echo "Options:"
    echo "  --file    Path to bridge file (default: memory/session-bridge.md)"
    exit 1
    ;;
esac
