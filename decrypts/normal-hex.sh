#!/usr/bin/env bash
set -euo pipefail

if python3 --version >/dev/null 2>&1; then
    python=(python3)
else
    python=(py -3)
fi

"${python[@]}" - "$1" <<'PY'
from pathlib import Path
import re
import sys

pattern = re.compile(
    r"^(?:\s*--\[\[.*?\]\]\s*)*return\s+normalDecrypt\s*\(\s*\[\[\s*([0-9a-fA-F\s]+?)\s*\]\]\s*,.*\)\s*$",
    re.DOTALL,
)

count = 0
for path in Path(sys.argv[1]).rglob("*.lua"):
    match = pattern.fullmatch(path.read_text(encoding="utf-8"))
    if not match:
        continue

    encoded = "".join(match.group(1).split())
    path.write_bytes(bytes.fromhex(encoded))
    count += 1

if count == 0:
    raise SystemExit("no normalDecrypt payloads found")

print(f"decrypted {count} Lua files")
PY
