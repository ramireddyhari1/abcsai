@echo off
cd /d "%~dp0"
set CSC_IDENTITY_AUTO_DISCOVERY=false
set WIN_CSC_KEY_PASSWORD=
call npm run build:win
pause
