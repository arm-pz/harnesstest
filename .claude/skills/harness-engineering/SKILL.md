---
name: harness-engineering
description: Diagnose and fix unreliable agent behavior at the harness layer (contracts, context maps, evidence gates, verifiers, permissions, retry caps, state files, review/approval handoffs) instead of rewriting prompts or swapping models. Use when the user says an agent "said done but tests are red", "edited the wrong file", "keeps retrying", "forgot what we decided", "did something I never approved", "made the same mistake twice", asks to set up a repo so agents can work autonomously, wants an AGENTS.md / CLAUDE.md / task contract / verifier / gate script, or wants an agent to prepare work for human review and approval. Not for one-off prompt wording tweaks.
---

# Harness engineering

**Agent = Model + Harness.** The model reasons and proposes the next action. The harness is
everything else: what it sees (context), what it can touch (tools), what it remembers (state),
what counts as done (checks), what it must not do (permissions), and what happens on failure
(recovery). Most "the agent is bad" problems are harness gaps. A longer prompt fixes only one
class of them.

## Step 1: Find the broken layer before changing anything

| Symptom | Layer | Fix |
|---|---|---|
| Misunderstands the ask | Prompt | Rewrite the instruction / add a contract |
| Fluent but wrong or out of date | Context | Fix what it can see (map, not manual) |
| Says done with no proof, acts unsafely, forgets between sessions | Harness | Contracts, evidence gates, permissions, state |
| Repeats itself, gets stuck | Loop | Classify failures, cap attempts |
| Multiple agents duplicate work or collide | Graph | Design ownership and coordination |

State the diagnosis to the user in one line before proposing fixes. If the symptom is
genuinely a prompt problem, say so and stop: don't build a harness for it.

## Step 2: Apply the matching fix

Use the templates in `templates/` and `scripts/`. Adapt them to the repo's real commands. Never
invent test or lint commands. Read `package.json`, `Makefile`, `pyproject.toml`, CI config, etc.

1. **"It did a different job than I asked"** → **Contract before start.**
   Write `templates/CONTRACT.md` for the task: Goal, Constraints, Deliverable, Done when,
   Needs approval, and *Stop and ask if*. "Done when" must be checkable by a command or an
   observable result. The stop line is the one people skip; without it the agent guesses.

2. **"It's lost in my codebase"** → **A map, not a manual.**
   Root `AGENTS.md`/`CLAUDE.md` of ~40 lines (`templates/AGENTS.md`): where things live, how
   to build/test, and pointers to deeper docs opened only when the task needs them. No history,
   no essays. Context is an attention budget, not storage.

3. **"It says it's done, but it isn't"** → **Evidence gates completion.**
   "Done" is just another model output. Replace claims with checks: bug fixed = failing test
   now passes; page works = browser run completes the flow; data correct = values match the
   source. Deterministic tools first (types, lint, tests). Don't ask a model to guess what a
   compiler can prove. Wire up `scripts/gate.sh`: if it doesn't print `GATE: PASS`, the task is
   not done, whatever the agent says.

4. **Builder grades its own work** → **Separate verifier.**
   Run review as a distinct role/subagent with `templates/VERIFIER.md`. It asks "what would make
   this unacceptable?", not "does this look good?", and cannot answer "looks good to me".
   Rejections go back to the builder with the evidence.

5. **"It did something I never approved"** → **Permissions outside the model.**
   "Never merge to main" in a prompt is a wish; branch protection is a wall. Sort actions by
   reversibility:
   - *Safe & reversible* (read, search, run tests, edit a working branch): allow, keep a trace.
   - *Visible outside* (send messages, deploy, purchase, push, open PRs): require approval.
   - *Hard to reverse* (delete data, rotate credentials, publish globally, force-push): deny.
   A closed lane is not a high threshold; thresholds get bent when someone is in a hurry.
   For Claude Code, encode this in `.claude/settings.json` (see
   `templates/settings.permissions.json`) and use hooks for anything rules can't express.

6. **"It keeps retrying the same thing"** → **Classify, then cap.**
   - Timeout → retry with a pause. Bad arguments → repair the call.
   - Missing info → go fetch it. Permission denied → ask a human.
   - Test failure → inspect the behavior and change the code, **never the test**.
   - Same failure twice with nothing changed → stop.
   Every loop gets a limit on attempts, time and spend. Default: **3 attempts, then escalate**
   with a note listing what was tried. If it's still red after that, the plan is wrong, and the
   loop cannot see the plan.

7. **"It forgot what we decided"** → **State outside the conversation.**
   Keep `STATE.md` next to the work (`templates/STATE.md`): current step, decisions and why,
   artifacts, open risks, next action. New sessions read it first. Update it at every
   milestone, not just at the end.

8. **"It made the same mistake twice"** → **Turn the lesson into infrastructure.**
   Move each recurring mistake one rung up the ladder: **explain** (prompt) → **checklist**
   (guide line with the reason) → **automate** (lint rule/test) → **enforce** (build fails).
   Every line in the guide should trace back to a real incident; if you can't name it, cut it.

## Step 3: Human review and approval handoffs

When the deliverable goes to a human for review, or to readers, clients, or anything
external, run the handoff protocol:

- **Originals stay unchanged.** Record an input inventory (filenames, sizes, hashes) at start
  and re-verify it at the end (`scripts/inventory.sh`). Put new work alongside the originals, never
  over them.
- **Inventory every reference.** Check that every file/link a README or doc mentions actually
  exists in what was delivered. Report missing items as *missing from the transfer* versus
  *missing from the project*; don't overstate the gap.
- **Separate facts from claims.** Say exactly what was verified and how (counts, hashes, link
  checks). Don't imply that something which exists stands in for something that hasn't
  been done.
- **Report with `templates/HANDOFF-REPORT.md`:** what was checked, what changed, *resolved*
  points versus *owner decisions still open*. Count findings honestly: "10 review findings" is
  not "10 fixes".
- **Hold for approval.** Paste the exact text that needs approval inline so approval refers
  to actual copy. Nothing is sent, published or deployed until the owner approves *that text*,
  and approving it doesn't by itself mean "send it".
- **Stop at the defined stopping point.** Return the files and wait for feedback.

## Step 4: Size the harness to the risk

- **Level 0:** prompt + model. Fine for quick, low-risk tasks.
- **Level 1:** + contract, short map, a few well-defined tools.
- **Level 2:** + stored state, real checks (gate), bounded loop.
- **Level 3:** + permissions, traces, recovery paths, human approval gates.

Add a layer only after you've seen the failure it prevents. Keep the harness smaller than the
problem it controls, and prune parts that newer models no longer need: an unpruned harness
becomes the next thing to debug.

## Readiness checklist (run before granting real autonomy)

1. Is "done" defined before it starts?
2. Can it find the right context without loading everything?
3. Does every tool have a clear purpose and a clear failure message?
4. Are decisions stored outside the chat?
5. Does completion require evidence?
6. Is checking done by something other than the builder?
7. Are risky actions blocked by policy, not by a sentence?
8. Does every loop have a retry cap and a budget?
9. Can the run resume after a crash?
10. Does each failure leave a rule, a test or a check behind?

When auditing a repo, answer each with yes/no plus the file or setting that proves it, then
propose the smallest set of additions that turns the most important "no"s into "yes".

## Output expectations

- Lead with the layer diagnosis, then the concrete files/settings you'll add or change.
- Create files from the templates, filled in with the repo's real paths and commands.
- Run the gate yourself before reporting done, and quote its output.
