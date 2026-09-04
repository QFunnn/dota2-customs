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

run_decrypt() {
  local dir="$1" script="$2" path
  [[ -n "$script" ]] || return 0
  path="$GITHUB_WORKSPACE/decrypts/$script"
  [[ -f "$path" ]] || { echo "Decrypt script not found: $path"; exit 1; }
  echo "-- decrypt: $script"
  ( cd "$dir" && bash "$path" "$dir" )
}

format_lua() {
  local dir="$1" disabled="$2" f skipped=0
  local -A encrypted=()
  local -a files=()
  [[ "$disabled" != "true" ]] || return 0
  command -v stylua >/dev/null || { echo "StyLua not found"; exit 1; }
  echo "-- format: StyLua"
  while IFS= read -r -d '' f; do
    encrypted["$f"]=1
  done < <(grep -rlZE --include="*.lua" 'return[[:space:]]+\(?[[:space:]]*(decrypt|decryptModule)[[:space:]]*\(' "$dir" || true)
  while IFS= read -r -d '' f; do
    if [[ -n "${encrypted[$f]+x}" ]]; then
      ((skipped += 1))
    else
      files+=("$f")
    fi
  done < <(find "$dir" -type f -name "*.lua" -not -path "$dir/.git/*" -print0)
  if ((${#files[@]} > 0)) && ! printf '%s\0' "${files[@]}" | xargs -0 stylua --syntax Lua52 --verify; then
    echo "warn: StyLua rejected one or more files; rejected files left unchanged"
  fi
  ((skipped == 0)) || echo "skipped $skipped encrypted Lua wrapper(s)"
}

fetch_remote_updated() {
  local id="$1" resp updated
  resp=$(curl -fsS -X POST \
    "https://api.steampowered.com/ISteamRemoteStorage/GetPublishedFileDetails/v1/" \
    -d "itemcount=1" \
    --data-urlencode "publishedfileids[0]=$id") || return 1
  updated=$(jq -r '.response.publishedfiledetails[0].time_updated // empty' <<<"$resp")
  [[ -n "$updated" ]] || return 1
  printf '%s' "$updated"
}

fetch_stored_updated() {
  local branch="$1" json
  git ls-remote --heads origin "$branch" | grep -q "$branch" || return 1
  json=$(git fetch -q --depth=1 origin "$branch" \
         && git show "FETCH_HEAD:info.json" 2>/dev/null) || return 1
  jq -r '.time_updated // empty' <<<"$json"
}

main() {
  local MOD_DIR CONTENT VPK OUT PUBLISH REMOTE_UPDATED STORED_UPDATED
  echo "== $WORKSHOP_ID -> $BRANCH"

  REMOTE_UPDATED=$(fetch_remote_updated "$WORKSHOP_ID") || {
    echo "warn: could not fetch remote time_updated, proceeding with download"
    REMOTE_UPDATED=""
  }

  if [[ -n "$REMOTE_UPDATED" ]]; then
    STORED_UPDATED=$(
      tmp=$(mktemp -d)
      cd "$tmp"
      git init -q
      git remote add origin "$REPO_URL"
      fetch_stored_updated "$BRANCH" 2>/dev/null || true
    )
    if [[ "$REMOTE_UPDATED" == "$STORED_UPDATED" && -n "$STORED_UPDATED" ]]; then
      echo "unchanged (time_updated=$REMOTE_UPDATED), skipping download"
      exit 0
    fi
    echo "update detected: remote=$REMOTE_UPDATED stored=${STORED_UPDATED:-<none>}"
  fi

  MOD_DIR="$RUNNER_TEMP/mod"

  rm -rf "$MOD_DIR"
  rm -rf "$HOME/Steam/appcache"
  rm -rf "$HOME/steamcmd/appcache"

  mkdir -p "$MOD_DIR"

  "$STEAMCMD" \
    +http_cache_clearall \
    +force_install_dir "$MOD_DIR" \
    +login "$STEAM_USERNAME" "$STEAM_PASSWORD" \
    +workshop_download_item "570" "$WORKSHOP_ID" validate \
    +quit

  CONTENT=$(find "$MOD_DIR" -type d \
    -path "*/steamapps/workshop/content/570/$WORKSHOP_ID" | head -n1)
  [[ -n "$CONTENT" ]] || { echo "Workshop content missing"; exit 1; }

  VPK="$CONTENT/$WORKSHOP_ID.vpk"
  [[ -f "$VPK" ]] || { echo "No VPK found: $VPK"; exit 1; }

  OUT="$RUNNER_TEMP/extract"
  rm -rf "$OUT"; mkdir -p "$OUT"
  if ! "$S2V" -i "$VPK" -o "$OUT" -d >"$RUNNER_TEMP/s2v.log" 2>&1; then
    cat "$RUNNER_TEMP/s2v.log"
    exit 1
  fi
  [[ -n "$(ls -A "$OUT")" ]] || { echo "Extraction empty"; exit 1; }

  run_decrypt "$OUT" "$DECRYPT_SCRIPT"
  format_lua "$OUT" "$DISABLE_FORMAT"
  apply_watermark "$OUT" "$WATERMARK"

  jq -n \
    --arg id "$WORKSHOP_ID" \
    --arg updated "${REMOTE_UPDATED:-$(date -u +%s)}" \
    --arg parsed "$(date -u '+%Y-%m-%d %H:%M:%S UTC')" \
    '{workshop_id: $id, time_updated: $updated, parsed_at: $parsed}' \
    > "$OUT/info.json"

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
