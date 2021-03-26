@echo off
cd /d "%~dp0bin"
start "" "cmd.exe" /k "set path=%cd%;%path% && cd /d "%~dp0" && color 0e && title gptgen && @echo off && echo\ && gptgen && @echo on"