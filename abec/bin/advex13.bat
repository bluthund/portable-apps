rem Advanced Batch File: File Variables example
mode con:cols=80 lines=25
echo.
echo.
echo.
echo %%~0  = %~0
echo.
echo.
echo Expands %0 (%%0) 
echo removing any surrounding quotes (")
echo.
echo.
rem Wait 2000
echo.
echo.
echo.
echo %%~f0 = %~f0
echo.
echo.
echo Expands %0 (%%0)
echo to a fully qualified path name
echo.
echo.
rem Wait 2000
echo.
echo.
echo.
echo %%~d0 = %~d0        
echo.
echo.
echo Expands %0 (%%0)
echo to a drive letter only
echo.
echo.
rem Wait 2000
echo.
echo.
echo.
echo %%~p0 = %~p0        
echo.
echo.
echo Expands %0 (%%0)
echo to a path only
echo.
echo.
rem Wait 2000
echo.
echo.
echo.
echo %%~n0 = %~n0        
echo.
echo.
echo Expands %0 (%%0)
echo to a file name only
echo.
echo.
rem Wait 2000
echo.
echo.
echo.
echo %%~x0 = %~x0        
echo.
echo.
echo Expands %0 (%%0)
echo to a file extension only
echo.
echo.
rem Wait 2000
echo.
echo.
echo.
echo %%~s0 = %~s0        
echo.
echo.
echo Expanded path contains short names only
echo.
echo.
rem Wait 2000
echo.
echo.
echo.
echo %%~a0 = %~a0        
echo.
echo.
echo Expands %0 (%%0)
echo to file attributes
echo.
echo.
rem Wait 2000
echo.
echo.
echo.
echo %%~t0 = %~t0        
echo.
echo.
echo Expands %0 (%%0)
echo to date/time of file
echo.
echo.
rem Wait 2000
echo.
echo.
echo.
echo %%~z0 = %~z0        
echo.
echo.
echo Expands %0 (%%0)
echo to size of file
echo.
echo.
rem Wait 2000
echo.
echo.
echo.
echo The modifiers can be combined to get compound results:
echo.
echo.
echo %%~dp0 = %~dp0       
echo.
echo.
echo Expands %0 (%%0)
echo to a drive letter and path only
echo.
echo.
rem Wait 2000
echo.
echo.
echo.
echo %%~nx0 = %~nx0       
echo.
echo.
echo Expands %0 (%%0)
echo to a file name and extension only
echo.
echo.
rem Wait 2000
echo.
echo.
echo.
echo %%~ftza0 = %~ftza0     
echo.
echo.
echo Expands %0 (%%0)
echo to a DIR like output line
echo.
echo.
pause
cls