set pathObj = CreateObject("WScript.Shell")
pathObj.CurrentDirectory = CreateObject("Scripting.FileSystemObject").GetParentFolderName(WScript.ScriptFullName) + "\bin"
pathObj.Run """gopher360.exe""",1,false