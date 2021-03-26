@echo on
cd /d "%~dp0"

rmdir /s /q "%appdata%\Namexif"
mklink /j "%appdata%\Namexif" "%cd%\..\data"

start /w "" Namexif.exe

rmdir /s /q "%appdata%\Namexif"
exit