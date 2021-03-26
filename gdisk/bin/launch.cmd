@echo off
cd /d "%~dp0"
if exist "%PROGRAMFILES(X86)%" (start "" "%cd%\gdisk64.exe") else (start "" "%cd%\gdisk32.exe")
