@echo off
setlocal EnableDelayedExpansion

:: 1. Check for Administrator privileges and elevate cleanly
net session >nul 2>&1
if %errorlevel% neq 0 (
    echo Requesting administrative privileges...
    powershell -NoProfile -ExecutionPolicy Bypass -Command "Start-Process cmd -ArgumentList '/c `\"%~f0`\"' -Verb RunAs"
    exit /b
)

title ADB Systemwide Installer

set "INSTALL_DIR=C:\adb"
set "ZIP_FILE=%TEMP%\platform-tools.zip"
set "URL=https://dl.google.com/android/repository/platform-tools-latest-windows.zip"

echo ===================================================
echo             ADB SYSTEMWIDE INSTALLER
echo ===================================================
echo.

:: 2. Create destination folder
echo [1/4] Setting up destination at %INSTALL_DIR%...
if not exist "%INSTALL_DIR%" mkdir "%INSTALL_DIR%"

:: 3. Download using native curl.exe
echo [2/4] Downloading latest Android Platform Tools...
curl.exe -L -# -o "%ZIP_FILE%" "%URL%"
if %errorlevel% neq 0 (
    echo [ERROR] Download failed. Please check your internet connection.
    pause
    exit /b 1
)

:: 4. Extract using native tar.exe (bypasses Expand-Archive module errors)
echo [3/4] Extracting platform-tools...
tar.exe -xf "%ZIP_FILE%" -C "%INSTALL_DIR%" --strip-components=1
if %errorlevel% neq 0 (
    echo [ERROR] Extraction failed.
    del /f /q "%ZIP_FILE%" >nul 2>&1
    pause
    exit /b 1
)

:: Clean up temporary archive
del /f /q "%ZIP_FILE%" >nul 2>&1

:: 5. Safely add C:\adb to System PATH without string truncation or duplicates
echo [4/4] Configuring System PATH...
powershell -NoProfile -ExecutionPolicy Bypass -Command ^
    "$p = [Environment]::GetEnvironmentVariable('Path', 'Machine'); if ($p -notlike '*C:\adb*') { [Environment]::SetEnvironmentVariable('Path', ($p.TrimEnd(';') + ';C:\adb'), 'Machine') }"

echo.
echo ===================================================
echo  Installation completed successfully!
echo  ADB is installed at: %INSTALL_DIR%
echo ===================================================
echo.
echo Open a NEW PowerShell or Command Prompt window to use 'adb'.
:: Also update PATH for this current CMD instance if run directly
set "PATH=%PATH%;%INSTALL_DIR%"

echo.
echo Launching a ready-to-use terminal...
start powershell -NoExit -Command "Write-Host '=== ADB Environment Ready ===' -ForegroundColor Green; adb version"
pause
