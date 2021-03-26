@echo off
mode con:cols=80 lines=25
REM ADVANCED batch file: Displays color values for use with the extended commands
rem PrintColor Color Number Values: 1 2
rem PrintReturn
echo:
echo:
echo:
set myAddVar=0
:LoopStart
rem Add %myAddVar% 1
set myAddVar=%result%
rem PrintSpace
rem PrintColor %myAddVar% 0 %myAddVar%
rem PrintSpace
rem PrintColor %myAddVar% %myAddVar% 0
rem PrintReturn
if %myAddVar%==15 goto EndLoop
goto LoopStart
:EndLoop
pause
cls


