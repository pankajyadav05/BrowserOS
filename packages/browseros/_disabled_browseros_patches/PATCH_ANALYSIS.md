# Mitria Browser Patch Analysis

## Repository Overview
- **Fork Name**: Mitria (formerly BrowserOS)
- **Analysis Date**: 2025-10-09
- **Purpose**: Clean up patch system and remove unwanted extensions

## Current Patch Structure

### Active Patches Directory
**Location**: `packages/browseros/patches/browseros/`

**Currently Applied Patches**:
1. `first-run.patch` - First run experience
2. `chrome-importer.patch` - Chrome import functionality
3. `chrome-version-updater.patch` - Version management
4. `browseros-ota-updater.patch` - OTA update system (contains extension IDs)
5. `browseros-api.patch` - Core API
6. `browseros-api-updates.patch` - API updates
7. `browseros-api-updates-v2.patch` - API updates v2
8. `disable-user-gesture-restriction-on-sidepanel.patch` - UI improvement
9. `disable-info-bar-in-cdp.patch` - Chrome DevTools Protocol
10. `disable-google-key-info-bar.patch` - Remove Google key warning
11. `disable-sidepanel-animation.patch` - UI performance
12. `branding-file-updates.patch` - Mitria branding
13. `adding-new-vector-icons.patch` - Custom icons

### Old Patches Directory
**Location**: `packages/browseros/patches/old/browseros/`

**Patches Related to Extensions to Remove**:
1. **llm-chat.patch** - LLM Chat extension implementation (~1400 lines)
2. **llm-hub.patch** - LLM Hub extension implementation (~31000 lines, TOO LARGE)
3. **pin-chat-and-hub.patch** - Pins LLM Chat and Hub to toolbar
4. **updates-llm-chat-and-hub.patch** - Updates to LLM Chat and Hub
5. **llm-settings-page-updates.patch** - Settings page for LLM
6. **browseros-ai-settings-page.patch** - AI settings page

### Extension IDs to Remove

Based on patch analysis, these extensions are referenced:

1. **AI Side Panel Extension**
   - ID: `djhdjhlnljbjgejbndockeedocneiaei`
   - Name: AI Agent / AI Side Panel
   - Purpose: LLM Chat functionality
   - **STATUS**: TO BE REMOVED

2. **Bug Reporter Extension**
   - ID: `jpajdgphofjhblkgpbemoelbnbinnpje`
   - Name: BrowserOS Feedback / Bug Reporter
   - Purpose: Bug reporting
   - **STATUS**: TO BE REMOVED

## Patches Analysis

### Patches in `old/browseros/` Directory

#### Safe to Remove (Extension-Related):
- ✅ `llm-chat.patch` - LLM Chat implementation
- ✅ `llm-hub.patch` - LLM Hub implementation
- ✅ `pin-chat-and-hub.patch` - Toolbar pinning for chat/hub
- ✅ `updates-llm-chat-and-hub.patch` - Updates to chat/hub
- ✅ `llm-settings-page-updates.patch` - LLM settings
- ✅ `browseros-ai-settings-page.patch` - AI settings page
- ✅ `pin-extensions-toolbar.patch` - Extensions toolbar pinning

#### Keep (Core Functionality):
- ✅ `first-run.patch` - First run experience
- ✅ `chrome-importer.patch` - Import from Chrome
- ✅ `chrome-version-updater.patch` - Version management
- ✅ `browseros-ota-updater.patch` - **NEEDS MODIFICATION** (remove extension IDs)
- ✅ `browseros-metrics.patch` - Metrics system
- ✅ `browseros-api.patch` - Core API
- ✅ `browseros-api-updates.patch` - API updates
- ✅ `browseros-api-updates-v2.patch` - API updates v2
- ✅ `disable-*.patch` - UI improvements
- ✅ `branding-file-updates.patch` - Mitria branding
- ✅ `adding-new-vector-icons.patch` - Custom icons
- ✅ `mac-sparkle-updater.patch` - macOS update system
- ✅ `add-sparkle-info-plist-keys.patch` - macOS plist keys
- ✅ `preferences-settings-page.patch` - Preferences page

### Patches Requiring Modification

#### 1. `browseros-ota-updater.patch`
**Issue**: Contains extension ID constants that reference BrowserOS Feedback
**Action**: Remove extension ID definitions but keep OTA update logic

**Lines to Remove**:
```cpp
// AI Agent Extension ID
inline constexpr char kAISidePanelExtensionId[] =
    "djhdjhlnljbjgejbndockeedocneiaei";

// Bug Reporter Extension ID
inline constexpr char kBugReporterExtensionId[] =
    "jpajdgphofjhblkgpbemoelbnbinnpje";
```

## Disabled Patch Directories

### Current State:
1. **_disabled_chromium_patches** - Contains old chromium patches
   - `icons/` - Icon patches
   - `side_panel/` - Side panel patches
   - `webui/` - WebUI patches

2. **_disabled_patches** - Contains disabled BrowserOS patches
   - Various old patches from previous cleanup

### Proposed Structure:
**Keep only**: `_disabled_browseros_patches/`
- This will contain all disabled BrowserOS-specific patches
- Move relevant patches from `old/` that are extension-related

## Action Plan

### Phase 1: Create Disabled Folder Structure
1. Create `_disabled_browseros_patches/` folder
2. Create subdirectories:
   - `llm-extensions/` - For LLM Chat and Hub patches
   - `settings/` - For settings page patches
   - `other/` - For miscellaneous disabled patches

### Phase 2: Move Extension Patches
Move these patches from `old/browseros/` to `_disabled_browseros_patches/llm-extensions/`:
- `llm-chat.patch`
- `llm-hub.patch`
- `pin-chat-and-hub.patch`
- `updates-llm-chat-and-hub.patch`

Move to `_disabled_browseros_patches/settings/`:
- `llm-settings-page-updates.patch`
- `browseros-ai-settings-page.patch`

### Phase 3: Modify Active Patches
1. Edit `browseros-ota-updater.patch` to remove extension ID constants
2. Update series file to reflect current patch list

### Phase 4: Clean Up
1. Delete `_disabled_chromium_patches/`
2. Delete `_disabled_patches/`
3. Clean up `old/browseros/` directory (keep for reference or move to disabled)

### Phase 5: Verification
1. Ensure all active patches in `series` file are present
2. Verify no references to removed extension IDs in active patches
3. Test patch application

## Series File Current State

```
browseros/first-run.patch
browseros/chrome-importer.patch
browseros/chrome-version-updater.patch
browseros/browseros-ota-updater.patch
browseros/pin-extensions-toolbar.patch
browseros/browseros-metrics.patch
browseros/disable-user-gesture-restriction-on-sidepanel.patch
browseros/disable-info-bar-in-cdp.patch
browseros/browseros-ai-settings-page.patch
browseros/disable-google-key-info-bar.patch
browseros/disable-chrome-labs-pinning.patch
browseros/browseros-api.patch
browseros/browseros-api-updates.patch
browseros/mac-sparkle-updater.patch
browseros/add-sparkle-info-plist-keys.patch
browseros/adding-new-vector-icons.patch
browseros/pin-chat-and-hub.patch
browseros/llm-hub.patch
browseros/llm-chat.patch
browseros/branding-file-updates.patch
browseros/updates-llm-chat-and-hub.patch
browseros/llm-settings-page-updates.patch
browseros/disable-sidepanel-animation.patch
```

**Lines to Remove from series**:
- `browseros/pin-extensions-toolbar.patch` (if extension-specific)
- `browseros/browseros-ai-settings-page.patch`
- `browseros/pin-chat-and-hub.patch`
- `browseros/llm-hub.patch`
- `browseros/llm-chat.patch`
- `browseros/updates-llm-chat-and-hub.patch`
- `browseros/llm-settings-page-updates.patch`

## Notes

- The repository has been renamed from BrowserOS to Mitria
- CDN URLs have been changed for XML and extensions
- Extension IDs `djhdjhlnljbjgejbndockeedocneiaei` (AI Side Panel) and `jpajdgphofjhblkgpbemoelbnbinnpje` (Bug Reporter) should be completely removed
- Some patches contain "BrowserOS Feedback" references that need cleanup

## Risk Assessment

### Low Risk:
- Removing patches from `old/` directory (not actively used)
- Creating new `_disabled_browseros_patches/` structure
- Deleting old disabled folders

### Medium Risk:
- Modifying `browseros-ota-updater.patch` (needs careful editing)
- Updating `series` file (must match existing patches)

### High Risk:
- None identified if done carefully

## Recommendations

1. ✅ Backup current patch state before making changes
2. ✅ Test patch application after each major change
3. ✅ Keep old patches in disabled folder for reference
4. ✅ Update documentation to reflect Mitria branding
5. ✅ Consider creating a patch versioning system
