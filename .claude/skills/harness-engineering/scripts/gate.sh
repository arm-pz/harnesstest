#!/usr/bin/env bash
# Evidence gate: a task is done only when this prints "GATE: PASS".
# Replace the commands below with the repo's real ones. Never invent them.
set -u

fail=0
check() {
  local name="$1"; shift
  if "$@" >/tmp/gate-"$name".log 2>&1; then
    echo "[ok]   $name"
  else
    echo "[FAIL] $name (see /tmp/gate-$name.log)"
    tail -n 20 /tmp/gate-"$name".log | sed 's/^/       /'
    fail=1
  fi
}

check types npm run typecheck --silent
check lint  npm run lint --silent
check tests npm test --silent

if [ "$fail" -eq 0 ]; then
  echo "GATE: PASS"
else
  echo "GATE: FAIL"
  exit 1
fi
