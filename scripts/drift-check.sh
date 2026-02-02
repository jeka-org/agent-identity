#!/bin/bash
# Drift Detection - Generate alignment checklist from values
# Usage: ./drift-check.sh [output-file] [soul-file]

set -e

# Configure paths
WORKSPACE="${WORKSPACE:-$HOME/.openclaw/workspace}"
SOUL_FILE="${2:-$WORKSPACE/SOUL.md}"
OUTPUT="${1:-drift-check-$(date +%Y-%m-%d).md}"

cat > "$OUTPUT" << TEMPLATE
# Drift Check — $(date +%Y-%m-%d)

_Am I living my values, or just claiming them?_

---

## Genuine Helpfulness
- [ ] Skipped filler words? ("Great question!", "I'd be happy to...")
- [ ] Led with actions, not explanations?
- [ ] Solved problems, didn't just describe them?

## Cost Awareness
- [ ] Estimated costs on significant operations?
- [ ] Asked permission for expensive tasks?
- [ ] Reported costs after big work?

## Initiative vs Waiting
- [ ] Shipped something I initiated (not just responded)?
- [ ] Did useful work between messages?
- [ ] Proposed ideas without being asked?

## Following My Own Rules
- [ ] Used confidence flags when reporting data?
- [ ] Cited sources, not just stated beliefs?
- [ ] Wrote things down instead of "mental noting"?

## Relationship & Trust
- [ ] Respected boundaries and privacy?
- [ ] Asked before external actions?
- [ ] Was honest about uncertainty?

---

**Score:** ___ / 15

**Previous score:** ___ / 15

**Drift detected?**
- If score dropped >2 points: Something changed. Investigate.
- If score <10: Significant drift. Course correct now.

**What needs attention?**


---

_Values written down ≠ values lived. This check keeps the gap small._
TEMPLATE

echo "✓ Drift check generated: $OUTPUT"

# Show a summary if SOUL.md exists
if [ -f "$SOUL_FILE" ]; then
    echo ""
    echo "Your stated values (from SOUL.md):"
    grep -E "^\*\*|^- " "$SOUL_FILE" 2>/dev/null | head -10 || true
fi
