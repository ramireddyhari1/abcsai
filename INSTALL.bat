@echo off
REM ============================================================
REM Anantapur Book Center - Discount Calculator Installer
REM ============================================================

setlocal enabledelayedexpansion

REM Check for admin privileges
net session >nul 2>&1
if %errorLevel% neq 0 (
    echo.
    echo This installer requires administrator privileges.
    echo Please run this script as Administrator.
    echo.
    pause
    exit /b 1
)

echo.
echo ============================================================
echo Anantapur Book Center - Discount Calculator
echo Installation Starting...
echo ============================================================
echo.

REM Set installation directory
set "INSTALL_DIR=%ProgramFiles%\Anantapur Book Center\Discount Calculator"

REM Create installation directory
echo Creating installation directory...
if not exist "!INSTALL_DIR!" (
    mkdir "!INSTALL_DIR!"
    if errorlevel 1 (
        echo Error creating directory. Installation failed.
        pause
        exit /b 1
    )
)

REM Copy application files
echo Copying application files...
xcopy /E /I /Y "%~dp0release-builds\discount-calculater-win32-x64\*" "!INSTALL_DIR!\" >nul
if errorlevel 1 (
    echo Error copying files. Installation failed.
    pause
    exit /b 1
)

REM Create Desktop Shortcut
echo Creating Desktop shortcut...
powershell -Command "$WshShell = New-Object -ComObject WScript.Shell; $Shortcut = $WshShell.CreateShortcut([System.Environment]::GetFolderPath('Desktop') + '\Anantapur Book Center - Discount Calculator.lnk'); $Shortcut.TargetPath = '!INSTALL_DIR!\discount-calculater.exe'; $Shortcut.WorkingDirectory = '!INSTALL_DIR!'; $Shortcut.IconLocation = '!INSTALL_DIR!\discount-calculater.exe'; $Shortcut.Description = 'Anantapur Book Center - Professional Discount Calculator'; $Shortcut.Save()" 2>nul

REM Create Start Menu Shortcut
echo Creating Start Menu shortcut...
set "START_MENU=%APPDATA%\Microsoft\Windows\Start Menu\Programs"
powershell -Command "$WshShell = New-Object -ComObject WScript.Shell; $Shortcut = $WshShell.CreateShortcut('!START_MENU!\Anantapur Book Center - Discount Calculator.lnk'); $Shortcut.TargetPath = '!INSTALL_DIR!\discount-calculater.exe'; $Shortcut.WorkingDirectory = '!INSTALL_DIR!'; $Shortcut.IconLocation = '!INSTALL_DIR!\discount-calculater.exe'; $Shortcut.Description = 'Anantapur Book Center - Professional Discount Calculator'; $Shortcut.Save()" 2>nul

REM Create uninstaller batch file
echo Creating uninstaller...
(
    echo @echo off
    echo setlocal enabledelayedexpansion
    echo.
    echo net session >nul 2>&1
    echo if %%errorLevel%% neq 0 (
    echo     echo This uninstaller requires administrator privileges.
    echo     pause
    echo     exit /b 1
    echo ^)
    echo.
    echo set "INSTALL_DIR=!INSTALL_DIR!"
    echo.
    echo echo Uninstalling Anantapur Book Center - Discount Calculator...
    echo rmdir /S /Q "!INSTALL_DIR!"
    echo del "%%APPDATA%%\Microsoft\Windows\Start Menu\Programs\Anantapur Book Center - Discount Calculator.lnk"
    echo del "%%USERPROFILE%%\Desktop\Anantapur Book Center - Discount Calculator.lnk"
    echo echo Uninstallation complete.
    echo pause
) > "!INSTALL_DIR!\Uninstall.bat"

echo.
echo ============================================================
echo Installation Complete!
echo ============================================================
echo.
echo Application installed to:
echo !INSTALL_DIR!
echo.
echo Shortcuts created on:
echo - Desktop
echo - Start Menu
echo.
echo You can now launch the application from:
echo - Desktop shortcut
echo - Start Menu
echo - File: !INSTALL_DIR!\discount-calculater.exe
echo.
pause
