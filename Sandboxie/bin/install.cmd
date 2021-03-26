@echo on
setlocal enabledelayedexpansion
if exist "%PROGRAMFILES(X86)%" (cd /d "%~dp0x64") else (cd /d "%~dp0x86")

kmdutil stop SbieSvc
kmdutil stop SbieDrv

kmdutil /lang=1033 scandll
kmdutil /lang=1033 stop SbieSvc
kmdutil /lang=1033 stop SbieDrv
kmdutil delete SbieSvc
kmdutil delete SbieDrv
tar -xf SbieDrv.sys.tar
kmdutil /lang=1033 install SbieDrv "%cd%\SbieDrv.sys" type=kernel start=demand "msgfile=%cd%\SbieMsg.dll" altitude=86900
kmdutil /lang=1033 install SbieSvc "\"%cd%\SbieSvc.exe"\" type=own start=auto "display=Sandboxie Service" group=UIGroup "msgfile=%cd%\SbieMsg.dll"

reg add "HKCR\*\shell\sandbox" /f /ve /d "Run &Sandboxed"
reg add "HKCR\*\shell\sandbox" /f /v Icon /t REG_SZ /d "!cd!\Start.exe"
reg add "HKCR\*\shell\sandbox\command" /f /ve /d "\"!cd!\Start.exe\" /box:__ask__ \"%%1\" %%*"
reg add "HKCR\Directory\shell\sandbox" /f /ve /d "Run &Sandboxed"
reg add "HKCR\Directory\shell\sandbox" /f /v Icon /t REG_SZ /d "!cd!\Start.exe"
reg add "HKCR\Directory\shell\sandbox\command" /f /ve /d "\"!cd!\Start.exe\" /box:__ask__ \"%%1\" %%*"
reg add "HKLM\SYSTEM\CurrentControlSet\Services\SbieSvc" /f /v PreferExternalManifest /t REG_DWORD /d 0x00000001

copy /y "%~dp0..\data\Sandboxie.ini" "%systemroot%"
copy /y "%~dp0..\data\Sandboxie.ini" "%cd%"
kmdutil /lang=1033 start SbieSvc
"%~dp0launch.cmd"