@echo on
if exist "%PROGRAMFILES(x86)%" (cd /d "%~dp0x64") else (cd /d "%~dp0x86")

rmdir /s /q "%localappdata%\Dependencies"
rem start "" wscript.exe "%~dp0..\start.vbs" "%cd%\DependenciesGui.exe"
start "" "%cd%\DependenciesGui.exe"

:Waiter
tasklist /FI "IMAGENAME eq DependenciesGui.exe" 2>NUL | find /I /N "DependenciesGui.exe" >NUL
ping -n 2 127.0.0.1 >NUL
if "%ERRORLEVEL%"=="1" (goto Waiter) else (taskkill /im DependenciesGui.exe)

for /f %%i in ('dir /b %localappdata%\Dependencies\DependenciesGui.exe_Url_*') do (set datadir=%%i)
rmdir /s /q "%localappdata%\Dependencies\%datadir%\1.10.0.0"
mklink /j "%localappdata%\Dependencies\%datadir%\1.10.0.0" "%~dp0..\data"

tar -xf peview.tar
start /w "" DependenciesGui.exe

rmdir /s /q "%localappdata%\Dependencies"
del /f /q peview.exe
exit