# Systemwide ADB & Fastboot Installer for Windows

A lightweight, automated batch script to install the latest official Android SDK Platform-Tools (ADB & Fastboot) and add them to your Windows system `PATH` for universal access across any terminal.

---

## Quick Install (One-Liner)

Run the script directly via **Command Prompt** or **PowerShell / Windows Terminal** without manually downloading zip files or modifying environment variables.

### Instructions

1. Open **Command Prompt** or **Windows Terminal** as **Administrator** (Right-click → *Run as administrator*).
2. Paste and run the command below:

```cmd
curl -o "%USERPROFILE%\Downloads\adb_installer.bat" [https://raw.githubusercontent.com/hv33y/systemwide-adb-installer/main/adb_installer.bat](https://raw.githubusercontent.com/hv33y/systemwide-adb-installer/main/adb_installer.bat) && "%USERPROFILE%\Downloads\adb_installer.bat"
```

## Features

- **Automated Download:** Fetches the latest official Android platform tools package.
- **Systemwide Access:** Automatically appends the installation folder to your Windows system `PATH`.
- **Zero Configuration:** No manual unzipping, moving folders, or editing environment variables in Advanced System Settings.
- **Clean Execution:** Runs through a single batch file and handles cleanup.

## Verification

Once the installation finishes, open a new Command Prompt or PowerShell window (non-admin is fine) and verify the setup:

```sh
adb --version
fastboot --version
```

If configured properly, the active version numbers for ADB and Fastboot will be displayed.

## Manual Installation
If you prefer to review or run the script manually:
1. Download [adb_installer.bat](https://raw.githubusercontent.com/hv33y/systemwide-adb-installer/main/adb_installer.bat).
2. Right-click the file and select **Run as administrator**.
3. Follow the on-screen prompts to complete the setup.

## License
This project is licensed under the [MIT License](LICENSE).
