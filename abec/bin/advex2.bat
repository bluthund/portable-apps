@echo off
REM ADVANCED batch file: Random Stars Example 
mode con:cols=80 lines=25
rem CenterSelf
rem PrintCenter Enter a Number (15 to 50): 12 10 9
rem GetInput
rem MakeInteger %result%
set myNumStarsVar=%result%
REM Keep variable in proper range (15 to 50)
REM This will return a 1 if entered number is greater than
REM or equal to 50
rem GreaterThan %myNumStarsVar% 50
if %result%==1 set myNumStarsVar=50
rem LessThan %myNumStarsVar% 15
REM This returns a 1 if entered number is less than or equal to 15
if %result%==1 set myNumStarsVar=15
cls
set myAddVar=0
rem CursorHide
:TestLoop
rem Add %myAddVar% 1
set myAddVar=%result%
REM Set a random color
rem GenRandom 15
set myColor=%result%
REM Batch file windows are 25 by 80 spaces
rem GenRandom 24
set myYVar=%result%
rem GenRandom 80
set myXVar=%result%
REM Print the X with white backround and wait 20miliseconds
REM then print black backround for twinkle effect
rem PrintColorAt x %myYVar% %myXVar% %myColor% 15
rem Wait 20
rem PrintColorAt X %myYVar% %myXVar% %myColor% 0
rem PrintCenter %myAddVar% of %myNumStarsVar% 12 10 9
rem GetPercent %myAddVar% %myNumStarsVar%
set mPercent=%result%
rem LocateAt 13 38
rem ChangeColor 12 0
echo %mPercent%%%
if  %myAddVar%==%myNumStarsVar% goto Finish
goto TestLoop
:Finish
rem CursorShow
rem Locate 24 1
pause
REM Clear screen and close window
cls
