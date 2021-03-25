@echo off
mode con:cols=80 lines=25
REM This ADVANCED batch file will count the number of times it was
REM ran and display the number on the screen.
REM 
REM %MYFILES% is a directory where you have write permissions to
REM create files even if not ran "as administrator"
if exist "%MYFILES%\setvar.bat" call "%MYFILES%\setvar.bat"
if "%svdvar%"=="" set svdvar=0
rem Add %svdvar% 1
set svdvar=%result%
echo:
rem PrintCenter This batch file has ran %svdvar% time(s) 12 2 4
echo:
REM Save the variable in a batch file that will be ran next time
echo:set svdvar=%svdvar% >"%MYFILES%\setvar.bat"
REM Now wait 3 seconds and close the window
rem Wait 3000
cls


