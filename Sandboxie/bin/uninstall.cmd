@echo off
setlocal enabledelayedexpansion
if exist "%PROGRAMFILES(X86)%" (cd /d "%~dp0x64") else (cd /d "%~dp0x86")

kmdutil stop SbieSvc
kmdutil stop SbieDrv
kmdutil delete SbieSvc
kmdutil delete SbieDrv

reg delete "HKEY_CLASSES_ROOT\*\shell\sandbox" /f
reg delete "HKEY_CLASSES_ROOT\Directory\shell\sandbox" /f
reg delete "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\SbieSvc" /f

for /f %%A in ('wmic useraccount where name^="%username%" get sid') do (set /a counter+=1 && if !counter! EQU 2 (set SID=%%A&&goto LoopExit))
:LoopExit
reg delete "HKEY_USERS\%SID%\Software\Classes\Folder\shell\sandbox" /f

copy /y "%cd%\Sandboxie.ini" "%~dp0..\data"
del /f /q "%cd%\Sandboxie.ini"
del /f /q "%systemroot%\Sandboxie.ini"
del /f /q "%appdata%\Microsoft\Windows\SendTo\Sandboxie*.lnk"
del /f /q "%cd%\SbieDrv.sys"
exit