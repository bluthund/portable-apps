@echo off
taskkill /f /im SbieCtrl.exe
if exist "%PROGRAMFILES(X86)%" (cd /d "%~dp0x64") else (cd /d "%~dp0x64")
start "" "%cd%\SbieCtrl.exe"
exit