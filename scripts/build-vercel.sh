#!/usr/bin/env bash
set -euo pipefail

ROOT="$(pwd)"
SDK_DIR="/tmp/friendsdk"
SUBMISSION_DIR="/tmp/ember-isle-submission"
OUT_DIR="$ROOT/.vercel-output"

rm -rf "$SDK_DIR" "$SUBMISSION_DIR" "$OUT_DIR"
# Official FriendSDK, pinned to v0.1.4 (the version Ember Isle is built and tested against)
SDK_REF="ca3bf183b809ecf22d87c63d88ce03969a3f8da2"
git init -q "$SDK_DIR"
git -C "$SDK_DIR" remote add origin https://github.com/spokesz/friendsdk.git
git -C "$SDK_DIR" fetch -q --depth 1 origin "$SDK_REF"
git -C "$SDK_DIR" checkout -q FETCH_HEAD
git clone --depth 1 https://github.com/dejagold123/rarefriends-vibeathon.git "$SUBMISSION_DIR"

mkdir -p "$SDK_DIR/games/ember-isle"
cp "$SUBMISSION_DIR/game.json" "$SUBMISSION_DIR/index.tsx" "$SUBMISSION_DIR/scene.ts" "$SUBMISSION_DIR/style.css" "$SDK_DIR/games/ember-isle/"
# host.css lives at the repo root or in games/ember-isle/ depending on the commit
for candidate in "$SUBMISSION_DIR/host.css" "$SUBMISSION_DIR/games/ember-isle/host.css"; do
  if [ -f "$candidate" ]; then cp "$candidate" "$SDK_DIR/games/ember-isle/host.css"; break; fi
done

cd "$SDK_DIR"
npm ci
npm run build
node scripts/dev-game.mjs build games/ember-isle --outdir "$OUT_DIR"

# Phone layout (fullscreen + auto-landscape) and a visible build stamp, appended to the host page's layout.css
cat "$ROOT/scripts/phone-layout.css" >> "$OUT_DIR/layout.css"
GAME_SHA="$(git -C "$SUBMISSION_DIR" rev-parse --short HEAD)"
HOST_SHA="${VERCEL_GIT_COMMIT_SHA:-local}"; HOST_SHA="${HOST_SHA:0:7}"
printf '.rf-frame-toolbar::after{content:"build %s / %s";margin-left:auto;font:9px ui-monospace,monospace;color:#666;white-space:nowrap;pointer-events:none}\n' "$GAME_SHA" "$HOST_SHA" >> "$OUT_DIR/layout.css"
echo "Phone layout + build stamp (game $GAME_SHA, host $HOST_SHA) added"

echo "Built Ember Isle into $OUT_DIR"
