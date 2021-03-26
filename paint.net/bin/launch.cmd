@echo off
cd /d "%~dp0"

rmdir /s /q "%localappdata%\paint.net"
mklink /J "%localappdata%\paint.net" "%cd%\..\data"

start /w "" PaintDotNet.exe

rmdir /s /q "%localappdata%\paint.net"

exit