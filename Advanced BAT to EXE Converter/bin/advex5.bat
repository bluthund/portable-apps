@echo off
mode con:cols=80 lines=25
REM ADVANCED batch file: LaunchSilent example
rem Launches NotePad completely silent in the backround
rem with no options and do not wait for it to finish
rem before exiting. Close with Task Manager.
rem 
rem Some applications may open a second dialog that
rem will not remain hidden. Use the HideWindow
rem extended command example to solve this problem.
echo: Launching Notepad in backround...
rem LaunchSilent notepad.exe "" 0
cls
