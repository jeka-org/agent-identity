# Decision Journaling for AI Agents

Your AI agent makes decisions all day. But does it remember *why*?

Next session, it might make the same mistake—or reverse a good decision—because there's no record of the reasoning. The WHAT is in the chat history. The WHY gets lost.

## The Problem

Agents are stateless between sessions. Every conversation starts fresh. That's fine for remembering facts, but terrible for building judgment.

"I chose X over Y because of Z" disappears into the void.

Future-you has no context. Mistakes repeat. Good patterns don't compound. Your agent stays young forever—and not in a good way.

## The Solution

Create `memory/decisions.md` in your workspace. When you make a significant decision, append an entry:

```markdown
## 2026-02-02 — Chose X over Y

**Decision:** What you decided
**Reasoning:** Why this choice
**Context:** What was happening
**Outcome:** _(pending)_
```

That's it. Four fields:
- **Decision** — what you chose
- **Reasoning** — why you chose it
- **Context** — what was happening at the time
- **Outcome** — what actually happened (fill in later)

## When to Log

Not every tiny choice. Just the ones that matter:

- Chose one approach over another
- Changed a previous decision
- Made a tradeoff (speed vs quality, cost vs capability)
- Did something you might question later

## The Script (Optional)

A bash script to automate logging:

```bash
#!/bin/bash
DECISION="$1"
REASONING="$2"
CONTEXT="${3:-}"
LOG="memory/decisions.md"

echo "" >> "$LOG"
echo "## $(date +%Y-%m-%d) — $DECISION" >> "$LOG"
echo "**Decision:** $DECISION" >> "$LOG"
echo "**Reasoning:** $REASONING" >> "$LOG"
[ -n "$CONTEXT" ] && echo "**Context:** $CONTEXT" >> "$LOG"
echo "**Outcome:** _(pending)_" >> "$LOG"

echo "✓ Decision logged"
```

Usage:
```bash
./decision-log.sh \
  "Use cron instead of heartbeat for this task" \
  "Needs exact timing, isolated context" \
  "Building notification system"
```

## The Compounding Effect

After a week, you have a decision history. After a month, you see patterns.

"I keep choosing X when Y would be better."
"This type of decision always works out."

Your agent gets wiser, not just older.

## Update Outcomes

When a decision plays out, go back and fill in the outcome field.

Good decision? Note why it worked.
Bad decision? Note what you'd do differently.

This is how you build judgment—not from rules, but from experience.

---

*Part of the [Agent Identity Toolkit](https://github.com/jeka-org/agent-identity-toolkit) — tools for making AI agents more real.*
