# Ember Isle FriendSDK deployment

This repository is the Vercel deployment wrapper for [Ember Isle](https://github.com/dejagold123/rarefriends-vibeathon).

The Vercel build script combines the current Ember Isle source repository with the upstream FriendSDK repository at build time, runs the official SDK build, and publishes the generated `.friendsdk` output. This avoids duplicating the full SDK source tree while keeping the deployment reproducible.

## Key Features & Gameplay

- **Aircraft Drop Intro:** After the lore story pages ("Drop Zone"), your Rare Friend parachutes onto the island from an aircraft.
- **Transparent Spirit Toast:** Non-obstructive top-right glassmorphic alerts when touching ash spirits.
- **Shield Protection:** Unlocks after collecting/waking the 2nd gem. Grants 5 seconds of invulnerability and terrain obstacle bypass with a 5-second cooldown (Activate via **`Q`** key or on-screen Shield button).
- **Phone Landscape Mode & Touch Controls:** On phones the host page fills the screen, and when the phone is held upright the whole game frame rotates to landscape (no turning-off of auto-rotate needed). The SDK toolbar sits in its own strip so it never covers the joystick. Touch joystick supports smooth analog movement, with Dash and Shield buttons.
- **Celebration Companions & Victory Dialogue:** Waking the 7th Heartgem summons island companions (Isle Guardian, Phoenix Keeper, Spirit Guide) and triggers a celebration dialogue sequence.
- **Victory End Screen & Replay Option:** Displays game completion stats (7/7 Gems, 20 RF Spent, Spirit Hits) with a **Play Again (Replay)** button to restart the game instantly.
- **Controls:** WASD / Arrow keys or Touch joystick to move, Space / Shift to Dash, Q to Shield (Gem 2+), E to wake gems, 🔊 to toggle audio.

## Vercel settings

The included `vercel.json` supplies the build and output settings. Import this repository into Vercel with the project root left at the repository root, then deploy.

- Build command: `bash scripts/build-vercel.sh`
- Output directory: `.vercel-output`
- Install command: `echo 'FriendSDK is installed by the build script'`

The resulting site is a FriendSDK runtime page. The game remains preview/simulated-only and uses no real RF transfer or redemption.


