set w = CreateObject("WScript.Shell")
w.CurrentDirectory = CreateObject("Scripting.FileSystemObject").GetParentFolderName(WScript.ScriptFullName) + "\bin"
Dim statusCode
statusCode = w.Run ("ARen.exe",1,false)