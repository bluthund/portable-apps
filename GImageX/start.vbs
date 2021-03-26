set w = CreateObject("WScript.Shell")
w.CurrentDirectory = CreateObject("Scripting.FileSystemObject").GetParentFolderName(WScript.ScriptFullName)
W.Run chr(34) & "bin\launch.cmd" & chr(34), 0
set w= Nothing