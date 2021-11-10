@echo off
setlocal enabledelayedexpansion
cd /d "%~dp0"
set /a EXITVAR= 0

:uninstall
reg query HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall /f "ViGEm Bus Driver" /s
if %ERRORLEVEL%==1 (goto install)
"%cd%\drivers\HidCerberus.Srv\HidCerberus.Srv.exe" uninstall
"%cd%\drivers\devcon.exe" remove Root\HidGuardian
"%cd%\drivers\devcon.exe" classfilter HIDClass upper !HidGuardian
goto msiuninstall

:msiuninstall
set cmdEcho= reg query HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall /f "ViGEm Bus Driver" /s
set /a lineNo= 1
for /f "tokens=*" %%A in ('%cmdEcho%') do (
  set /a counter+=1 && if !counter! EQU %lineNo% (
    set lineOut=%%A
    goto msicall
  )
)

:msicall
set /a counter=0
set /a lineNo=2
set /a wordNo=4
set cmdEcho= reg query %lineOut% /f "MsiExec.exe" /s
reg query %lineOut% /f "MsiExec.exe" /s
for /f "tokens=*" %%A in ('%cmdEcho%') do (
  set /a counter+=1 && if !counter! EQU %lineNo% (
    set lineOut=%%A
    for /f "tokens=%wordNo%" %%i in ("!lineOut!") do set "uninstStr=%%i /qb"
  )
)
wscript.exe "%~dp0..\start.vbs" "%uninstStr%"
goto install

:install
if %EXITVAR%==1 (exit)
start "" "%cd%\drivers\vigembus.exe" APPDIR="%PROGRAMFILES%\ViGEmBus" /qn
"%cd%\drivers\devcon.exe" install "%cd%\drivers\HidGuardian\HidGuardian.inf" Root\HidGuardian
"%cd%\drivers\devcon.exe" classfilter HIDClass upper -HidGuardian
"%cd%\drivers\HidCerberus.Srv\HidCerberus.Srv.exe" install
ping 127.0.0.1 -n 2 > nul
net start "HidCerberus Service"
ping 127.0.0.1 -n 2 > nul

:launch
start /w "" "%cd%\BetterJoyForCemu.exe"
set /a EXITVAR= 1 & goto uninstall



