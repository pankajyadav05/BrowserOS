@echo off
setlocal enabledelayedexpansion

echo ========================================
echo Mitria Version Management
echo ========================================
echo.

REM Read current versions
set /p MITRIA_VERSION=<build\config\MITRIA_VERSION
set /p BUILD_NUMBER=<build\config\NXTSCAPE_VERSION

for /f "tokens=2 delims==" %%a in ('findstr "MAJOR" CHROMIUM_VERSION') do set CHROMIUM_MAJOR=%%a
for /f "tokens=2 delims==" %%a in ('findstr "MINOR" CHROMIUM_VERSION') do set CHROMIUM_MINOR=%%a
for /f "tokens=2 delims==" %%a in ('findstr "BUILD" CHROMIUM_VERSION') do set CHROMIUM_BUILD=%%a
for /f "tokens=2 delims==" %%a in ('findstr "PATCH" CHROMIUM_VERSION') do set CHROMIUM_PATCH=%%a

set /a FINAL_BUILD=%CHROMIUM_BUILD%+%BUILD_NUMBER%
set FULL_VERSION=%CHROMIUM_MAJOR%.%CHROMIUM_MINOR%.%FINAL_BUILD%.%CHROMIUM_PATCH%

echo Current Setup:
echo   Mitria Version:  v%MITRIA_VERSION%
echo   Build Number:    %BUILD_NUMBER%
echo   Chromium Base:   %CHROMIUM_MAJOR%.%CHROMIUM_MINOR%.%CHROMIUM_BUILD%.%CHROMIUM_PATCH%
echo   Full Version:    %FULL_VERSION%
echo   Output Folder:   out\%BUILD_NUMBER%\%MITRIA_VERSION%\
echo.
echo ========================================
echo What would you like to update?
echo ========================================
echo.
echo   1. Increment Build Number (%BUILD_NUMBER% → %BUILD_NUMBER%+1)
echo   2. New Mitria Release (v%MITRIA_VERSION% → v%MITRIA_VERSION%+1)
echo   3. Custom Values
echo.

set /p CHOICE="Enter choice (1-3): "

if "%CHOICE%"=="1" (
    REM Just increment build number
    set /a NEW_BUILD=%BUILD_NUMBER%+1
    echo !NEW_BUILD!>build\config\NXTSCAPE_VERSION

    set /a NEW_FINAL_BUILD=%CHROMIUM_BUILD%+!NEW_BUILD!
    set NEW_FULL_VERSION=%CHROMIUM_MAJOR%.%CHROMIUM_MINOR%.!NEW_FINAL_BUILD!.%CHROMIUM_PATCH%

    echo.
    echo ========================================
    echo Updated Build Number
    echo ========================================
    echo   Build Number: %BUILD_NUMBER% → !NEW_BUILD!
    echo   Full Version: %FULL_VERSION% → !NEW_FULL_VERSION!
    echo   Mitria Version: v%MITRIA_VERSION% (unchanged)
    echo   Output Folder: out\!NEW_BUILD!\%MITRIA_VERSION%\
)

if "%CHOICE%"=="2" (
    REM Increment Mitria version
    set /a NEW_MITRIA=%MITRIA_VERSION%+1
    echo !NEW_MITRIA!>build\config\MITRIA_VERSION

    echo.
    echo ========================================
    echo New Mitria Release
    echo ========================================
    echo   Mitria Version: v%MITRIA_VERSION% → v!NEW_MITRIA!
    echo   Build Number: %BUILD_NUMBER% (unchanged)
    echo   Full Version: %FULL_VERSION% (unchanged)
    echo   Output Folder: out\%BUILD_NUMBER%\!NEW_MITRIA!\
)

if "%CHOICE%"=="3" (
    echo.
    set /p NEW_MITRIA="Enter Mitria version (simple number, e.g., 2): "
    set /p NEW_BUILD="Enter Build number (e.g., 62): "

    echo !NEW_MITRIA!>build\config\MITRIA_VERSION
    echo !NEW_BUILD!>build\config\NXTSCAPE_VERSION

    set /a NEW_FINAL_BUILD=%CHROMIUM_BUILD%+!NEW_BUILD!
    set NEW_FULL_VERSION=%CHROMIUM_MAJOR%.%CHROMIUM_MINOR%.!NEW_FINAL_BUILD!.%CHROMIUM_PATCH%

    echo.
    echo ========================================
    echo Custom Version Set
    echo ========================================
    echo   Mitria Version: v%MITRIA_VERSION% → v!NEW_MITRIA!
    echo   Build Number: %BUILD_NUMBER% → !NEW_BUILD!
    echo   Full Version: %FULL_VERSION% → !NEW_FULL_VERSION!
    echo   Output Folder: out\!NEW_BUILD!\!NEW_MITRIA!\
)

echo.
echo ========================================
echo Version Files Updated
echo ========================================
echo   MITRIA_VERSION:     build\config\MITRIA_VERSION
echo   NXTSCAPE_VERSION:   build\config\NXTSCAPE_VERSION
echo.
echo Next step: Build the browser
echo   python build/build.py --config build/config/release.windows.yaml --chromium-src "B:\projects\chromium\src"
echo.
pause
