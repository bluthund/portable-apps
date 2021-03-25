@echo off
mode con:cols=80 lines=25
REM This will keep anyone from opening NOTEPAD for example
REM They can open .TXT files because the window title changes
REM This example is only meant to show proof of concept.
REM 
REM Replace the TEXT in the quotes below to stop a network share
REM folder or another disallowed program from running.
REM 
REM This advanced batch file should be compiled as INVISIBLE
REM in the Select EXE Options dialog when you push BUILD EXE
REM 
REM The Wait advanced command prevents high CPU usage from
REM the goto LOOP
REM Close this program from the Windows Task Manager
REM 
:begin
rem CloseWindow "Untitled - Notepad"
rem Wait 500
goto begin
