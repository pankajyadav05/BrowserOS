# 🔢 Mitria Browser Version Management

## Current Version: Mitria 1.0.0 (Build 1) - Chromium 137.0.7152.69

## 📋 Version Files

| File | Purpose | Current Value | Result |
|------|---------|---------------|--------|
| `build/config/MITRIA_VERSION` | Your product version | `1.0.0` | Shown in About |
| `build/config/NXTSCAPE_VERSION` | Build number | `1` | Added to Chromium BUILD |
| `CHROMIUM_VERSION` | Base Chromium (don't touch) | `137.0.7151.69` | Base version |
| **Final Browser Version** | Chromium + Build | - | **137.0.7152.69** |

## 🚀 How to Release New Version

### Use the Version Bump Tool (Recommended):

```bash
bump-version.bat
```

Then choose:
- **Option 1**: Increment build (quick updates) - `1.0.0` + build 2
- **Option 2**: Patch release (bug fixes) - `1.0.0` → `1.0.1`
- **Option 3**: Minor release (new features) - `1.0.0` → `1.1.0`
- **Option 4**: Major release (big changes) - `1.0.0` → `2.0.0`
- **Option 5**: Custom version

### Manual Method:

**For New Mitria Release (v1 → v2):**
```bash
echo 2 > build/config/MITRIA_VERSION
# Build number stays 61, output: out/61/2/
```

**For Build Increment (testing/hotfix):**
```bash
echo 62 > build/config/NXTSCAPE_VERSION
# Mitria version stays 1, output: out/62/1/
```

**For New Mitria + Build Increment:**
```bash
echo 2 > build/config/MITRIA_VERSION
echo 62 > build/config/NXTSCAPE_VERSION
# Output: out/62/2/
```

## 📊 Version Examples

### Your Current Setup:
```
MITRIA_VERSION:       1            (Release version - simple number)
NXTSCAPE_VERSION:     61           (Build number - keeps incrementing)
CHROMIUM_VERSION:     137.0.7151.69 (Base - don't change)
───────────────────────────────────────────────────────
Browser shows:        Mitria v1 (Build 61)
Technical version:    137.0.7212.69
About page:          "Mitria v1 based on Chromium 137.0.7212.69"
Output folder:       out/61/1/Default_x64/
```

### Release Progression:
```
Release 1:  Mitria v1 (Build 61)  → 137.0.7212.69  → out/61/1/
Release 2:  Mitria v1 (Build 62)  → 137.0.7213.69  → out/62/1/
Release 3:  Mitria v2 (Build 61)  → 137.0.7212.69  → out/61/2/
Release 4:  Mitria v3 (Build 61)  → 137.0.7212.69  → out/61/3/
Release 5:  Mitria v3 (Build 62)  → 137.0.7213.69  → out/62/3/
```

## 🎯 Recommended Versioning Scheme

Start with version **1.0.x.0**:

```
Release 1:  1.0.1.0   (NXTSCAPE_VERSION=1)
Release 2:  1.0.2.0   (NXTSCAPE_VERSION=2)
Release 3:  1.0.3.0   (NXTSCAPE_VERSION=3)
...
Release 10: 1.0.10.0  (NXTSCAPE_VERSION=10)
```

For major updates:
```
v2.0:       2.0.1.0   (MAJOR=2, NXTSCAPE_VERSION=1)
```

## 🔧 Quick Version Bump Script

### Windows (PowerShell):
```powershell
# Increment release number
$current = Get-Content build\config\NXTSCAPE_VERSION
$new = [int]$current + 1
Set-Content build\config\NXTSCAPE_VERSION $new
Write-Host "Version bumped to: 1.0.$new.0"
```

### Batch Script:
```batch
@echo off
set /p CURRENT=<build\config\NXTSCAPE_VERSION
set /a NEW=%CURRENT%+1
echo %NEW%>build\config\NXTSCAPE_VERSION
echo Version bumped to: 1.0.%NEW%.0
```

## 📝 Where Version Appears

| Location | Example |
|----------|---------|
| About Page (`chrome://version`) | Mitria 1.0.1.0 |
| Windows Apps & Features | Mitria 1.0.1.0 |
| Installer | Mitria-1.0.1.0-Setup.exe |
| Application Title Bar | Mitria 1.0.1.0 |

## 🐛 Troubleshooting

**Problem**: Version not updating after rebuild
**Solution**: Run clean build:
```bash
python build/build.py --clean --chromium-src "B:\projects\chromium\src"
```

**Problem**: Want to match extension version (1.0.0)
**Solution**:
```
CHROMIUM_VERSION: MAJOR=1, MINOR=0, BUILD=0, PATCH=0
NXTSCAPE_VERSION: 0
Result: 1.0.0.0
```

## 📅 Version History

```
1.0.1.0 - 2025-10-08
- Initial Mitria release
- Rebranded from BrowserOS
- Custom new tab page
- AI sidepanel agent
```

## 🔄 Update Workflow

1. **Decide version increment**
   - Patch fix? → Increment NXTSCAPE_VERSION
   - New features? → Increment MINOR, reset NXTSCAPE_VERSION=1
   - Breaking changes? → Increment MAJOR, reset MINOR=0, NXTSCAPE_VERSION=1

2. **Update version files**
   ```bash
   # Example: Increment to 1.0.2.0
   echo 2 > build/config/NXTSCAPE_VERSION
   ```

3. **Build**
   ```bash
   python build/build.py --config build/config/release.windows.yaml --chromium-src "B:\projects\chromium\src"
   ```

4. **Verify**
   - Check `chrome://version` in built browser
   - Check installer filename
   - Check Windows Apps & Features after install
