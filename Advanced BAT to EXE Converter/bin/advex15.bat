@echo off
REM Detect 32bit or 64bit Operating System
REM ###NOTE - requires compile with Admin Manifest
REM #
REM #####
REM For best compatibility with all versions of Windows,
REM you should always compile batch files to 32bit Windows EXE.
REM Advanced BAT to EXE Converter always compiles to 32bit EXE.
REM You may find that you want to run 64bit commands from your 32bit EXE.
REM This example batch file will help accomplish this.
REM #####
if exist "%SystemRoot%\Sysnative\" goto Wind64
echo:Currently running on 32bit Windows
goto ENDPROG
:Wind64
echo:Currently running on 64bit Windows
echo:Windows will attempt to run 32bit commands from this 32bit EXE
echo:You can run 64bit commands by Changing Directory to 64bit System folder
REM Remove "REM " from line below to CD to 64bit System folder and use those commands.
REM CD "%SystemRoot%\Sysnative\"
REM Insert 64bit commands here
goto ENDPROG
:ENDPROG
pause
cls