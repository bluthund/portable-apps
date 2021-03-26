Set pathObj = CreateObject("WScript.Shell")
pathObj.CurrentDirectory = CreateObject("Scripting.FileSystemObject").GetParentFolderName(WScript.ScriptFullName)
pathObj.Run "java -jar " + """.\bin\Gif2Boot.jar""",0,false