@echo on
if exist "%PROGRAMFILES(x86)%" (cd /d "%~dp0x86") else (cd /d "%~dp0x86")

tar -xf peview.tar
start /w "" peview.exe

del /f /q peview.exe
exit