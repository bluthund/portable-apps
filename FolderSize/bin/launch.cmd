set osArch=%1
cd /d "%~dp0%osArch%"
sc create "FolderSize" binPath="%cd%\FolderSizeSvc.exe" start=auto
reg add "HKCR\Directory\shell\foldersize" /ve /t REG_SZ /d "Show folder sizes" /f
reg add "HKCR\Directory\shell\foldersize" /v SeparatorBefore /t REG_SZ /d "" /f
reg add "HKCR\Directory\shell\foldersize" /v SeparatorAfter /t REG_SZ /d "" /f
reg add "HKCR\Directory\shell\foldersize\command" /ve /t REG_SZ /d "%cd%\FolderSize.exe" /f
reg add "HKCR\Directory\background\shell\foldersize" /ve /t REG_SZ /d "Show folder sizes" /f
reg add "HKCR\Directory\background\shell\foldersize" /v SeparatorBefore /t REG_SZ /d "" /f
reg add "HKCR\Directory\background\shell\foldersize" /v SeparatorAfter /t REG_SZ /d "" /f
reg add "HKCR\Directory\background\shell\foldersize\command" /ve /t REG_SZ /d "%cd%\FolderSize.exe" /f
sc start "FolderSize"
start /w "" "%cd%\FolderSize.exe"
wscript.exe "%~dp0..\start.vbs" "%~dp0uninstall.cmd"