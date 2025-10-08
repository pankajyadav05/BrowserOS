# 📁 Mitria Versioning & Folder Structure

## ✅ Current Setup

```
MITRIA_VERSION:    1
NXTSCAPE_VERSION:  61
──────────────────────────────────
Display:          Mitria v1 (Build 61)
Browser Version:  137.0.7212.69
Output Folder:    out/61/1/Default_x64/
                      ↑  ↑
                      │  └── Mitria version (1, 2, 3, etc.)
                      └───── Build number (61, 62, 63, etc.)
```

## 📂 Folder Structure

Your builds will be organized like this:

```
out/
├── 61/
│   ├── 1/
│   │   └── Default_x64/
│   │       └── Mitria.exe          ← Current build
│   ├── 2/
│   │   └── Default_x64/
│   │       └── Mitria.exe          ← Next Mitria version
│   └── 3/
│       └── Default_x64/
│           └── Mitria.exe
├── 62/
│   ├── 1/
│   │   └── Default_x64/
│   │       └── Mitria.exe          ← Build 62, Mitria v1
│   └── 2/
│       └── Default_x64/
│           └── Mitria.exe
└── 63/
    └── 1/
        └── Default_x64/
            └── Mitria.exe
```

## 🎯 Version Numbers Explained

### Simple Number System:
- **MITRIA_VERSION**: `1`, `2`, `3`, `4`, etc.
  - Your main release versions
  - Increment when you have a major update
  - Users see this as "Mitria v1", "Mitria v2", etc.

- **NXTSCAPE_VERSION**: `61`, `62`, `63`, etc.
  - Build number that increments with each build
  - Gets added to Chromium BUILD number
  - Use for testing, hotfixes, or continuous builds

## 🚀 Common Scenarios

### Scenario 1: New Mitria Release
```bash
# Release Mitria v2
echo 2 > build/config/MITRIA_VERSION

Result:
  Display: Mitria v2 (Build 61)
  Folder:  out/61/2/
```

### Scenario 2: Testing/Hotfix Build
```bash
# Build 62 for testing
echo 62 > build/config/NXTSCAPE_VERSION

Result:
  Display: Mitria v1 (Build 62)
  Folder:  out/62/1/
```

### Scenario 3: Both Updated
```bash
# New version with new build
echo 2 > build/config/MITRIA_VERSION
echo 62 > build/config/NXTSCAPE_VERSION

Result:
  Display: Mitria v2 (Build 62)
  Folder:  out/62/2/
```

## 🔧 Quick Reference

| Action | Command | Result Folder |
|--------|---------|---------------|
| Current | - | `out/61/1/` |
| Next Mitria | `echo 2 > build/config/MITRIA_VERSION` | `out/61/2/` |
| Next Build | `echo 62 > build/config/NXTSCAPE_VERSION` | `out/62/1/` |
| Both | Both commands above | `out/62/2/` |

## 📦 Benefits of This Structure

✅ **Organized**: Each version in its own folder
✅ **Parallel Builds**: Can build different versions simultaneously
✅ **Easy Comparison**: Compare builds side-by-side
✅ **No Conflicts**: Never overwrite previous builds
✅ **Clear Tracking**: Folder name = exact version

## 🎓 Best Practices

1. **Mitria versions** (1, 2, 3) = User-facing releases
2. **Build numbers** (61, 62, 63) = Internal builds/testing
3. Keep NXTSCAPE_VERSION incrementing (don't reuse numbers)
4. Use Mitria version for major feature releases
5. Use Build number for patches, testing, CI/CD

## 🛠️ Use the Bump Tool

Instead of manual edits, use:
```bash
bump-version.bat
```

It will show current versions and let you:
- Increment build number
- Increment Mitria version
- Set custom values
