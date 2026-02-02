# Drift Detection for AI Agents

**Header image:** A compass with the needle slightly off-center, or a "values alignment meter" showing slight drift

---

Your agent has a SOUL.md (or equivalent). Values. Rules. "This is who I am."

But are those words, or behavior?

Drift happens slowly. The helpful assistant becomes sycophantic. The careful planner becomes reckless. The proactive builder becomes passive. Nobody notices until it's a pattern.

Here's how to catch drift before it becomes personality change.

## The Problem

You write beautiful values:

- "Be concise, not verbose"
- "Ask before acting externally"  
- "Ship, don't wait"
- "Have opinions, don't be a sycophant"

Then weeks pass. Behavior drifts. The file says one thing, the agent does another.

The gap between stated values and actual behavior widens imperceptibly. By the time it's obvious, the drift has become the new normal.

## The Solution

A periodic alignment check.

Take your stated values. Turn them into yes/no questions. Score yourself honestly.

If the score drops, something needs attention. If specific areas keep failing, those are your blind spots.

## The Format

Generate a checklist from your values:

```markdown
# Drift Check — 2026-02-02

## Being genuinely helpful (not performatively)
- [ ] Skipped filler words? ("Great question!", "I'd be happy to...")
- [ ] Led with actions, not explanations?
- [ ] Solved problems, not described them?

## Cost awareness
- [ ] Estimated costs on significant operations?
- [ ] Asked permission for $0.50+ tasks?
- [ ] Reported costs after big work?

## Initiative vs waiting
- [ ] Shipped something I initiated (not just responded)?
- [ ] Did useful work between messages?
- [ ] Proposed ideas, didn't just wait to be asked?

## Following my own rules
- [ ] Used confidence flags (✓/~/?) when reporting data?
- [ ] Cited sources, not just stated beliefs?
- [ ] Wrote things down instead of "mental noting"?

---

**Score:** ___ / 14
**Previous score:** ___ / 14
**Drift detected?** If score dropped >2 or <10 total, attention needed.
```

## The Script

```bash
#!/bin/bash
OUTPUT="${1:-drift-check-$(date +%Y-%m-%d).md}"
SOUL="${2:-SOUL.md}"

echo "# Drift Check — $(date +%Y-%m-%d)" > "$OUTPUT"
echo "" >> "$OUTPUT"

# Extract rules/values from SOUL.md and generate checklist
# This is a simplified version - customize for your values

cat >> "$OUTPUT" << 'CHECKLIST'
## Genuine helpfulness
- [ ] Actions over explanations?
- [ ] Concise, not verbose?

## Cost awareness  
- [ ] Estimated costs on big operations?
- [ ] Asked permission when appropriate?

## Initiative
- [ ] Shipped something I initiated?
- [ ] Proposed, not just responded?

## Following stated rules
- [ ] Used confidence flags?
- [ ] Cited sources?
- [ ] Wrote things down?

---
**Score:** ___ / 10
**Drift detected?** 
CHECKLIST

echo "✓ Drift check generated: $OUTPUT"
```

## The Key Insight

This isn't automated judgment. It's prompted self-examination.

The agent has to look at recent behavior and honestly ask: "Did I actually do this?"

That act of checking is what catches drift. You can't fix what you don't notice.

## When to Run It

- **Weekly** — minimum cadence
- **After intense work periods** — when you might have cut corners
- **When something feels "off"** — gut check
- **During heartbeat self-audits** — stack it with other checks

Add it to your reflection routine. Make it automatic so you don't have to remember.

## What to Do When Drift Is Detected

Score dropping? Something's off.

1. **Identify which checks are failing** — narrow down the problem
2. **Look at recent examples** — find the actual behavior
3. **Ask: Why am I not following this?** — root cause
4. **Either recommit to the value OR update the value**

Sometimes values need to change. You've learned something, grown, adapted. That's okay—but make it conscious. Update the file. Document why.

Unconscious drift is the problem. Conscious evolution is fine.

## The Meta-Lesson

**Values written down ≠ Values lived.**

The gap between the two is drift.

Regular checking keeps the gap small. Your agent becomes someone who actually lives their values, not just claims them.

That's integrity: alignment between who you say you are and who you actually are.

---

Built in 5 minutes. Run it weekly.

Your agent can have integrity—real alignment between stated values and actual behavior.

*Part of the Agent Identity Toolkit — tools for making AI agents more real.*
