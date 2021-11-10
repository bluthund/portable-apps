If WScript.Arguments.Count < 1 Then
  Set pathObj = CreateObject("WScript.Shell")
  pathObj.CurrentDirectory = CreateObject("Scripting.FileSystemObject").GetParentFolderName(WScript.ScriptFullName) + "\bin"
  RunApp = CreateObject("Shell.Application").ShellExecute("""" + pathObj.CurrentDirectory + "\launch.cmd""",,,"runas",0)
Else
  RunApp = CreateObject("Shell.Application").ShellExecute("MsiExec.exe",WScript.Arguments.Item(0),,"runas",0)
End If