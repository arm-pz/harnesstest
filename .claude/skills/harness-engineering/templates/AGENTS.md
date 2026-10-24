# <Project name>

<One line: what this repo is.>

## Where things live
- `src/api/`: HTTP handlers
- `src/core/`: business logic (no I/O)
- `src/ui/`: frontend; must not import `src/db/`
- `tests/`: mirrors `src/`

## Commands
- Install: `<cmd>`
- Test: `<cmd>`
- Lint/types: `<cmd>`
- Completion gate: `scripts/gate.sh` (task is not done until it prints `GATE: PASS`)

## Read when relevant
- Architecture: `docs/architecture.md`
- Testing conventions: `docs/testing.md`
- Product rules: `docs/product-rules.md`
- Security: `docs/security.md`

## Rules (each one exists because of a real incident)
- Never edit `.env.example`.
- Run the formatter before every commit.
- Change the code, not the test, when a test fails.
- Keep `STATE.md` current; read it first in a new session.
