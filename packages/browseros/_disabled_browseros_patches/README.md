# Disabled Mitria Patches

This directory contains patches that have been disabled from the build.

## Structure

### llm-extensions/
Patches related to the removed LLM Chat and LLM Hub native features:
- `llm-chat.patch` - Third Party LLM Chat side panel feature (ChatGPT, Claude, Gemini, etc.)
- `llm-hub.patch` - LLM Hub / Clash of GPTs popout window feature
- `pin-chat-and-hub.patch` - Toolbar pinning for LLM Chat and Hub
- `updates-llm-chat-and-hub.patch` - Updates and improvements to LLM features

### settings/
Settings pages for the removed LLM features:
- `browseros-ai-settings-page.patch` - AI settings page in browser settings
- `llm-settings-page-updates.patch` - Updates to LLM settings pages

### other/
Miscellaneous disabled patches:
- `pin-extensions-toolbar.patch` - Extension toolbar pinning functionality

## Removal Date
**Date**: 2025-10-09
**Reason**: Removed native LLM Chat and LLM Hub features, and BrowserOS Feedback extension to streamline Mitria browser

## What Was Kept
- ✅ AI Agent Extension (djhdjhlnljbjgejbndockeedocneiaei) - Kept for AI automation
- ✅ NEW Tab Extension - Kept for new tab functionality
- ✅ All other core browser functionality

## What Was Removed
- ❌ Third Party LLM Chat (native side panel feature)
- ❌ LLM Hub / Clash of GPTs (native popout window)
- ❌ LLM/AI Settings pages
- ❌ BrowserOS Feedback Extension (Bug Reporter)

## Notes
- These patches are kept for reference and potential future use
- To re-enable any of these features, move the patch back to `patches/browseros/` and add it to the `series` file
- The extension constants have been updated to only include AI Agent extension
