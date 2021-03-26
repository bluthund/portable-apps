set wa = CreateObject("Shell.Application")
set w = CreateObject("WScript.Shell")
w.CurrentDirectory = CreateObject("Scripting.FileSystemObject").GetParentFolderName(WScript.ScriptFullName) + "\bin"
wa.ShellExecute "e2e.exe", , , "runas", 1
