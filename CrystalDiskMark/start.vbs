x86Exec = "\bin\DiskMark32.exe"
x64Exec = "\bin\DiskMark64.exe"

Set pathObj = CreateObject("WScript.Shell")
pathObj.CurrentDirectory = CreateObject("Scripting.FileSystemObject").GetParentFolderName(WScript.ScriptFullName)
osArch = pathObj.RegRead("HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Environment\PROCESSOR_ARCHITECTURE")
If osArch = "x86" Then
    execLoc = """" + pathObj.CurrentDirectory + x86Exec + """"
ElseIf osArch = "AMD64" Then
    execLoc = """" + pathObj.CurrentDirectory + x64Exec + """"
End If
RunApp = CreateObject("Shell.Application").ShellExecute(execLoc,,,"runas",1)