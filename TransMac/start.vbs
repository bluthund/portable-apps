set w = CreateObject("WScript.Shell")
w.CurrentDirectory = CreateObject("Scripting.FileSystemObject").GetParentFolderName(WScript.ScriptFullName) + "\bin"
Dim statusCode
statusCode = w.Run ("TransMac.exe",1,true)