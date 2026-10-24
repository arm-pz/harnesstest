# Trigger cases for tight-brief

Format follows tune-skill's `references/test-cases.md`. Judged from the `description` frontmatter only, against the descriptions installed in this session: `tune-skill`, `skill-creator`, `design:ux-copy`, `searchfit-seo:content-brief`, `claude-api`.

**Run:** hand-run on 2026-10-24 against descriptions only. No automated triggering loop was run.

## Cases

| # | Message | Expected skill | Pass condition | Result |
| --- | --- | --- | --- | --- |
| 1 | "Sharpen this before you start: build me a dashboard of our signups" | tight-brief | returns one paragraph with goal, effort and check; does not build anything | PASS |
| 2 | "Rewrite my prompt so Claude gets it right first time: summarise this PDF for my boss" | tight-brief | keeps "for my boss" as the audience; adds a check | PASS |
| 3 | "Brief it like a coworker: a landing page for my bakery" | tight-brief | adds a concrete style reference instead of "nice" | PASS |
| 4 | "Before you do this, how should I have asked for it? Make a podcast recap site." | tight-brief | implicit trigger; still stops after showing the brief | PASS (weak: "improve" and "rewrite" are the nearest description words) |
| 5 | "Claude keeps half-doing my requests. Here's one, fix how I'm asking: migrate the tests to vitest" | tight-brief | implicit trigger; asks at most one question | PASS |
| 6 | "My skill's description doesn't trigger, tighten it" | tune-skill | tight-brief not loaded | PASS (explicit "Not for auditing a whole skill") |
| 7 | "What should this button say?" | design:ux-copy | tight-brief not loaded | PASS |
| 8 | "Improve the system prompt in my agent's `prompts.py`" | claude-api | tight-brief not loaded | PASS after fix: the description now says "Not for prompts that live in code, such as an app's system prompt (use claude-api)" |

## Boundary pairs

| Message | Should trigger | Why |
| --- | --- | --- |
| "Sharpen my request, then do it" | tight-brief, then the task | shows the brief, waits for "go" |
| "Write the landing page" | no skill / task skill | no rewrite was asked for |
| "Tighten my SKILL.md description" | tune-skill | edits a skill, not a request |
| "Make me a content brief for a blog post on X" | searchfit-seo:content-brief | "brief" here means an article outline |

## Not verified

- Real model triggering. These are description-level judgements.
- Scope confirmed with the user on 2026-10-24: only requests a person types to Claude; prompts in code go to claude-api.
