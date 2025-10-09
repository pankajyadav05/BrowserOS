# Extension Management Report - Mitria Browser

**Date**: 2025-10-09
**Question**: Which patches handle CDN extension installation and New Tab extension?

---

## 1. ✅ CDN Extension Installation

### Patch: `browseros-ota-updater.patch`

**Location**: `packages/browseros/patches/browseros/browseros-ota-updater.patch`

**Status**: ✅ **ACTIVE** (in series file)

### What It Does:

This patch creates a **complete automatic extension installation system** that:

1. **Fetches extension config from remote CDN**
   - CDN URL: `https://opsl2ghblbw964xx.public.blob.vercel-storage.com/extensions.json`
   - Can be overridden with `--browseros-extensions-url` command flag

2. **Creates `BrowserOSExternalLoader` class**
   - File: `chrome/browser/extensions/browseros_external_loader.cc` (579 lines)
   - File: `chrome/browser/extensions/browseros_external_loader.h` (113 lines)

3. **Expected JSON format** from CDN:
```json
{
  "extensions": {
    "extension_id_1": {
      "external_update_url": "https://example.com/extension1/updates.xml"
    },
    "extension_id_2": {
      "external_crx": "https://example.com/extension2.crx",
      "external_version": "1.0"
    }
  }
}
```

### Key Features:

- ✅ **Automatic installation** at browser startup
- ✅ **Periodic maintenance** (every 15 minutes)
- ✅ **Bypasses cache** (always fetches latest config)
- ✅ **Only installs allowlisted extensions** (uses `browseros::kAllowedExtensions`)
- ✅ **Network traffic annotation** (for security/privacy)
- ✅ **Testing support** (can load from local file)

### Current Allowlisted Extensions:

Based on your `browseros-extension-constants.patch`:
```cpp
constexpr const char* kAllowedExtensions[] = {
    kAISidePanelExtensionId,  // "djhdjhlnljbjgejbndockeedocneiaei"
};
```

**Only AI Agent extension is allowed to auto-install from CDN!**

### Code Flow:

```
1. Browser startup
   ↓
2. BrowserOSExternalLoader::StartLoading()
   ↓
3. Fetch JSON from CDN (Vercel storage)
   ↓
4. Parse configuration
   ↓
5. Check against kAllowedExtensions
   ↓
6. Install only allowlisted extensions
```

### Security Features:

- ✅ **Allowlist-based**: Only specific extension IDs can be installed
- ✅ **User cannot disable**: BrowserOS extensions are protected from uninstall
- ✅ **No cookies**: Network requests don't send cookies
- ✅ **Cache bypass**: Always gets latest version

---

## 2. ❓ New Tab Extension

### Findings: **NO dedicated New Tab patch found**

**What I searched for:**
- ✅ Patches containing "newtab", "new tab", "ntp"
- ✅ Extension ID references
- ✅ Chrome URLs (chrome://newtab)
- ✅ Config files

**What I found:**
- ❌ No specific "New Tab extension" patch
- ❌ No New Tab extension ID in constants
- ⚠️ References to "new tab" in `browseros-api.patch` but these are about **detecting tab creation**, not replacing the New Tab page

### Possible Scenarios:

#### Scenario A: New Tab is a Regular Extension
If you have a New Tab extension, it should be:
1. Added to `kAllowedExtensions` in `browseros-extension-constants.patch`
2. Listed in your CDN's `extensions.json` file
3. Auto-installed via `BrowserOSExternalLoader`

#### Scenario B: New Tab is Built-in
Some forks replace the New Tab page with custom HTML/WebUI directly in the browser code (not as an extension).

#### Scenario C: Not Yet Implemented
New Tab customization might not be implemented yet in your patches.

### Question for You:

**Is your "NEW Tab extension" actually:**
- A. A Chrome extension with an extension ID?
- B. Built-in WebUI replacement (not an extension)?
- C. Something else?

If it's option A (extension), **what's the extension ID?**

---

## 3. Summary Table

| Feature | Patch Name | Status | Location |
|---------|-----------|--------|----------|
| **CDN Extension Install** | `browseros-ota-updater.patch` | ✅ Active | `browseros/` |
| **AI Agent Extension** | Supported | ✅ Active | Auto-installed from CDN |
| **Bug Reporter** | Removed | ❌ Disabled | Removed from constants |
| **New Tab Extension** | ??? | ❓ Unknown | Not found |

---

## 4. Current Extension Setup

### Active Extensions (Auto-installed):
```
1. AI Agent Extension
   ID: djhdjhlnljbjgejbndockeedocneiaei
   Source: CDN (Vercel)
   Status: ✅ Allowlisted

2. NEW Tab Extension
   ID: ???
   Source: ???
   Status: ❓ Unknown
```

### Disabled Extensions:
```
1. BrowserOS Feedback / Bug Reporter
   ID: jpajdgphofjhblkgpbemoelbnbinnpje (old)
   Status: ❌ Removed from allowlist
```

---

## 5. What Needs To Be Done

### To Enable New Tab Extension (if it exists):

**Step 1**: Tell me the New Tab extension ID

**Step 2**: Add it to `browseros-extension-constants.patch`:
```cpp
// New Tab Extension ID
inline constexpr char kNewTabExtensionId[] =
    "YOUR_EXTENSION_ID_HERE";

// Allowlist of Mitria extension IDs
constexpr const char* kAllowedExtensions[] = {
    kAISidePanelExtensionId,  // AI Agent extension
    kNewTabExtensionId,       // New Tab extension
};
```

**Step 3**: Update `extensions.json` on your CDN (Vercel):
```json
{
  "extensions": {
    "djhdjhlnljbjgejbndockeedocneiaei": {
      "external_update_url": "https://your-cdn.com/ai-agent/updates.xml"
    },
    "YOUR_NEW_TAB_EXTENSION_ID": {
      "external_update_url": "https://your-cdn.com/new-tab/updates.xml"
    }
  }
}
```

---

## 6. Patches Review Status

### B. Reviewing Useful Patches

Based on your earlier question about useful patches:

#### 1. `disable-chrome-labs-pinning.patch`
- **Status**: In `_disabled_browseros_patches/other/`
- **Purpose**: Prevents Chrome Labs from auto-pinning
- **Recommendation**: ✅ **ENABLE** - Good for de-Googling

#### 2. `pin-extensions-toolbar.patch`
- **Status**: In `_disabled_browseros_patches/other/`
- **Purpose**: Auto-pins BrowserOS extensions to toolbar
- **Issue**: ⚠️ References Bug Reporter extension (removed)
- **Recommendation**: ⚠️ **NEEDS MODIFICATION**
  - Remove Bug Reporter references
  - Keep only AI Agent (and New Tab if applicable)

---

## 7. Next Steps - Please Clarify

### Questions for You:

1. **New Tab Extension:**
   - Do you have a New Tab extension?
   - If yes, what's the extension ID?
   - Is it already in your CDN's extensions.json?

2. **Enable Useful Patches:**
   - Should I enable `disable-chrome-labs-pinning.patch`?
   - Should I modify and enable `pin-extensions-toolbar.patch`?

3. **Extension Constants:**
   - Should I update `browseros-extension-constants.patch` to include New Tab extension?

Let me know and I'll proceed with the changes!

---

## 8. Current CDN Configuration

**Your CDN URL**: `https://opsl2ghblbw964xx.public.blob.vercel-storage.com/extensions.json`

**Expected file content** (example):
```json
{
  "extensions": {
    "djhdjhlnljbjgejbndockeedocneiaei": {
      "external_update_url": "https://your-cdn.com/ai-agent/updates.xml"
    }
  }
}
```

**Does this file exist on your Vercel storage?**
If not, the extension loader will fail to install anything!

---

## Summary

✅ **Found**: CDN extension installation system (`browseros-ota-updater.patch`)
✅ **Active**: AI Agent extension is allowlisted
❌ **Not Found**: New Tab extension patches
❓ **Need Info**: New Tab extension ID and details

**Waiting for your input to proceed!**
