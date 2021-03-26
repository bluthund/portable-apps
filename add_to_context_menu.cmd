@echo off
color 0c
title Appwriter
openfiles > NUL 2>&1
if errorlevel 1 (
 echo\ && echo ERROR: Please run with elevated permissions. This script will now exit.
 pause
 exit /b 1
)
color 0e && echo/ && echo This script adds launchers for portable apps into the folder background context menu.
set /p portPath=Portable apps path: 
cls && echo/
chcp 65001 > nul
setlocal enabledelayedexpansion
cd /d %portPath%

echo INDEX ITEM/HEADER
reg add "HKCR\Directory\Background\shell\app-" /v MUIVerb /t REG_SZ /d "Portables" /f
reg add "HKCR\Directory\Background\shell\app-" /v Icon /t REG_SZ /d "%systemroot%\System32\shell32.dll,80" /f
reg add "HKCR\Directory\Background\shell\app-" /v SeparatorBefore /t REG_SZ /d "" /f
reg add "HKCR\Directory\Background\shell\app-\command" /ve /t REG_SZ /d "explorer.exe !portPath!" /f
echo ___________________________ && echo/

set /a appCount = 0
for /D %%G in ("*") do (
 cd /d %%G
 set vbsName=
 set appName=%%G
 set /a "menuCount=appCount/16"
 set /a appCount+=1
 set /a vbsCount=0
 
 for /f "tokens=2 delims==" %%i in ('findstr /C:"LocalizedResourceName=" desktop.ini') do set appName=%%i
 for /f "tokens=2 delims==" %%i in ('findstr /C:"IconResource=" desktop.ini') do set iconPath=%%i
 call set iconPath=%%iconPath:.\=%cd%\%%G\%%

 for /f %%i in ('dir /b *.vbs') do (call set vbsName=!vbsName! %%i)
 for %%a in (!vbsName!) do (
  set vector[!vbsCount!]=%%a
  set /a vbsCount+=1
 )

 call echo APP[%%appCount%%]: %%appName%%
 call echo ICONPATH: %%iconPath%%

 if !vbsCount! GTR 1 (echo/
  set /a vbsCount-=1
  for /l %%i in (0,1,!vbsCount!) do (
   echo [%%i]: !vector[%%i]!
  )
  set /a selVbs=0
  set /p selVbs=Select VBS file: 
  set vbsName=%%vector[!selVbs!]%%
  echo/
 )
 for /f "tokens=* delims= " %%i in ("!vbsName!") do set vbsName=%%i
 call echo VBSNAME: !vbsName!

 set /a "menuItem0=appCount%%16"
 if !menuItem0!==1 (reg delete "HKCR\Directory\Background\shell\app!menuCount!" /f > nul && set menuLabel=!appName!)

 call echo/
 call echo Writing registry entries...
 call reg add "HKCR\Directory\Background\shell\app%%menuCount%%" /v MUIVerb /t REG_SZ /d "●   %%menuLabel%% to %%appName%%" /f > NUL 2>&1
 call reg add "HKCR\Directory\Background\shell\app%%menuCount%%" /v SubCommands /t REG_SZ /d "" /f > NUL 2>&1
 call reg add "HKCR\Directory\Background\shell\app%%menuCount%%" /ve /t REG_SZ /d "" /f > NUL 2>&1
 call reg add "HKCR\Directory\Background\shell\app%%menuCount%%\shell\%%appName%%" /v MUIVerb /t REG_SZ /d "%%appName%%" /f > NUL 2>&1
 call reg add "HKCR\Directory\Background\shell\app%%menuCount%%\shell\%%appName%%" /v Icon /t REG_SZ /d "%%iconPath%%" /f > NUL 2>&1
 call reg add "HKCR\Directory\Background\shell\app%%menuCount%%\shell\%%appName%%\command" /ve /t REG_SZ /d "wscript.exe \"%cd%\%%G\!vbsName!\"" /f > NUL 2>&1
 call echo ___________________________
 echo/
 cd..
)
echo All done!
pause