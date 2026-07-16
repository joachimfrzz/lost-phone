#!/usr/bin/env bash
# Install XcodeGen on CI Mac runners. Recover from corrupted Homebrew Cellar paths.
set -euo pipefail

export HOMEBREW_NO_AUTO_UPDATE=1

if command -v xcodegen >/dev/null 2>&1 && xcodegen --version >/dev/null 2>&1; then
  echo "→ xcodegen already available: $(xcodegen --version)"
  exit 0
fi

echo "→ Install XcodeGen (Homebrew)"

CELLAR="/opt/homebrew/Cellar/xcodegen"
if [[ -e "$CELLAR" && ! -d "$CELLAR" ]]; then
  echo "WARN: removing broken Cellar path: $CELLAR" >&2
  rm -f "$CELLAR"
fi
if [[ -d "$CELLAR" ]]; then
  find "$CELLAR" -mindepth 1 -maxdepth 1 ! -type d -exec rm -f {} + 2>/dev/null || true
fi

brew uninstall --force xcodegen 2>/dev/null || true
rm -rf "$CELLAR" 2>/dev/null || true
brew install xcodegen

xcodegen --version
echo "✓ XcodeGen ready"
