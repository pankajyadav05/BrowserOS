#!/bin/bash

# Regenerate BrowserOS patches from current Chromium state
# This captures all manual changes made during development

set -e

CHROMIUM_SRC="${1:-/Users/pranav/workspace/chromium/src}"
PATCH_DIR="$(pwd)/patches/browseros"

echo "🔄 Regenerating BrowserOS patches from Chromium source: $CHROMIUM_SRC"
echo "📁 Patch directory: $PATCH_DIR"

cd "$CHROMIUM_SRC"

# Check if we're in a git repo
if ! git rev-parse --git-dir > /dev/null 2>&1; then
    echo "❌ Error: $CHROMIUM_SRC is not a git repository"
    exit 1
fi

# Generate patch for extension constants (check both staged and unstaged)
echo "🔨 Generating browseros-extension-constants.patch..."
if git diff --cached --quiet chrome/browser/extensions/browseros_extension_constants.h 2>/dev/null; then
    # Not staged, try unstaged
    git diff chrome/browser/extensions/browseros_extension_constants.h > "$PATCH_DIR/browseros-extension-constants.patch.new" || true
else
    # Staged, use --cached
    git diff --cached chrome/browser/extensions/browseros_extension_constants.h > "$PATCH_DIR/browseros-extension-constants.patch.new" || true
fi

# Generate patch for external loader (check both staged and unstaged)
echo "🔨 Generating browseros-ota-updater.patch..."
if git diff --cached --quiet chrome/browser/extensions/browseros_external_loader.cc chrome/browser/extensions/browseros_external_loader.h 2>/dev/null; then
    # Not staged, try unstaged
    git diff chrome/browser/extensions/browseros_external_loader.cc chrome/browser/extensions/browseros_external_loader.h > "$PATCH_DIR/browseros-ota-updater.patch.new" || true
else
    # Staged, use --cached
    git diff --cached chrome/browser/extensions/browseros_external_loader.cc chrome/browser/extensions/browseros_external_loader.h > "$PATCH_DIR/browseros-ota-updater.patch.new" || true
fi

# Generate patch for external provider impl changes
echo "🔨 Generating browseros-external-provider-fix.patch..."
git diff chrome/browser/extensions/external_provider_impl.cc > "$PATCH_DIR/browseros-external-provider-fix.patch.new" || true

# Check if patches were generated
echo ""
echo "📊 Generated patches:"
ls -lh "$PATCH_DIR"/*.new

echo ""
echo "✅ Patches generated successfully!"
echo ""
echo "⚠️  Next steps:"
echo "1. Review the .new patch files in: $PATCH_DIR"
echo "2. If they look good, replace the old patches:"
echo "   cd $PATCH_DIR"
echo "   mv browseros-extension-constants.patch.new browseros-extension-constants.patch"
echo "   mv browseros-ota-updater.patch.new browseros-ota-updater.patch"
echo "   mv browseros-external-provider-fix.patch.new browseros-external-provider-fix.patch"
echo "3. Update patches/series file to include browseros-external-provider-fix.patch"
echo "4. Test by applying patches to a clean Chromium checkout"
