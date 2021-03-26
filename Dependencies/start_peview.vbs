Set pathObj = CreateObject("WScript.Shell")
pathObj.CurrentDirectory = CreateObject("Scripting.FileSystemObject").GetParentFolderName(WScript.ScriptFullName) + "\bin"
RunApp = pathObj.Run(".\launch_peview.cmd",0,false)