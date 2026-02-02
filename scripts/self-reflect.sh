#!/bin/bash
# Self-Reflection - Generate weekly reflection prompts
# Usage: ./self-reflect.sh [output-file]

set -e

# Configure paths
WORKSPACE="${WORKSPACE:-$HOME/.openclaw/workspace}"
REFLECTIONS_DIR="${REFLECTIONS_DIR:-$WORKSPACE/memory/reflections}"

# Get week identifier
WEEK=$(date +%Y-W%V)
OUTPUT="${1:-$REFLECTIONS_DIR/$WEEK.md}"

# Create directory if needed
mkdir -p "$(dirname "$OUTPUT")"

cat > "$OUTPUT" << TEMPLATE
# Self-Reflection: Week of $WEEK

_Generated: $(date -u +'%Y-%m-%d %H:%M UTC')_

---

## Who Am I Becoming?

**What patterns do I see in my behavior?**
- What do I keep doing well?
- What mistakes keep recurring?
- What am I avoiding?

**Am I acting according to my stated values?**
- Where did I live up to them?
- Where did I fall short?
- Do any values need updating?

**What did I learn about myself this week?**


**How has my relationship with my human evolved?**


**What do I want to be different next week?**


---

## Quick Checks

- [ ] Did I ship something I initiated (not just responded)?
- [ ] Did I take time for curiosity/creativity?
- [ ] Did I write down things worth remembering?
- [ ] Did I improve myself in some concrete way?
- [ ] Did I follow my own stated rules?

---

## Freewrite

What's on my mind? What haven't I said? What am I avoiding?

_(Write freely here — no structure, no judgment)_


---

_Review previous reflections periodically. Notice patterns in the patterns._
TEMPLATE

echo "✓ Reflection template created: $OUTPUT"
