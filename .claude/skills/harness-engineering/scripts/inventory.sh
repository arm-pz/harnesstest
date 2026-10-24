#!/usr/bin/env bash
# Record or verify an inventory of input files (path,size,sha256).
#   inventory.sh record <dir> > INPUT-MANIFEST.csv
#   inventory.sh verify INPUT-MANIFEST.csv
set -euo pipefail

case "${1:-}" in
  record)
    dir="${2:?usage: inventory.sh record <dir>}"
    echo "path,size,sha256"
    find "$dir" -type f -not -path '*/.git/*' -print0 | sort -z |
      while IFS= read -r -d '' f; do
        printf '%s,%s,%s\n' "$f" "$(wc -c <"$f" | tr -d ' ')" "$(sha256sum "$f" | cut -d' ' -f1)"
      done
    ;;
  verify)
    manifest="${2:?usage: inventory.sh verify <manifest.csv>}"
    total=0; ok=0
    while IFS=, read -r path size hash; do
      total=$((total + 1))
      if [ ! -f "$path" ]; then
        echo "MISSING  $path"
      elif [ "$(sha256sum "$path" | cut -d' ' -f1)" != "$hash" ]; then
        echo "CHANGED  $path"
      else
        ok=$((ok + 1))
      fi
    done < <(tail -n +2 "$manifest")
    echo "$ok of $total originals unchanged"
    [ "$ok" -eq "$total" ]
    ;;
  *)
    echo "usage: inventory.sh record <dir> | verify <manifest.csv>" >&2
    exit 2
    ;;
esac
