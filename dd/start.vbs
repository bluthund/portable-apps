Set pathObj = CreateObject("Shell.Application")
curPath = CreateObject("Scripting.FileSystemObject").GetParentFolderName(WScript.ScriptFullName)
pathObj.ShellExecute curPath + "\bin\launch.cmd",,,"runas",0