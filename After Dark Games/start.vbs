set pathObj = CreateObject("WScript.Shell")
pathObj.CurrentDirectory = CreateObject("Scripting.FileSystemObject").GetParentFolderName(WScript.ScriptFullName)
pathObj.Run """.\bin\adg.exe""",1,false