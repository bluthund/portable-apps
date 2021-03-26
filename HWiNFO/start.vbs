x86Exec = "HWiNFO32.exe"
x64Exec = "HWiNFO64.exe"
x86Path = "\bin"
x64Path = "\bin"
x86Args = ""
x64Args = ""

Set pathObj = CreateObject("WScript.Shell")
osArch = pathObj.RegRead("HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Environment\PROCESSOR_ARCHITECTURE")
On Error Resume Next
If osArch = "x86" Then
	pathObj.CurrentDirectory = CreateObject("Scripting.FileSystemObject").GetParentFolderName(WScript.ScriptFullName) + x86Path
    RunApp = pathObj.Run(x86Exec + Space(1) + x86Args,1,false)
ElseIf osArch = "AMD64" Then
	pathObj.CurrentDirectory = CreateObject("Scripting.FileSystemObject").GetParentFolderName(WScript.ScriptFullName) + x64Path
    RunApp = pathObj.Run(x64Exec + Space(1) + x64Args,1,false)
End If