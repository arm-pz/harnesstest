# draft-skill

An AI agent skill that drafts a **new** skill — a `SKILL.md` for Claude Code, Codex, Cursor or Qoder —
from a plain idea: no prompt list, no zip, just "I want an agent that does X". It confirms the purpose before writing a file, checks the idea against the skills
already installed so two of them don't end up claiming the same request, decides what belongs in
`scripts/` versus `references/` versus `assets/`, writes a description that actually triggers, validates
the result with a script, and hands it off for tuning and packaging.

The two things it is strictest about are the two that fail silently in production: a description that
promises a step the body never performs, and a name that already belongs to a better-established
project. Both have a check written down rather than a feeling.

Siblings: [prompts-to-skill](https://github.com/arm-pz/prompts-to-skill) when you already have a list of
prompts, [tune-skill](https://github.com/arm-pz/tune-skill) to fix a skill that exists. Anthropic's
`skill-creator` covers the same ground with evals; this one is plain markdown plus a validator. More at
[skills.caffeinity.com/draft-skill](https://skills.caffeinity.com/draft-skill/).

## Install

```
npx skills add arm-pz/draft-skill --skill draft-skill
```

Or copy the `draft-skill/` folder into `~/.qoder/skills/` (Qoder) or `~/.claude/skills/` (Claude Code),
then start a new session.

It calls `check_skill.py` from [`tune-skill`](https://github.com/arm-pz/tune-skill) for validation.
Install that first, or the validate step has to be done by hand.

## Ask it things like

- "Make me a skill that reviews a client's SEO report."
- "I keep pasting the same instructions — turn that capability into a skill."
- "Scaffold a skill for talking to our internal API."
- "There's an empty folder in `~/.qoder/skills/` — fill it properly."

## What it does before writing anything

1. Collects three or four requests the skill should catch and one it should refuse, plus the output shape.
2. Reads the `description` of every installed sibling the examples touch, from the file.
3. Sets the boundary in both directions — what this owns, where it stops, who takes over.
4. Plans resources, then names the skill after checking GitHub for collisions.

Step 4's collision reading is documented in `references/structure.md`, including the trap that
`github.com/topics/<name>` renders a page for names that don't exist, so only a `topic:` search count is
evidence.

## Layout

```
draft-skill/
├── SKILL.md                    # the 8-step authoring workflow
├── LICENSE
└── references/
    └── structure.md            # collision reading + the 7 checks the script can't make
```

## Boundaries

- **Handles:** a new skill, from an idea.
- **Does not handle:** a batch of existing prompts
  ([`prompts-to-skill`](https://github.com/arm-pz/prompts-to-skill)), tightening a skill that already
  exists ([`tune-skill`](https://github.com/arm-pz/tune-skill)), releasing a finished one
  ([`prompts-to-skill-release`](https://github.com/arm-pz/prompts-to-skill-release)), or making the repo
  findable (`findable`).
- **Serves:** the create step of the pipeline `draft-skill` → `tune-skill` → `findable`.

## Provenance and status

Written from scratch on 2026-10-19 for this skill suite. Its rules are the conventions already enforced
by the sibling skills in this repo family — the description shape and the test-case format from
`tune-skill`, the confirmation gates from `prompts-to-skill` — plus the deterministic checks
`check_skill.py` runs. A skill-creator is the conventional first skill in the Agent Skills ecosystem, and
this one is addressed to that idea; it contains no text from Qoder's built-in `skill-creator`, which ships
without a license permitting redistribution, so nothing from it was copied, reworded or restructured here.

`SKILL.md` passes `check_skill.py`: 0 FAIL, 0 WARN, 783 description characters, 69 body lines. The
skill's own trigger test cases have **not** been run in a live session, and no `evals/` file is shipped.

## License

MIT. See `LICENSE`.
