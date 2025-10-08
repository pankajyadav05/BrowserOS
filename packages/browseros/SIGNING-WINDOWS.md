# 🔐 Windows Code Signing Guide for Mitria

## 📋 Overview

Code signing your Windows browser ensures:

- ✅ Users trust your browser (no "Unknown Publisher" warning)
- ✅ SmartScreen doesn't block downloads
- ✅ Windows Defender trusts your application
- ✅ Professional appearance in Windows

## 🎯 Options for Code Signing

### Option 1: Get a Code Signing Certificate (Recommended for Production)

#### A. **EV Code Signing Certificate** (Best - Instant Trust)

- **Cost**: $300-500/year
- **Providers**: DigiCert, SSL.com, Sectigo
- **Benefits**:
  - Instant SmartScreen reputation
  - No warning dialogs
  - Hardware token (USB) required
- **Best for**: Commercial distribution

#### B. **Standard Code Signing Certificate** (Good)

- **Cost**: $100-200/year
- **Providers**: SSL.com, Sectigo, Comodo
- **Benefits**:
  - Signed executables
  - Build reputation over time
- **Drawback**: SmartScreen warnings initially (until you build reputation)
- **Best for**: Open source / smaller projects

### Option 2: Self-Signed Certificate (Testing/Development Only)

**⚠️ WARNING**: Self-signed certificates will show security warnings to users!

- Only use for internal testing
- Not recommended for distribution

---

## 🚀 Setup Instructions

### **Method 1: Using EV/Standard Certificate from SSL.com/DigiCert**

#### Step 1: Purchase Certificate

1. Go to SSL.com, DigiCert, or Sectigo
2. Purchase "Code Signing Certificate" (Standard or EV)
3. Complete identity verification (company documents required)
4. Receive certificate (PFX file + password, or USB token for EV)

#### Step 2: Install Certificate

**For Standard Certificate (PFX file):**

```powershell
# Import to Windows Certificate Store
certutil -user -p YOUR_PASSWORD -importpfx "path\to\certificate.pfx"

# Or double-click the .pfx file and follow wizard
# Choose "Current User" store
# Enter password
# Let Windows automatically select certificate store
```

**For EV Certificate (USB Token):**

- Plug in the USB token
- Install driver from manufacturer
- Certificate auto-available in Windows store

#### Step 3: Find Certificate Name

```powershell
# List all code signing certificates
certutil -store -user My

# Look for your certificate subject name, example:
# Subject: CN=Your Company Name, O=Your Company Inc, ...
```

Copy the **CN** (Common Name) value, e.g., `"Your Company Name"`

#### Step 4: Update Mitria Config

Edit `build/config/sign.windows.yaml`:

```yaml
signing:
  certificate_name: "Mitria Development" # ← Your CN from above
  timestamp_url: "http://timestamp.digicert.com" # Or your CA's timestamp server
```

---

### **Method 2: Self-Signed Certificate (Testing Only)**

#### Step 1: Create Self-Signed Certificate

```powershell
# Run PowerShell as Administrator

# Create self-signed certificate
$cert = New-SelfSignedCertificate `
    -Type CodeSigningCert `
    -Subject "CN=Mitria Development, O=Mitria, C=US" `
    -CertStoreLocation "Cert:\CurrentUser\My" `
    -NotAfter (Get-Date).AddYears(2)

# Export to PFX (optional, for backup)
$password = ConvertTo-SecureString -String "YourPassword123!" -Force -AsPlainText
Export-PfxCertificate -Cert $cert -FilePath "mitria-dev-cert.pfx" -Password $password

# Get certificate thumbprint
$cert.Thumbprint
```

#### Step 2: Trust Certificate Locally

```powershell
# Export certificate
Export-Certificate -Cert $cert -FilePath "mitria-dev-cert.cer"

# Import to Trusted Root (makes Windows trust it)
Import-Certificate -FilePath "mitria-dev-cert.cer" -CertStoreLocation "Cert:\LocalMachine\Root"
```

#### Step 3: Update Config

```yaml
signing:
  certificate_name: "Mitria Development" # ← Match your Subject CN
```

---

## 🔧 Enable Signing in Build

### Update Your Build Config

Edit the file you use for building (e.g., `build/config/release.windows.yaml`):

```yaml
steps:
  clean: false
  git_setup: false
  apply_patches: true
  build: true
  sign: true # ← Enable signing
  package: true

signing:
  certificate_name: "Mitria Development" # Your certificate CN
  timestamp_url: "http://timestamp.digicert.com"
```

### Build Command

```bash
# Build with signing enabled
python build/build.py --config build/config/sign.windows.yaml --chromium-src "B:\projects\chromium\src"
```

---

## 📝 Implementation Status

**Current Status**: Windows signing module needs to be implemented

The codebase currently has:

- ✅ macOS signing (`build/modules/sign.py`)
- ❌ Windows signing (not implemented yet)

**What needs to be added:**

1. Windows signing function in `sign.py`:

```python
def sign_windows_executable(exe_path, cert_name, timestamp_url):
    # Use signtool.exe to sign
    pass
```

2. Call `signtool.exe` from Windows SDK:

```
signtool.exe sign /n "Certificate Name" /t http://timestamp.digicert.com /fd SHA256 /v Mitria.exe
```

---

## 🛠️ Quick Implementation

**Do you want me to:**

1. ✅ **Implement Windows signing module**

   - Add `sign_windows()` function
   - Integrate with build process
   - Auto-detect signtool.exe location

2. ✅ **Create automated signing script**

   - Batch script for manual signing
   - Sign all executables (browser, installer, DLLs)

3. ✅ **Setup guide for certificate**
   - Detailed SSL.com setup
   - Certificate installation
   - Testing verification

**Which would you like me to implement first?**

---

## 📚 Useful Links

- **SSL.com Code Signing**: https://www.ssl.com/code-signing/
- **DigiCert Code Signing**: https://www.digicert.com/signing/code-signing-certificates
- **Microsoft SignTool Docs**: https://learn.microsoft.com/en-us/windows/win32/seccrypto/signtool
- **SmartScreen Reputation**: https://docs.microsoft.com/en-us/windows/security/threat-protection/windows-defender-smartscreen/

---

## ⚡ Quick Test (Self-Signed)

```powershell
# After creating self-signed cert:

# Sign a test executable
signtool sign /n "Mitria Development" /fd SHA256 /v "path\to\Mitria.exe"

# Verify signature
signtool verify /pa /v "path\to\Mitria.exe"
```
