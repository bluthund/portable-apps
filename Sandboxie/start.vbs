If WScript.Arguments.length = 0 Then
    Call Main
Else
    Call RunAs("""" + WScript.Arguments(0) + """","runas")
    WScript.Quit
End If

Function RunAs(execPath,uacPm)
    Set pathObj = CreateObject("Shell.Application")
    pathObj.ShellExecute execPath,,,uacPm,0
End Function

Function RegChk(regPath,regCmpr)
    On Error Resume Next
        Dim regData : regData = WScript.CreateObject("WScript.Shell").RegRead(regPath)
    On Error GoTo 0
    If InStr(regData,regCmpr) = 0 Then
        RegChk = true
    Else
        RegChk = false
    End If
End Function

Function Waiter(processName)
    Set svc=getobject("winmgmts:root\cimv2")
    sQuery="select * from win32_process where name='" & processName & "'"

    Set cproc=svc.execquery(sQuery)
    iniproc=cproc.count

    Do While iniproc = 1
        WScript.Sleep(5000)
        Set svc=getobject("winmgmts:root\cimv2")
        sQuery="select * from win32_process where name='" & processName & "'"
        Set cproc=svc.execquery(sQuery)
        iniproc=cproc.count
    Loop
End Function

Function Main
    Dim noReg : curPath = CreateObject("Scripting.FileSystemObject").GetParentFolderName(WScript.ScriptFullName)
    osArch = CreateObject("WScript.Shell").RegRead("HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Environment\PROCESSOR_ARCHITECTURE")
    
    If osArch = "x86" Then
        noReg = RegChk("HKCR\*\shell\sandbox\command\","""" + curPath + "\bin\x86\Start.exe""")
    ElseIf osArch = "AMD64" Then
        noReg = RegChk("HKCR\*\shell\sandbox\command\","""" + curPath + "\bin\x64\Start.exe""")
    End If
	
    If noReg = True Then
        Call RunAs(curPath + "\bin\install.cmd","runas")
    	WScript.Sleep(20000)
    Else
        Call RunAs(curPath + "\bin\launch.cmd","open")
        WScript.Sleep(5000)
    End If

    Call Waiter("SbieCtrl.exe")
    Call RunAs(curPath + "\bin\uninstall.cmd","runas")

End Function