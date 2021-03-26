@echo off
if exist "%PROGRAMFILES(x86)%" (cd /d "%~dp0x64") else (cd /d "%~dp0x86")
scrcpy.exe
taskkill /f /im adb.exe
exit