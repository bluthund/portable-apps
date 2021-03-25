Set pathObj = CreateObject("Shell.Application")
curPath = CreateObject("Scripting.FileSystemObject").GetParentFolderName(WScript.ScriptFullName) + "\bin"
pathObj.ShellExecute curPath + "\launch.cmd",,,"runas",0