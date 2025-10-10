# PowerShell script to apply all Mitria patches to Chromium source

param(
    [Parameter(Mandatory=$true)]
    [string]$ChromiumSrcPath
)

$PatchesBaseDir = Split-Path -Parent $PSCommandPath
$SeriesFile = Join-Path $PatchesBaseDir "series"

# Validate inputs
if (-not (Test-Path $ChromiumSrcPath)) {
    Write-Host "Error: Chromium source directory not found: $ChromiumSrcPath" -ForegroundColor Red
    exit 1
}

if (-not (Test-Path $SeriesFile)) {
    Write-Host "Error: Series file not found: $SeriesFile" -ForegroundColor Red
    exit 1
}

Write-Host "========================================"
Write-Host "Applying Mitria patches to Chromium"
Write-Host "========================================"
Write-Host "Chromium: $ChromiumSrcPath"
Write-Host "Patches:  $PatchesBaseDir"
Write-Host ""

# Change to chromium source directory
Push-Location $ChromiumSrcPath

$Count = 0
$Failed = 0
$FailedPatch = $null

# Read series file and apply patches in order
Get-Content $SeriesFile | ForEach-Object {
    $line = $_.Trim()

    # Skip empty lines and comments
    if ([string]::IsNullOrWhiteSpace($line) -or $line.StartsWith('#')) {
        return
    }

    $Count++
    # Series file has "browseros/patch.patch" format, so join with base dir
    $PatchFile = Join-Path $PatchesBaseDir $line

    Write-Host -NoNewline "[$Count] Applying: $line ... "

    if (-not (Test-Path $PatchFile)) {
        Write-Host "[FAIL] FILE NOT FOUND" -ForegroundColor Red
        $Failed++
        $FailedPatch = $line
        return
    }

    # Apply patch using git apply with 3-way merge
    $result = & git apply --3way $PatchFile 2>&1

    if ($LASTEXITCODE -eq 0) {
        Write-Host "[OK]" -ForegroundColor Green
    } else {
        Write-Host "[FAIL]" -ForegroundColor Red
        $Failed++
        $FailedPatch = $line
        Write-Host ""
        Write-Host "Error details:" -ForegroundColor Yellow
        $result | ForEach-Object { Write-Host "  $_" -ForegroundColor Yellow }
        Write-Host ""
        return
    }
}

Pop-Location

Write-Host ""
Write-Host "========================================"
Write-Host "Summary:"
Write-Host "  Patches applied: $Count"

if ($Failed -gt 0) {
    Write-Host "  Status: FAILED" -ForegroundColor Red
    Write-Host "========================================"
    Write-Host ""
    Write-Host "Failed at: $FailedPatch" -ForegroundColor Red
    exit 1
} else {
    Write-Host "  Status: SUCCESS" -ForegroundColor Green
    Write-Host "========================================"
    Write-Host ""
    Write-Host "Next step: Run incremental build" -ForegroundColor Cyan
    Write-Host "  cd $ChromiumSrcPath"
    Write-Host "  ninja -C out/Default chrome"
    Write-Host ""
    Write-Host "Then launch to verify patches:" -ForegroundColor Cyan
    Write-Host "  out/Default/chrome.exe"
    exit 0
}
