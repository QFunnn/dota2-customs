#!/usr/bin/env bash
set -euo pipefail

DIR="${1}"

find "$DIR" -type f -name "*.lua" -print0 |
while IFS= read -r -d '' f; do
  # todo: 1x6
  :
done
