@echo off
mode con:cols=80 lines=25
REM ADVANCED batch file: Simple Math
rem PrintCenter Simple Math Calculations 1 10 9
echo:
echo:
rem Divide 25 3.1
echo:testing Divide command: 25 / 3.1 = %result%
rem LimitDecimal %result% 2
echo:testing LimitDecimal command 2 spaces: %result%
rem Color text just for fun
rem MakeInteger %result%
rem PrintColor testing MakeInteger command: 14 0
rem PrintSpace
rem PrintColor %result% 12 0
rem PrintReturn
echo:
pause
cls
