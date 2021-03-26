If WScript.Arguments.length = 0 Then
    Call Main
Else
    On Error Resume Next
        Set pathObj = CreateObject("Shell.Application")
        pathObj.ShellExecute WScript.Arguments.Item(0),,,"runas",0
    On Error Goto 0
End If

Function SvcChk(svcName)
    Set wmi = GetObject("winmgmts://./root/cimv2")
    On Error Resume Next
        svcData = wmi.Get("Win32_Service.Name='" + svcName + "'").State
    On Error GoTo 0
    If svcData = "" Then
        SvcChk = true
    Else
        SvcChk = false
    End If
End Function

Function RegChk(regPath,regCmpr)
    On Error Resume Next
        Dim regData : regData = WScript.CreateObject("WScript.Shell").RegRead(regPath)
    On Error GoTo 0
    If InStr(1,regData,regCmpr,1) > 0 Then
        RegChk = false
    Else
        RegChk = true
    End If
End Function

Function Main
    Set sPath = CreateObject("WScript.Shell")
    sPath.CurrentDirectory = CreateObject("Scripting.FileSystemObject").GetParentFolderName(WScript.ScriptFullName)
    osArch = sPath.RegRead("HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Environment\PROCESSOR_ARCHITECTURE")
    If osArch = "x86" Then
    	execLoc = sPath.CurrentDirectory + "\bin\x86\FolderSize.exe"
    ElseIf osArch = "AMD64" Then
	osArch = "x64"
    	execLoc = sPath.CurrentDirectory + "\bin\x64\FolderSize.exe"
    End If

    Dim noSvc : noSvc = SvcChk("FolderSize")
    Dim noReg : noReg = RegChk("HKCR\Directory\shell\foldersize\command\",execLoc)
    Set pathObj = CreateObject("Shell.Application")

    On Error Resume Next
    If noSvc = True Or noReg = True Then
        pathObj.ShellExecute sPath.CurrentDirectory + "\bin\launch.cmd",osArch,,"runas",0
    Else
        pathObj.ShellExecute sPath.CurrentDirectory + "\bin\launch.cmd",osArch,,"open",0
    End If
    On Error Goto 0
End Function