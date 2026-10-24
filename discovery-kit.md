# Discovery kit: tight-brief

Drafted with the `findable` workflow on 2026-10-24. Nothing below has been applied; every public change waits for a go-ahead.

## 0. Baseline

Audit re-run on 2026-10-24 with web search only; there was no `gh` access, so GitHub-side counts were not measured. Star and install numbers are as the directory listings report them.

**Our skill:** inside `arm-pz/harnesstest` (a test repo, 2 commits). It has no standalone repo, README, license or release. It doesn't appear for any query below.

| Query | Found? | Who shows up instead | Where they're listed |
|---|---|---|---|
| claude code skill rewrite my request into a better prompt | no | `Terryc21/prompter` (rewrites prompts, shows them for approval), `krishamaze/writing-agent-prompts` | GitHub mirror, skills.sh |
| claude skill rewrite rough request better prompt | no | `prompt-optimizer` (affaan-m), `craft-critique` (sungjunlee/craftkit), `improving-prompts` (cachemoney) | agentskillsfinder, skills.sh, llmbase |
| turn a vague request into a brief before building | no | `brief-builder` (mohitagw15856/pm-claude-skills, ~1,240 stars, interviews one question at a time), `brief-first-execution` (markoblogo, 2 stars) | claudeskills.info, agentskill.sh |
| goal effort verification prompt skill | no | `goal-loop`, `verify` (oh-my-claudecode), `effort-calibrator` | tessl, skillselion, skillsdirectory |
| "sharpen-prompt" | no | `jbrukh/skills` → `sharpen-prompt` (~29 installs, same job) | vibeindex |

**What sets us apart, and what to lead with:** the others either interview you (brief-builder, sharpen-prompt) or rewrite freely (prompter, prompt-optimizer). This one writes one fixed shape (goal, effort, check, plus a real style reference) and asks at most one question.

**Metadata gaps:** no repo description, topics, license, release, README or social preview.

## 1. Target queries

1. claude skill rewrite my prompt before starting
2. turn a rough request into a clear brief for claude
3. prompt that says goal effort and how to check
4. stop claude half-doing tasks better prompt
5. claude code skill brief like a coworker
6. add a style reference to my prompt instead of "clean"
7. boris cherny prompting method skill

## 2. Name decision

**Decided 2026-10-24: `tight-brief`.** The skill was renamed from `sharpen-prompt`. The notes below are kept as the record.

`sharpen-prompt` collides with `jbrukh/skills`, which does the same job. Renaming now costs nothing: there are no installs or stars.

Round 2 (2026-10-24): candidates built from what sets the skill apart: one paragraph; goal, effort, check; a real style reference; at most one question.

| Candidate | Exact-name hits | Why | Watch out |
|---|---|---|---|
| `spell-it-out` (see audit below) | none | Starts with a verb, plain English, says the job: make the unstated parts of a request explicit | Common phrase, so the About text and topics carry search |
| `three-line-ask` | none | Ties to the "three lines" framing; hints at the output shape | "Lines" is loose; the output is one paragraph |
| `want-try-check` | none | The method itself: what you want, how hard to try, how to check | Quirky; reads oddly at first glance |
| `tight-brief` | none | Short; says "brief" without the interview connotation | "brief" is crowded (`brief`, `brief-builder`, `brief-me`) |
| `clear-ask` | none | Short, says the outcome | `buiducnhat/agent-skills` has `ask`, which asks one focused question: adjacent |
| `done-looks-like` | none | Leads with the check, the part most prompts leave out | Undersells goal and effort |

**Round 2 findable audit** (GitHub-only web search for each exact name, 2026-10-24; star counts not measured):

| Candidate | Same-name projects | Collision type | Verdict |
|---|---|---|---|
| **`tight-brief`** | none; the phrase appears in agent-workflow PRs (shenxingy/Clade, modelplan) meaning "a concise task brief" | none, and the phrase already means what the skill does | **Recommended** |
| `want-try-check` | none | none | Cleanest, but nobody searches the phrase, so the About text carries everything |
| `three-line-ask` | none | none | Clean; "three lines" over-promises the shape |
| `done-looks-like` | none as a repo; a common heading in issue templates and AI prompt guidance; `rolldabones/definition-of-done` | adjacent (definition of done) | Easy to drown in the generic phrase |
| `clear-ask` | `Sunilanbarasu/Clearask`, which turns confusing messages into clarifying questions | **adjacent, same audience** | Avoid |
| `spell-it-out` | `Tinux-18/spell-it-out`, `Caldwerl/spell-it-out`, `blguerin/Spell_It_Out`, `EarthmanMuons/spellout`, all spelling tools | unrelated, but the name reads as spelling to search engines | Downgraded from round-2 pick |

Round 1, kept for reference: `brief-like-a-coworker`, `goal-effort-check` and `coworker-brief` (no hits); `brief-it` (crowded); `sharpen-prompt` (taken).

Avoided: `handoff-*` (a crowded family that means session handoff), `brief-then-build` (too close to `brief-first-execution`), and any name built on a real person's name.

These are web-search results only. Check `gh api "search/repositories?q=<name>+in:name"` and `topic:<name>` before you commit to a name.

## 3. GitHub listing (for a standalone repo)

**About (description, 350 character limit):**

```
Agent skill that rewrites a rough request into a one-paragraph brief: what you want, how much effort it deserves, and how the result will be checked, plus a real style reference when looks matter. Asks one question instead of guessing. Works with Claude Code.
```

**Topics:** `agent-skills`, `claude-code`, `claude-skills`, `prompt-engineering`, `prompts`, `prompt-optimization`, `claude`, `productivity`

## 4. README opening

```markdown
# tight-brief

An agent skill for Claude Code that turns a rough request into a short brief, the way you'd brief a coworker: the goal, how hard to try, and how to check the result. When looks matter it names a real reference ("NYT data viz") instead of "clean". If something important is missing, it asks you one question.

    npx skills add OWNER/REPO --skill tight-brief

Ask it things like:
- "Sharpen this before you start: build me a signups dashboard"
- "Brief it like a coworker: a landing page for my bakery"
- "Fix how I'm asking: migrate the tests to vitest"
```

The install line assumes the skill moves to `skills/tight-brief/` in its own repo. It has not been tested.

## 5. Release notes

`v0.1.0`: first release. One skill, `tight-brief`: a one-paragraph goal / effort / check brief, an optional style reference, at most one clarifying question. Hand-run trigger cases in `tests/trigger-cases.md`.

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
