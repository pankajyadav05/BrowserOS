#!/bin/bash
# Apply all Mitria patches to Chromium source

if [ -z "$1" ]; then
  echo "Usage: $0 <chromium-src-path>"
  echo "Example: $0 ~/chromium/src"
  exit 1
fi

CHROMIUM_SRC="$1"
PATCHES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SERIES_FILE="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/series"

if [ ! -d "$CHROMIUM_SRC" ]; then
  echo "Error: Chromium source directory not found: $CHROMIUM_SRC"
  exit 1
fi

echo "========================================"
echo "Applying Mitria patches to Chromium"
echo "========================================"
echo "Chromium: $CHROMIUM_SRC"
echo "Patches:  $PATCHES_DIR"
echo ""

cd "$CHROMIUM_SRC" || exit 1

COUNT=0
FAILED=0

while IFS= read -r patch || [ -n "$patch" ]; do
  # Skip empty lines and comments
  [[ -z "$patch" || "$patch" =~ ^# ]] && continue

  COUNT=$((COUNT + 1))
  PATCH_FILE="$PATCHES_DIR/$patch"

  echo "[$COUNT] Applying: $patch"

  if git apply --3way "$PATCH_FILE" 2>&1; then
    echo "[OK]"
  else
    echo "[FAIL] Failed to apply: $patch"
    FAILED=$((FAILED + 1))
    break
  fi
  echo ""
done < "$SERIES_FILE"

echo ""
echo "========================================"
echo "Summary:"
echo "  Patches applied: $COUNT"
if [ $FAILED -gt 0 ]; then
  echo "  Status: FAILED"
  echo "========================================"
  exit 1
else
  echo "  Status: SUCCESS"
  echo "========================================"
  echo ""
  echo "Next step: Run incremental build"
  echo "  ninja -C out/Default chrome"
  exit 0
fi
