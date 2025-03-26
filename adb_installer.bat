@echo off
setlocal EnableDelayedExpansion

echo Checking for Administrator privileges...
net session >nul 2>&1
if %errorLevel% neq 0 (
    echo Requesting administrative privileges...
    powershell -Command "Start-Process cmd -ArgumentList '/c "%~f0"' -Verb RunAs"
    exit /b
)

title ADB SYSTEM INSTALLER

echo Downloading ADB...
set "DownloadDestinationADB=%~dp0platform-tools-latest-windows.zip"
set "UnzipDestinationADB=%~dp0platform-tools-latest-windows"
set "sourceDirectory=%~dp0ADB"
set "url=https://dl.google.com/android/repository/platform-tools-latest-windows.zip"

powershell -Command "(New-Object System.Net.WebClient).DownloadFile('%url%', '%DownloadDestinationADB%')"

echo Unzipping and Copying...
powershell -Command "Expand-Archive -Path '%DownloadDestinationADB%' -DestinationPath '%UnzipDestinationADB%'"
set "sourceDirectory=%~dp0platform-tools-latest-windows\platform-tools"
set "destinationDirectory=%~dp0ADB"

if exist "%destinationDirectory%" rd /s /q "%destinationDirectory%"
xcopy /E /Y "%sourceDirectory%" "%destinationDirectory%"

echo Cleaning up...
del /f /q "%DownloadDestinationADB%"
rd /s /q "%UnzipDestinationADB%"

:: Adding ADB to system PATH
for /f "tokens=2* delims= " %%A in ('reg query "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Environment" /v Path') do set "oldPath=%%B"
set "newPath=!oldPath!;%destinationDirectory%"
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Environment" /v Path /t REG_EXPAND_SZ /d "!newPath!" /f

echo Completed Installing ADB systemwide.
echo Launch Windows Terminal/Powershell/Command Prompt to use ADB.
pause
