@echo off
REM ============================================================
REM Quick Test - Run the Discount Calculator
REM ============================================================

echo Starting Anantapur Book Center - Discount Calculator...
echo.

set "APP_PATH=%~dp0release-builds\discount-calculater-win32-x64\discount-calculater.exe"

if exist "!APP_PATH!" (
    start "" "!APP_PATH!"
    echo Application launched successfully!
    echo.
    timeout /t 2
) else (
    echo Error: Application not found at:
    echo !APP_PATH!
    echo.
    echo Please ensure you have run: npm run package:win
    echo.
    pause
)
