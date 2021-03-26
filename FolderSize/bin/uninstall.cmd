taskkill /f /im "FolderSize.exe"
sc stop "FolderSize"
sc delete "FolderSize"
reg delete "HKCR\Directory\shell\foldersize" /f
reg delete "HKCR\Directory\background\shell\foldersize" /f