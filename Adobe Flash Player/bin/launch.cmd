@echo off
cd /d "%~dp0"

mkdir "%appdata%\Adobe"
rmdir /s /q "%appdata%\Adobe\Flash Player"
mklink /J "%appdata%\Adobe\Flash Player" "%~dp0..\data\caches"

mkdir "%appdata%\Macromedia"
rmdir /s /q "%appdata%\Macromedia\Flash Player"
mklink /J "%appdata%\Macromedia\Flash Player" "%~dp0..\data\caches"

start /w "" fp32.exe

rmdir /s /q "%appdata%\Adobe\Flash Player"
rmdir "%appdata%\Adobe"

rmdir /s /q "%appdata%\Macromedia\Flash Player"
rmdir "%appdata%\Macromedia"

exit