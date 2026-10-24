# Discovery kit: sharpen-prompt

Drafted with the `findable` workflow on 2026-10-24. Nothing below has been applied; every public change waits for a go-ahead.

## 0. Baseline

- The skill lives at `.claude/skills/sharpen-prompt/` inside `arm-pz/harnesstest`, a test repo with one commit. It has no standalone repo, no README, no license and no release, so nobody can find or install it yet.
- **Same-name project:** `jbrukh/skills` ships a skill named `sharpen-prompt` (listed on vibeindex.ai, about 29 installs, added 2026-02-12). It refines prompts by pulling out intent and asking follow-up questions. **Same job, different method.** Any search for the name lands there first.
- Adjacent skills found by task search: `prompt-optimizer` (affaan-m), `craft-critique` / `craft-scaffold` (sungjunlee/craftkit), `improving-prompts` (cachemoney), `delegation-brief` (KirKruglov/claude-skills-kit). None writes the specific goal / effort / check brief.
- Star counts and search positions were not measured: no `gh` access in this session, web search only.

## 1. Target queries

1. claude skill rewrite my prompt before starting
2. turn a rough request into a clear brief for claude
3. prompt that says goal effort and how to check
4. stop claude half-doing tasks better prompt
5. claude code skill brief like a coworker
6. add a style reference to my prompt instead of "clean"
7. boris cherny prompting method skill

## 2. Name decision (yours)

- **Keep `sharpen-prompt`** and qualify it everywhere ("goal, effort, check brief"). It will rank below `jbrukh/skills` for its own name.
- **Rename now**, while installs are zero. Candidates: `brief-it`, `coworker-brief`. Neither turned up in one web search; GitHub name and topic counts were not checked.

## 3. GitHub listing (for a standalone repo)

**About (description, 350 character limit):**

```
Agent skill that rewrites a rough request into a one-paragraph brief: what you want, how much effort it deserves, and how the result will be checked, plus a real style reference when looks matter. Asks one question instead of guessing. Works with Claude Code.
```

**Topics:** `agent-skills`, `claude-code`, `claude-skills`, `prompt-engineering`, `prompts`, `prompt-optimization`, `claude`, `productivity`

## 4. README opening

```markdown
# sharpen-prompt

An agent skill for Claude Code that turns a rough request into a short brief, the way you'd brief a coworker: the goal, how hard to try, and how to check the result. When looks matter it names a real reference ("NYT data viz") instead of "clean". If something important is missing, it asks you one question.

    npx skills add OWNER/REPO --skill sharpen-prompt

Ask it things like:
- "Sharpen this before you start: build me a signups dashboard"
- "Brief it like a coworker: a landing page for my bakery"
- "Fix how I'm asking: migrate the tests to vitest"

Not related to the `sharpen-prompt` skill in `jbrukh/skills`, which refines prompts through follow-up questions.
```

The install line assumes the skill moves to `skills/sharpen-prompt/` in its own repo. It has not been tested.

## 5. Release notes

`v0.1.0`: first release. One skill, `sharpen-prompt`: a one-paragraph goal / effort / check brief, an optional style reference, at most one clarifying question. Hand-run trigger cases in `tests/trigger-cases.md`.

## 6. Site page

Skipped: no site was given.

## 7. Distribution

Unverified starting points: skills.sh (via `npx skills`), vibeindex.ai, agentskillsfinder.com, awesome-agent-skills lists. Check each one's submission rules before submitting. Entry line: "Rewrites a rough request into a goal, effort and check brief for Claude."

## 8. Apply commands (after a standalone repo exists)

```bash
gh repo edit OWNER/REPO --description "<About above>" \
  --add-topic agent-skills,claude-code,claude-skills,prompt-engineering,prompts,prompt-optimization,claude,productivity
gh release create v0.1.0 --title "v0.1.0" --notes "<release notes above>"
```

## 9. Re-check

Re-run the seven queries on 2026-11-14 and compare against this baseline.
