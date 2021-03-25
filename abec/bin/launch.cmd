cd /d "%~dp0"
regsvr32 /s richtx32.ocx
start /w "" aB2Econv.exe
regsvr32 /s /u richtx32.ocx
exit