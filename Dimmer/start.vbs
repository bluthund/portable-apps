set w = CreateObject("WScript.Shell")
w.CurrentDirectory = CreateObject("Scripting.FileSystemObject").GetParentFolderName(WScript.ScriptFullName)
W.Run chr(34) & "bin\Dimmer.exe" & chr(34), 0
set w= Nothing