@echo off
if exist "%PROGRAMFILES(X86)%" (set path="%~dp0x64";%path%) else (set path="%~dp0x86";%path%)
start "" "cmd.exe" /k "cd /d "%cd%" && color 0e && title TCC && echo\ && tcc && echo\"