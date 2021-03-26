@echo off
cd /d "%~dp0"
if exist "%PROGRAMFILES(X86)%" (start "" "%cd%\gix64.exe") else (start "" "%cd%\gix86.exe")
