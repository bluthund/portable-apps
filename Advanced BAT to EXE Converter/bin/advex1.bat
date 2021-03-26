@echo off
REM - MouseCMD Menu example
mode con:cols=80 lines=25
rem CenterSelf
:MenuBG
set BGcol=1
set BGcheck=[X]
rem ChangeColor 7 %BGcol%
cls
:Menu
rem Paintscreen %BGcol%
rem ChangeColor 7 %BGcol%
rem PrintBox 20 44 2
rem PrintBox 16 38 %BGcol%
rem PrintCenter Main Menu 7 11 %BGcol%
rem ChangeColor 9 0
rem Locate 10 32
rem PrintColor 1) Hide 3 seconds 11 %BGcol%
rem Locate 12 32
rem PrintColor 2) Random Test 11 %BGcol%
rem Locate 14 32
rem PrintColor 3) Exit 11 %BGcol%
rem PrintCenter %BGcheck% Draw Background color 17 15 %BGcol%
rem ChangeColor 10 %BGcol%
rem MouseCMD 32,10,48,10 32,12,45,12 32,14,38,14 29,17,29,17
if %result%==1 goto HideTest
if %result%==2 goto RandomTest
if %result%==3 goto EndTest
if %result%==4 goto ClearBG
REM Keep Menu if invalid input
goto Menu

:ClearBG
if %BGcol%==0 goto MenuBG
set BGcol=0
set BGcheck=[ ]
rem ChangeColor 7 %BGcol%
cls
goto Menu



:HideTest
rem Locate 10 32
rem PrintColor 1) Hide 3 seconds 11 15
rem Wait 200
rem HideSelf
cls
rem Wait 3000
rem ShowSelf
goto Menu

:RandomTest
rem Locate 12 32
rem PrintColor 2) Random Test 11 15
rem Wait 200
set myAddVar=0
:TestLoop
cls
rem Add %myAddVar% 1
set myAddVar=%result%
rem GenRandom 15
rem PaintScreen %result% 
rem PrintCenter Color=%result% ( %myAddVar% of 10 ) 12 15 %result%
rem Wait 400
if %myAddVar%==10 goto Menu
goto TestLoop



:EndTest
rem Locate 14 32
rem PrintColor 3) Exit 11 15
rem Wait 200
rem Paintscreen 1
rem ChangeColor 7 1
rem PrintBox 16 36 2
rem Wait 25
cls
rem PrintBox 12 28 2
rem Wait 25
cls
rem PrintBox 8 20 1
rem Wait 25
cls
rem PrintBox 4 12 1
rem Wait 25
cls


