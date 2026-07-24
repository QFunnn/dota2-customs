#!/usr/bin/env bash
set -euo pipefail

apply_watermark() {
  local dir="$1" watermark="$2" f
  [[ -n "$watermark" ]] || return 0

  while IFS= read -r -d '' f; do
    grep -Iq . "$f" || continue
    printf '%s\n\n\n%s' "$watermark" "$(cat "$f")" > "$f.tmp"
    mv "$f.tmp" "$f"
  done < <(find "$dir" -type f -not -path "$dir/.git/*" -print0)
}

main() {
  local MOD_DIR CONTENT VPK OUT PUBLISH

  echo "== $WORKSHOP_ID -> $BRANCH"

  MOD_DIR="$RUNNER_TEMP/mod"

  "$STEAMCMD" \
    +force_install_dir "$MOD_DIR" \
    +login "$STEAM_USERNAME" "$STEAM_PASSWORD" \
    +workshop_download_item "570" "$WORKSHOP_ID" validate \
    +quit

  CONTENT=$(find "$MOD_DIR" -type d \
    -path "*/steamapps/workshop/content/570/$WORKSHOP_ID" | head -n1)
  [[ -n "$CONTENT" ]] || { echo "Workshop content missing"; exit 1; }

  VPK=$(find "$CONTENT" -type f -name "*.vpk" | sort | head -n1)
  [[ -n "$VPK" ]] || { echo "No VPK found"; exit 1; }

  OUT="$RUNNER_TEMP/extract"
  rm -rf "$OUT"; mkdir -p "$OUT"

  if ! "$S2V" -i "$VPK" -o "$OUT" -d >"$RUNNER_TEMP/s2v.log" 2>&1; then
    cat "$RUNNER_TEMP/s2v.log"
    exit 1
  fi

  [[ -n "$(ls -A "$OUT")" ]] || { echo "Extraction empty"; exit 1; }

  apply_watermark "$OUT" "$WATERMARK"

  PUBLISH="$RUNNER_TEMP/publish"
  rm -rf "$PUBLISH"; mkdir "$PUBLISH"

  cd "$PUBLISH"

  git init -q
  git config user.name "github-actions[bot]"
  git config user.email "41898282+github-actions[bot]@users.noreply.github.com"
  git remote add origin "$REPO_URL"

  if git ls-remote --heads origin "$BRANCH" | grep -q "$BRANCH"; then
    git fetch -q --depth=1 origin "$BRANCH"
    git checkout -q -B "$BRANCH" FETCH_HEAD
  else
    git checkout -q --orphan "$BRANCH"
  fi

  find . -mindepth 1 -not -path './.git*' -delete
  cp -a "$OUT"/. .
  git add -A

  if git diff --cached --quiet; then
    echo "no changes in $BRANCH"
  else
    git commit -q -m "action: update custom"
    git push -q origin "$BRANCH"
    echo "pushed $BRANCH"
  fi
}

main "$@"