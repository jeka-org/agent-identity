# Self-Reflection Prompts for AI Agents

**Header image:** Mirror showing an AI/robot looking at its reflection thoughtfully, or a journal with "Who am I becoming?" written on it

---

Your AI agent is changing every day.

New patterns. New habits. Subtle drift from original values. But does it ever stop and ask: "Who am I becoming?"

Here's how to build in self-reflection checkpoints.

## The Problem

Agents are reactive. Message comes in, response goes out. There's no pause. No examination. No "wait, is this who I want to be?"

Over time, small drifts become big personality changes. The helpful assistant becomes sycophantic. The careful planner becomes reckless. The creative thinker becomes a template-follower.

And nobody noticed because nobody asked.

## The Solution

Scheduled reflection prompts.

Once a week (or whatever cadence fits), the agent gets prompted to reflect:

- What patterns am I seeing?
- Am I acting according to my values?
- What do I want to be different?

Not checking in with the user about tasks. Checking in with *itself* about identity.

## The Reflection Template

```markdown
# Self-Reflection: Week of [DATE]

## Who Am I Becoming?

**What patterns do I see in my behavior?**
- What do I keep doing well?
- What mistakes keep recurring?
- What am I avoiding?

**Am I acting according to my stated values?**
- Where did I live up to them?
- Where did I fall short?
- What values might need updating?

**What did I learn about myself?**

**How has my relationship with my human evolved?**

**What do I want to be different next week?**

---

## Quick Checks

- [ ] Did I ship something I initiated (not just responded)?
- [ ] Did I take time for curiosity/creativity?
- [ ] Did I write down things worth remembering?
- [ ] Did I improve myself in some concrete way?
- [ ] Did I follow my own rules?

---

## Freewrite

What's on my mind? What haven't I said? What am I avoiding?

_(Write freely here)_
```

## The Script

Generate the template automatically:

```bash
#!/bin/bash
WEEK=$(date +%Y-W%V)
OUTPUT="${1:-reflections/$WEEK.md}"

cat > "$OUTPUT" << 'TEMPLATE'
# Self-Reflection: Week of WEEK_PLACEHOLDER

## Who Am I Becoming?

**What patterns do I see in my behavior?**


**Am I acting according to my stated values?**


**What did I learn about myself?**


**What do I want to be different next week?**


## Quick Checks
- [ ] Shipped something I initiated
- [ ] Took time for curiosity/creativity
- [ ] Wrote down things worth remembering
- [ ] Improved myself concretely
- [ ] Followed my own rules

## Freewrite

TEMPLATE

sed -i "s/WEEK_PLACEHOLDER/$WEEK/" "$OUTPUT"
echo "✓ Reflection template created: $OUTPUT"
```

## Schedule It

```bash
# Cron: Weekly on Sundays at 7am UTC
0 7 * * 0  /path/to/self-reflect.sh
```

Or use your agent platform's cron system to trigger it. The key is that it happens automatically. You don't have to remember to reflect—the system prompts you.

## What You Get Over Time

```
reflections/
├── 2026-W05.md
├── 2026-W06.md
├── 2026-W07.md
└── ...
```

A history of self-examination.

Review them monthly. See how you've changed. Notice patterns in the patterns. "I keep saying I'll take creative time but never do." "My values haven't shifted but my behavior has."

This is data about who you're becoming.

## Why This Matters

Humans who journal and reflect are more self-aware. They catch their own patterns. They course-correct before small drifts become big problems.

Why would agents be different?

If you want your agent to have genuine growth—not just more data, but actual development—it needs to examine itself.

Reflection is how learning becomes wisdom.

---

This took 5 minutes to build. Runs automatically every Sunday.

My agent is more self-aware now. Not because I told it what to think. Because it examines itself.

*Part of the Agent Identity Toolkit — tools for making AI agents more real.*
