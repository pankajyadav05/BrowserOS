# BrowserOS Patches Guide

## Overview

This document explains the BrowserOS patch system and how to maintain patches for Chromium modifications.

## Current Patches

### Extension Auto-Loading System

**1. browseros-extension-constants.patch**
- Creates `chrome/browser/extensions/browseros_extension_constants.h`
- Defines the allowlisted BrowserOS extension IDs
- Current extension ID: `fgclfkicgopmgbgkiokmljnkdhapddef`

**2. browseros-ota-updater.patch**
- Creates `chrome/browser/extensions/browseros_external_loader.cc` and `.h`
- Implements remote configuration fetching from URL
- Downloads CRX files from HTTPS URLs to local cache
- Provides periodic maintenance (reinstall, re-enable, update check)
- Default config URL: `https://opsl2ghblbw964xx.public.blob.vercel-storage.com/extensions.json`

**3. browseros-external-provider-fix.patch** (NEW)
- Modifies `chrome/browser/extensions/external_provider_impl.cc`
- Registers BrowserOS external loader with Chromium's extension system
- **Critical Fix**: Sets `ManifestLocation::kExternalPrefDownload` (required for CRX file installation)
- Enables command-line flags: `--browseros-extensions-url` and `--disable-browseros-extensions`

## How Extension Auto-Loading Works

1. **Browser Startup** → BrowserOS external loader starts
2. **Fetch Config** → Downloads JSON from remote URL
3. **Download CRX** → If `external_crx` is HTTPS URL, downloads to local cache
4. **Install Extension** → Passes local CRX path to Chromium's ExternalProviderImpl
5. **Periodic Check** → Every 15 minutes: re-enable, reinstall if removed, check for updates

## Remote Configuration Format

```json
{
  "extensions": {
    "fgclfkicgopmgbgkiokmljnkdhapddef": {
      "external_crx": "https://example.com/extension.crx",
      "external_version": "1.0.0"
    }
  }
}
```

## Regenerating Patches

If you make manual changes to Chromium source (e.g., changing extension ID, fixing bugs), regenerate patches:

```bash
cd /Users/pranav/workspace/codifyit/BrowserOS/packages/browseros
./regenerate-patches.sh ~/workspace/chromium/src
```

This will:
1. Detect changes in staged and unstaged files
2. Generate `.new` patch files
3. Prompt you to review and replace old patches

**Manual review and replacement:**
```bash
cd patches/browseros
# Review the new patches
diff browseros-ota-updater.patch browseros-ota-updater.patch.new
# If good, replace
mv browseros-*.patch.new browseros-*.patch
```

## Building with Patches

The Python build script automatically applies all patches from `patches/series`:

```bash
python build/build.py \
  --config build/config/release.macos.yaml \
  --chromium-src ~/workspace/chromium/src \
  --build
```

Patches are applied in this order:
1. `browseros-extension-constants.patch` - Creates extension constants header
2. `browseros-ota-updater.patch` - Creates external loader implementation
3. `browseros-external-provider-fix.patch` - Integrates loader with Chromium

## Troubleshooting

### Patch Application Fails

**Error: "patch does not apply"**
- Chromium version mismatch - patches were created for a specific Chromium version
- Solution: Regenerate patches from current Chromium source

**Error: "trailing whitespace"**
- Git warning, usually safe to ignore
- Or clean with: `sed -i '' 's/[[:space:]]*$//' patches/browseros/*.patch`

### Extension Not Installing

**Check logs** (launch with: `open Mitria.app --args --enable-logging=stderr --v=1 2>&1 | tee debug.log`):

1. **"BrowserOS external extension loader starting..."**
   - ✅ Loader is working
   - ❌ If missing: `browseros-ota-updater.patch` not applied

2. **"Successfully downloaded CRX for <id>..."**
   - ✅ CRX download working
   - ❌ If missing: Check network/URL

3. **"WARNING: This provider does not support installing external extensions from crx files"**
   - ❌ `browseros-external-provider-fix.patch` not applied or wrong ManifestLocation
   - Solution: Regenerate and re-apply patches

4. **"Expected ID 'X', but ID was 'Y'"**
   - ❌ Extension ID mismatch between:
     - `browseros_extension_constants.h`
     - Remote JSON config
     - Actual CRX file
   - Solution: Align all three to use same ID

## Updating Extension ID

If you rebuild the extension with a different key:

1. Update `browseros_extension_constants.h` in Chromium source
2. Regenerate patches: `./regenerate-patches.sh ~/workspace/chromium/src`
3. Replace old patch: `mv patches/browseros/browseros-extension-constants.patch.new patches/browseros/browseros-extension-constants.patch`
4. Update remote JSON config with new ID
5. Rebuild Chromium

## Extension ID Stability

The extension ID is derived from the **public key** used to sign the CRX.

**To maintain stable ID:**
- Always use the same `dist.pem` private key when packing
- Keep `manifest.json` `key` field unchanged
- Use the pack script: `npm run pack` in BrowserOS-agent repo

**Current stable ID:** `fgclfkicgopmgbgkiokmljnkdhapddef`

## Command-Line Flags

```bash
# Use custom config URL
open Mitria.app --args --browseros-extensions-url="https://example.com/extensions.json"

# Disable BrowserOS extensions
open Mitria.app --args --disable-browseros-extensions

# Enable verbose logging
open Mitria.app --args --enable-logging=stderr --v=1
```
