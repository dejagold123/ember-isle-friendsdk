# Ember Isle FriendSDK deployment

This repository is the Vercel deployment wrapper for [Ember Isle](https://github.com/dejagold123/rarefriends-vibeathon).

The Vercel build script combines the current Ember Isle source repository with the upstream FriendSDK repository at build time, runs the official SDK build, and publishes the generated `.friendsdk` output. This avoids duplicating the full SDK source tree while keeping the deployment reproducible.

## Vercel settings

The included `vercel.json` supplies the build and output settings. Import this repository into Vercel with the project root left at the repository root, then deploy.

- Build command: `bash scripts/build-vercel.sh`
- Output directory: `.vercel-output`
- Install command: `echo 'FriendSDK is installed by the build script'`

The resulting site is a FriendSDK runtime page. The game remains preview/simulated-only and uses no real RF transfer or redemption.
