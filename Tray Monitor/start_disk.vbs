Set pathObj = CreateObject("WScript.Shell")
pathObj.CurrentDirectory = CreateObject("Scripting.FileSystemObject").GetParentFolderName(WScript.ScriptFullName) + "\data"
runApp = pathObj.Run("..\bin\disk.exe",1,false)