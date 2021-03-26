x86Exec = "HxD32.exe"
x64Exec = "HxD64.exe"
x86Path = "\bin"
x64Path = "\bin"

Set pathObj = CreateObject("WScript.Shell")
osArch = pathObj.RegRead("HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Environment\PROCESSOR_ARCHITECTURE")
If osArch = "x86" Then
	pathObj.CurrentDirectory = CreateObject("Scripting.FileSystemObject").GetParentFolderName(WScript.ScriptFullName) + x86Path
    RunApp = pathObj.Run(x86Exec,1,false)
ElseIf osArch = "AMD64" Then
	pathObj.CurrentDirectory = CreateObject("Scripting.FileSystemObject").GetParentFolderName(WScript.ScriptFullName) + x64Path
    RunApp = pathObj.Run(x64Exec,1,false)
End If