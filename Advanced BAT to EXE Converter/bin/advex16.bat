@echo off
mode con:cols=80 lines=25
REM "rem HideWindow" extended command example.
REM 
REM This script will launch Notepad.exe then wait 2 seconds.
REM Next, the batch file will hide the application
REM window and make it visible 2 seconds later.
REM The script finishes by closing the window.
REM 
REM Most of the time you will want to start your application with
REM the LaunchSilent command.
REM 
REM Some applications will not work since they start a second dialog
REM that does not stay invisible. In this case, you will want to
REM launch the application minimized, wait 250ms for the program to load 
REM then use the HideWindow extended command to keep it invisible.
echo:
echo:Launching Notepad.exe
REM start /MIN %windir%\Notepad.exe
start %windir%\Notepad.exe
rem You have to give the application some time to load before attempting
rem to hide it. 250 milliseconds is more than enough time but I went with
rem 2000ms for this example just to show how it works.
rem Wait 2000
echo:Hiding the application window
rem HideWindow "Untitled - Notepad"
rem Wait 2000
echo:Making the application visible again
rem ShowWindow "Untitled - Notepad"
rem Wait 2000
rem CloseWindow "Untitled - Notepad"
cls


