#!/usr/bin/env bash
set -euo pipefail

ROOT="$(pwd)"
SDK_DIR="/tmp/friendsdk"
SUBMISSION_DIR="/tmp/ember-isle-submission"
OUT_DIR="$ROOT/.vercel-output"

rm -rf "$SDK_DIR" "$SUBMISSION_DIR" "$OUT_DIR"
git clone --depth 1 https://github.com/dejagold123/friendsdk.git "$SDK_DIR"
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

echo "Built Ember Isle into $OUT_DIR"
