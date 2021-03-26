::DISCLAIMER: this tool can be used for free, the credits to JamFlux and other authors must be visible where the ROM has been published
@shift /0
@echo OFF
SETLOCAL ENABLEDELAYEDEXPANSION
SET APP_NAME=UR-Tool Prime v1.8
SET AUTHORS=[by JamFlux]
SET APP_DESCRIPTION=Extract and repack ROM ZIP files for Android 5 to 8.1
set CYGWIN=nodosfilewarning
SET Cecho=cecho.exe
SET busybox=busybox.exe
set imgextractor="ImgExtractor.exe"
TITLE %APP_NAME%

:start
mode con: cols=75 lines=15
if exist "%UNPACKDIR%" rmdir /q /s "%UNPACKDIR%"
if exist 1-Finish rmdir /q /s 1-Finish
cls
echo.
echo.
echo 	   ".##..##.#####.........######..####...####..##.....";
echo 	   ".##..##.##..##..........##...##..##.##..##.##.....";
echo 	   ".##..##.#####..######...##...##..##.##..##.##.....";
echo 	   ".##..##.##..##..........##...##..##.##..##.##.....";
echo 	   "..####..##..##..........##....####...####..######.";
echo 	   "..................................................";
echo.
%cecho%                                                       {03}by JamFlux{#}
echo.
echo.
echo.
%cecho%           {4f}%APP_DESCRIPTION%{#}
TIMEOUT /T 3 /nobreak > NUL & cls


::Find .zip files into executable directory
mode con: cols=75 lines=28
:ZIP_FILES
cls
echo.
echo.
echo 	   ".##..##.#####.........######..####...####..##.....";
echo 	   ".##..##.##..##..........##...##..##.##..##.##.....";
echo 	   ".##..##.#####..######...##...##..##.##..##.##.....";
echo 	   ".##..##.##..##..........##...##..##.##..##.##.....";
echo 	   "..####..##..##..........##....####...####..######.";
echo 	   "..................................................";
echo.
%cecho%                                                       {03}by JamFlux{#}
echo.
echo.
echo.
echo            *****************************************************
%cecho%            {0b}Select a ZIP file to work with:{#}
echo.
echo            *****************************************************
echo.
echo.
SET /A i=1
cd /d "%~dp0..\data"
FOR %%k IN (*.zip) DO (
	SET ZIP!i!=%%k
	echo *          !i! - %%k
	SET /A i+=1
)
cd /d %cd%\..\bin
echo.
echo.
SET /P NUMBER=*          Choose the number: 
IF NOT DEFINED NUMBER GOTO :ZIP_FILES
IF /I %NUMBER% GEQ %i% GOTO :ZIP_FILES
IF /I %NUMBER% LSS 1 GOTO :ZIP_FILES
SET FILENAME=!ZIP%NUMBER%!
SET FILE=..\data\!FILENAME!

IF NOT EXIST "%FILE%" GOTO :ZIP_FILES

::The main menu
:work_place
cls
echo.
echo.
echo 	   ".##..##.#####.........######..####...####..##.....";
echo 	   ".##..##.##..##..........##...##..##.##..##.##.....";
echo 	   ".##..##.#####..######...##...##..##.##..##.##.....";
echo 	   ".##..##.##..##..........##...##..##.##..##.##.....";
echo 	   "..####..##..##..........##....####...####..######.";
echo 	   "..................................................";
echo.
%cecho%                                                       {03}by JamFlux{#}
echo.
echo.
echo            *****************************************************
echo *          Working with: 
%cecho% *          {0b}!filename!{#}
echo.
echo            *****************************************************
echo.
%cecho% *                                                 {0a}Available options:{#}
echo.
echo.
echo *          1 - Extract Android image (BIN/IMG/DAT.BR are supported)
echo *          2 - Repack Android folder to its original format
echo *          3 - Exit
echo.
echo.
SET /P NUMBER=*          Select option: 
IF "%NUMBER%"=="1" GOTO Just_Unpack
IF "%NUMBER%"=="2" GOTO Just_Repack
IF "%NUMBER%"=="3" GOTO Exit
::IF "%NUMBER%"=="4" GOTO Make_zip

::Determining ROM format
:Just_Unpack
cls
echo.
echo.
echo 	   ".##..##.#####.........######..####...####..##.....";
echo 	   ".##..##.##..##..........##...##..##.##..##.##.....";
echo 	   ".##..##.#####..######...##...##..##.##..##.##.....";
echo 	   ".##..##.##..##..........##...##..##.##..##.##.....";
echo 	   "..####..##..##..........##....####...####..######.";
echo 	   "..................................................";
echo.
%cecho%                                                       {03}by JamFlux{#}
echo.
echo.
echo            *****************************************************
echo *          Working with: 
%cecho% *          {0b}!filename!{#}
echo.
echo            *****************************************************
echo.
echo.
echo.
%cecho% *          {0a}Extracting zip files...{#}
echo.
SET UNPACKDIR=..\data\unpack\%FILENAME:.zip=%
IF NOT EXIST "%UNPACKDIR%" MKDIR "%UNPACKDIR%"
IF NOT EXIST "%UNPACKDIR%\1-Sources" MKDIR "%UNPACKDIR%\1-Sources"
IF NOT EXIST "%UNPACKDIR%\temp" MKDIR "%UNPACKDIR%\temp"
IF NOT EXIST "%UNPACKDIR%\system" MKDIR "%UNPACKDIR%\system"
IF NOT EXIST "%UNPACKDIR%\1-Sources" MKDIR "%UNPACKDIR%\1-Sources"
::Copying extracted files to source folder
7z e "%FILE%" n system.new.dat.br -o"%UNPACKDIR%\1-Sources" >nul
7z e "%FILE%" n system.new.dat -o"%UNPACKDIR%\1-Sources" >nul
7z e "%FILE%" n system.img -o"%UNPACKDIR%\1-Sources" >nul
7z e "%FILE%" n payload.bin -o"%UNPACKDIR%\1-Sources" >nul
7z e "%FILE%" n vendor.new.dat.br -o"%UNPACKDIR%\1-Sources" >nul
7z e "%FILE%" n vendor.new.dat -o"%UNPACKDIR%\1-Sources" >nul
7z e "%FILE%" n vendor.img -o"%UNPACKDIR%\1-Sources" >nul
7z e "%FILE%" n boot.img -o"%UNPACKDIR%\1-Sources" >nul
7z e "%FILE%" n system.transfer.list -o"%UNPACKDIR%\1-Sources" >nul
7z e "%FILE%" n vendor.transfer.list -o"%UNPACKDIR%\1-Sources" >nul
7z e "%FILE%" n file_contexts -o"%UNPACKDIR%\1-Sources" >nul
7z e "%FILE%" n file_contexts.bin -o"%UNPACKDIR%\1-Sources" >nul
if exist  "%UNPACKDIR%\1-Sources\vendor.*" (goto un_vendor) else goto next
:next
::Looking for system or vendor compression format
if exist "%UNPACKDIR%\1-Sources\system.new.dat.br" echo new.dat.br format found >>%UNPACKDIR%\temp\system.new.dat.br.br
if exist "%UNPACKDIR%\1-Sources\system.new.dat" echo new.dat format found >>%UNPACKDIR%\temp\system.new.dat.dat
if exist "%UNPACKDIR%\1-Sources\payload.bin" echo payload.bin format found >>%UNPACKDIR%\temp\payload.bin.bin
if exist "%UNPACKDIR%\1-Sources\system.img" echo system.img format found >>%UNPACKDIR%\temp\system.img.img
FOR /R %UNPACKDIR%\temp %%A IN (*) DO SET format=%%~nA
cls
echo.
echo.
echo 	   ".##..##.#####.........######..####...####..##.....";
echo 	   ".##..##.##..##..........##...##..##.##..##.##.....";
echo 	   ".##..##.#####..######...##...##..##.##..##.##.....";
echo 	   ".##..##.##..##..........##...##..##.##..##.##.....";
echo 	   "..####..##..##..........##....####...####..######.";
echo 	   "..................................................";
echo.
%cecho%                                                       {03}by JamFlux{#}
echo.
echo.
echo            *****************************************************
echo *          Working with: 
%cecho% *          {0b}!filename!{#}
echo.
echo            *****************************************************
echo.
echo.
echo.
%cecho% *           Current format is: {0a}!format!{#}
echo.
TIMEOUT /T 3 /nobreak > NUL

:check_format
cls
if "!format!"=="payload.bin" (goto un_payload) else goto next_1
:next_1
cls
if "!format!"=="system.new.dat.br" (goto un_brotli) else goto next_2
:next_2
cls
if "!format!"=="system.new.dat" (goto un_pack_dat) else goto next_3
:next_3
cls
if "!format!"=="system.img" (goto Extract_SYS) else goto not_supported
goto:eof


:un_vendor
::Unpacking vendor image
cls
echo.
echo.
echo 	   ".##..##.#####.........######..####...####..##.....";
echo 	   ".##..##.##..##..........##...##..##.##..##.##.....";
echo 	   ".##..##.#####..######...##...##..##.##..##.##.....";
echo 	   ".##..##.##..##..........##...##..##.##..##.##.....";
echo 	   "..####..##..##..........##....####...####..######.";
echo 	   "..................................................";
echo.
%cecho%                                                       {03}by JamFlux{#}
echo.
echo.
echo            *****************************************************
echo *          Working with: 
%cecho% *          {0b}!filename!{#}
echo.
echo            *****************************************************
echo.
echo.
echo.
%cecho% *           {0a}Vendor image found:{#} extracting...
echo.
if exist %UNPACKDIR%\1-Sources\vendor.new.dat.br brotli -d %UNPACKDIR%\1-Sources\vendor.new.dat.br >nul
if exist %UNPACKDIR%\1-Sources\vendor.new.dat sdat2img %UNPACKDIR%\1-Sources\vendor.transfer.list %UNPACKDIR%\1-Sources\vendor.new.dat %UNPACKDIR%\1-Sources\vendor.img >nul
if exist %UNPACKDIR%\1-Sources\vendor.img ImgExtractor %UNPACKDIR%\1-Sources\vendor.img %UNPACKDIR%\vendor >nul
call :Detect_vendor_size
call :write_vendor_symlinks
if exist %UNPACKDIR%\1-Sources\vendor.new.dat.br !busybox! rm -rf %UNPACKDIR%\1-Sources\vendor.new.dat.br >nul
if exist %UNPACKDIR%\1-Sources\vendor.new.dat !busybox! rm -rf %UNPACKDIR%\1-Sources\vendor.new.dat >nul
goto next


:not_supported
::Not supported android image
cls
echo.
echo.
echo 	   ".##..##.#####.........######..####...####..##.....";
echo 	   ".##..##.##..##..........##...##..##.##..##.##.....";
echo 	   ".##..##.#####..######...##...##..##.##..##.##.....";
echo 	   ".##..##.##..##..........##...##..##.##..##.##.....";
echo 	   "..####..##..##..........##....####...####..######.";
echo 	   "..................................................";
echo.
%CECHO%                                                       {03}by JamFlux{#}
echo.
echo.
echo.
%CECHO% *          {0f}I have found a format type error:{#}
echo.
echo.
echo.
echo            *****************************************************
%CECHO% *          The supplied zip {0c}does not contain a supported format{#}
echo.
echo.
%CECHO% *          Valid formats are: {0a}system.IMG/NEW.DAT/BR/payload.BIN{#}
echo.
echo            *****************************************************
echo.
pause>nul
rmdir /q /s "%UNPACKDIR%"
goto ZIP_FILES


:un_payload
::Use only for A/B devices like pixel or mi a1, mi a2
cls
echo.
echo.
echo 	   ".##..##.#####.........######..####...####..##.....";
echo 	   ".##..##.##..##..........##...##..##.##..##.##.....";
echo 	   ".##..##.#####..######...##...##..##.##..##.##.....";
echo 	   ".##..##.##..##..........##...##..##.##..##.##.....";
echo 	   "..####..##..##..........##....####...####..######.";
echo 	   "..................................................";
echo.
%cecho%                                                       {03}by JamFlux{#}
echo.
echo.
echo            *****************************************************
%cecho% *          Working with {0b}!format!{#} ROM: 
echo.
%cecho% *          {0b}!filename!{#}
echo.
echo            *****************************************************
echo.
echo.
echo.
%cecho% *          Unpacking {0a}!format!{#} system images...
echo.
7z x "payload.7z" -o%UNPACKDIR%\1-Sources >nul
move /y %UNPACKDIR%\1-Sources\payload.bin %UNPACKDIR%\1-Sources\payload_input >nul 2>nul
cd %UNPACKDIR%\1-Sources
call payload_dumper.bat
cd ..\..
move /y %UNPACKDIR%\1-Sources\payload_output\system.img %UNPACKDIR%\1-Sources>nul 2>nul
move /y %UNPACKDIR%\1-Sources\payload_output\boot.img %UNPACKDIR%\1-Sources >nul 2>nul
cls
echo.
echo.
echo 	   ".##..##.#####.........######..####...####..##.....";
echo 	   ".##..##.##..##..........##...##..##.##..##.##.....";
echo 	   ".##..##.#####..######...##...##..##.##..##.##.....";
echo 	   ".##..##.##..##..........##...##..##.##..##.##.....";
echo 	   "..####..##..##..........##....####...####..######.";
echo 	   "..................................................";
echo.
%cecho%                                                       {03}by JamFlux{#}
echo.
echo.
echo            *****************************************************
%cecho% *          Working with {0b}!format!{#} ROM: 
echo.
%cecho% *          {0b}!filename!{#}
echo.
echo            *****************************************************
echo.
echo.
echo.
%cecho% *          {0a}Done{#}
echo.
if exist %UNPACKDIR%\1-Sources\payload_input rmdir /q /s %UNPACKDIR%\1-Sources\payload_input >nul 2>nul
if exist %UNPACKDIR%\1-Sources\payload_output rmdir /q /s %UNPACKDIR%\1-Sources\payload_output >nul 2>nul
if exist %UNPACKDIR%\1-Sources\payload_dumper.exe !busybox! rm -rf %UNPACKDIR%\1-Sources\payload_dumper.exe >nul 2>nul
if exist %UNPACKDIR%\1-Sources\payload_dumper.bat !busybox! rm -rf %UNPACKDIR%\1-Sources\payload_dumper.bat >nul 2>nul
TIMEOUT /T 2 /nobreak > NUL
goto Extract_SYS


:un_brotli
::Unpack brotli compressed image, ROMs above android 8.1
cls
echo.
echo.
echo 	   ".##..##.#####.........######..####...####..##.....";
echo 	   ".##..##.##..##..........##...##..##.##..##.##.....";
echo 	   ".##..##.#####..######...##...##..##.##..##.##.....";
echo 	   ".##..##.##..##..........##...##..##.##..##.##.....";
echo 	   "..####..##..##..........##....####...####..######.";
echo 	   "..................................................";
echo.
%cecho%                                                       {03}by JamFlux{#}
echo.
echo.
echo            *****************************************************
%cecho% *          Working with {0b}!format!{#} ROM: 
echo.
%cecho% *          {0b}!filename!{#}
echo.
echo            *****************************************************
echo.
echo.
echo.
%cecho% *          Decompressing {0a}!format!{#} format...
echo.
brotli.exe -dj %UNPACKDIR%/1-Sources/system.new.dat.br >nul
:un_pack_dat
::Unpacking .dat compression
cls
echo.
echo.
echo 	   ".##..##.#####.........######..####...####..##.....";
echo 	   ".##..##.##..##..........##...##..##.##..##.##.....";
echo 	   ".##..##.#####..######...##...##..##.##..##.##.....";
echo 	   ".##..##.##..##..........##...##..##.##..##.##.....";
echo 	   "..####..##..##..........##....####...####..######.";
echo 	   "..................................................";
echo.
%cecho%                                                       {03}by JamFlux{#}
echo.
echo.
echo            *****************************************************
%cecho% *          Working with {0b}!format!{#} ROM: 
echo.
%cecho% *          {0b}!filename!{#}
echo.
echo            *****************************************************
echo.
echo.
echo.
%cecho% *          Unpacking {0a}!format!{#} format...
echo.
sdat2img %UNPACKDIR%\1-Sources\system.transfer.list %UNPACKDIR%\1-Sources\system.new.dat %UNPACKDIR%\1-Sources\system.img >nul
if exist %UNPACKDIR%\1-Sources\system.new.dat.br !busybox! rm -rf %UNPACKDIR%\1-Sources\system.new.dat.br >nul 2>nul
if exist %UNPACKDIR%\1-Sources\system.new.dat !busybox! rm -rf %UNPACKDIR%\1-Sources\system.new.dat >nul 2>nul
TIMEOUT /T 1 /nobreak > NUL
goto Extract_SYS


:Extract_SYS
::Main function for editing ROM's stuff, extracting system image to simple files folder
call :Detect_system_size
cls
echo.
echo.
echo 	   ".##..##.#####.........######..####...####..##.....";
echo 	   ".##..##.##..##..........##...##..##.##..##.##.....";
echo 	   ".##..##.#####..######...##...##..##.##..##.##.....";
echo 	   ".##..##.##..##..........##...##..##.##..##.##.....";
echo 	   "..####..##..##..........##....####...####..######.";
echo 	   "..................................................";
echo.
%cecho%                                                       {03}by JamFlux{#}
echo.
echo.
echo            *****************************************************
%cecho% *          Working with {0b}!format!{#} ROM: 
echo.
%cecho% *          {0b}!filename!{#}
echo.
echo            *****************************************************
echo.
echo.
echo.
%cecho% *          Extracting {0a}system.img{#}...
echo.
echo.
if not exist %UNPACKDIR%\system mkdir %UNPACKDIR%\system
:: ---> This is for extract system.img using 7z,  this puts wrong symlinks format, so better is use into system folder zip ROM
7z x -y "%UNPACKDIR%\1-Sources\system.img" -o"%UNPACKDIR%\system" >nul 2>nul
rmdir /q /s %UNPACKDIR%\system\[SYS] >nul
:: <---
call :img_extractor
call :Remove_pics_with_spaces
cls
echo.
echo.
echo 	   ".##..##.#####.........######..####...####..##.....";
echo 	   ".##..##.##..##..........##...##..##.##..##.##.....";
echo 	   ".##..##.#####..######...##...##..##.##..##.##.....";
echo 	   ".##..##.##..##..........##...##..##.##..##.##.....";
echo 	   "..####..##..##..........##....####...####..######.";
echo 	   "..................................................";
echo.
%cecho%                                                       {03}by JamFlux{#}
echo.
echo.
echo            *****************************************************
%cecho% *          Working with {0b}!format!{#} ROM: 
echo.
%cecho% *          {0b}!filename!{#}
echo.
echo            *****************************************************
echo.
echo.
echo.
%cecho% *          Grabbing {0a}symlinks{#} and {0a}permissions{#}...
echo.
echo.
::Converts android 7+ file_contexts.bin to plain format. Thanks to wuxianlin at github.
if not exist %UNPACKDIR%\1-Sources\file_contexts call :File_Context_converter >nul 2>nul
::This part for grabbing symlinks and permissions was adapted from assayyed kitchen batch-script code. Thanks to Assayyed.
call :write_sys_symlinks
call :write_sys_permissions
if exist %UNPACKDIR%\1-Sources\not_recursive !busybox! rm -rf %UNPACKDIR%\1-Sources\not_recursive >nul
if exist %UNPACKDIR%\1-Sources\permissions_sorted !busybox! rm -rf %UNPACKDIR%\1-Sources\permissions_sorted >nul
if exist %UNPACKDIR%\1-Sources\recursive !busybox! rm -rf %UNPACKDIR%\1-Sources\recursive >nul
if exist %UNPACKDIR%\1-Sources\rom_permissions !busybox! rm -rf %UNPACKDIR%\1-Sources\rom_permissions >nul
if exist %UNPACKDIR%\1-Sources\system_contexts !busybox! rm -rf %UNPACKDIR%\1-Sources\system_contexts >nul
call :Detect_vendor_size
echo %SIZE%>>%UNPACKDIR%\1-Sources\sys_size.txt
echo.
if exist %UNPACKDIR%\vendor echo %VSIZE%>>%UNPACKDIR%\1-Sources\vend_size.txt
if exist %UNPACKDIR%\1-Sources\vendor.img !busybox! rm -rf %UNPACKDIR%\1-Sources\vendor.img >nul
if exist %UNPACKDIR%\1-Sources\vendor.transfer.list !busybox! rm -rf %UNPACKDIR%\1-Sources\vendor.transfer.list >nul
echo.
cls
echo.
echo.
echo 	   ".##..##.#####.........######..####...####..##.....";
echo 	   ".##..##.##..##..........##...##..##.##..##.##.....";
echo 	   ".##..##.#####..######...##...##..##.##..##.##.....";
echo 	   ".##..##.##..##..........##...##..##.##..##.##.....";
echo 	   "..####..##..##..........##....####...####..######.";
echo 	   "..................................................";
echo.
%cecho%                                                       {03}by JamFlux{#}
echo.
echo.
echo            *****************************************************
%cecho% *          Working with {0b}!format!{#} ROM: 
echo.
%cecho% *          {0b}!filename!{#}
echo.
echo            *****************************************************
echo.
echo.
echo.
%cecho% *          Done, see {0a}%UNPACKDIR%\system{#} folder.
echo.
echo.
if exist %UNPACKDIR%\1-Sources\system.img !busybox! rm -rf %UNPACKDIR%\1-Sources\system.img >nul 2>nul
if exist %UNPACKDIR%\1-Sources\system.transfer.list !busybox! rm -rf %UNPACKDIR%\1-Sources\system.transfer.list >nul 2>nul
if not exist %UNPACKDIR%\1-Sources\file_contexts call :File_Context_converter >nul 2>nul
TIMEOUT /T 3 /nobreak > NUL
cd %UNPACKDIR%/1-Sources
if exist original_symlinks del /q original_symlinks
cd ..\..
%busybox% sort -u < %UNPACKDIR%/1-Sources/symlinks >> %UNPACKDIR%/1-Sources/original_symlinks
if exist %UNPACKDIR%\1-Sources\vendor_symlinks %busybox% sort -u < %UNPACKDIR%/1-Sources/vendor_symlinks >> %UNPACKDIR%/1-Sources/original_vendor_symlinks
if exist %UNPACKDIR%\1-Sources\original_vendor_symlinks type %UNPACKDIR%\1-Sources\original_vendor_symlinks >> %UNPACKDIR%\1-Sources\original_symlinks
cd %UNPACKDIR%/1-Sources
del /q symlinks
if exist vendor_symlinks del /q vendor_symlinks
if exist original_vendor_symlinks del /q original_vendor_symlinks
cd ..\..
dos2unix -q %UNPACKDIR%\1-Sources\original_symlinks
dos2unix -q %UNPACKDIR%\1-Sources\file_contexts
goto work_place

::Magic happen here --->
:File_Context_converter
if not exist %UNPACKDIR%\1-Sources\file_contexts.bin call :File_Context_finder >nul 2>nul
sefcontext_decompile -o%UNPACKDIR%\1-Sources\file_contexts %UNPACKDIR%\1-Sources\file_contexts.bin >nul 2>nul
if exist %UNPACKDIR%\1-Sources\file_contexts %busybox% sort -u < %UNPACKDIR%/1-Sources/file_contexts >> %UNPACKDIR%/1-Sources/file_contexts_sorted
cd %UNPACKDIR%/1-Sources
move /y file_contexts_sorted file_contexts > nul
cd ..\..
goto:eof
:File_Context_finder
xcopy bootimg.exe %UNPACKDIR%\1-Sources /y >nul
cd %UNPACKDIR%\1-Sources
bootimg.exe --unpack-bootimg >nul 2>nul
bootimg.exe --unpack-ramdisk >nul 2>nul
if exist initrd\plat_file_contexts move /y initrd\plat_file_contexts initrd\file_contexts >nul
cd ..\..
move /y %UNPACKDIR%\1-Sources\initrd\file_contexts %UNPACKDIR%\1-Sources >nul 2>nul
move /y %UNPACKDIR%\1-Sources\initrd\file_contexts.bin %UNPACKDIR%\1-Sources >nul 2>nul
if exist %UNPACKDIR%\1-Sources\initrd rmdir /q /s %UNPACKDIR%\1-Sources\initrd >nul 2>nul
if exist %UNPACKDIR%\1-Sources\bootimg.exe !busybox! rm -rf %UNPACKDIR%\1-Sources\bootimg.exe >nul 2>nul
if exist %UNPACKDIR%\1-Sources\bootimg.json !busybox! rm -rf %UNPACKDIR%\1-Sources\bootimg.json >nul 2>nul
if exist %UNPACKDIR%\1-Sources\*.gz !busybox! rm -rf %UNPACKDIR%\1-Sources\*.gz >nul 2>nul
if exist %UNPACKDIR%\1-Sources\cpiolist.txt !busybox! rm -rf %UNPACKDIR%\1-Sources\cpiolist.txt >nul 2>nul
if exist %UNPACKDIR%\1-Sources\kernel.gz.dt !busybox! rm -rf %UNPACKDIR%\1-Sources\kernel.gz.dt >nul 2>nul
if exist %UNPACKDIR%\1-Sources\unknown !busybox! rm -rf %UNPACKDIR%\1-Sources\unknown >nul 2>nul
goto:eof
::Till here<---

:no project
:Sin_proyecto
cls
echo.
echo.
echo 	   ".##..##.#####.........######..####...####..##.....";
echo 	   ".##..##.##..##..........##...##..##.##..##.##.....";
echo 	   ".##..##.#####..######...##...##..##.##..##.##.....";
echo 	   ".##..##.##..##..........##...##..##.##..##.##.....";
echo 	   "..####..##..##..........##....####...####..######.";
echo 	   "..................................................";
echo.
%cecho%                                                       {03}by JamFlux{#}
echo.
echo.
echo.
%cecho% *          {0f}I have found a serious error:{#}
echo.
echo.
echo.
echo            *****************************************************
%cecho% *          The supplied zip {0c}doesn't have a build.prop{#}
echo.
echo.
%cecho% *          Please, choose option {0a}1{#} before
echo.
echo *          building a new system project.
echo            *****************************************************
echo.
pause>nul
if exist "%UNPACKDIR%" rmdir /q /s "%UNPACKDIR%"
goto work_place


::Second part for re-pack!

:Just_Repack
:check_android_version
FOR /R %UNPACKDIR%\temp %%A IN (*) DO SET format=%%~nA
if "!format!"=="payload.bin" (goto system_AB) else goto system_A
::Normal system android image
:system_A
if not exist %UNPACKDIR%\system\build.prop goto Sin_proyecto
FOR /F "Tokens=2* Delims==" %%# In (
    'TYPE "%UNPACKDIR%\system\build.prop" ^| FINDSTR "ro.build.version.release="'
) Do (
    SET "release=%%#"
)
call :zipalign
cls
echo.
echo.
echo 	   ".##..##.#####.........######..####...####..##.....";
echo 	   ".##..##.##..##..........##...##..##.##..##.##.....";
echo 	   ".##..##.#####..######...##...##..##.##..##.##.....";
echo 	   ".##..##.##..##..........##...##..##.##..##.##.....";
echo 	   "..####..##..##..........##....####...####..######.";
echo 	   "..................................................";
echo.
%cecho%            Android version: {0a}!release!{#}                     {03}by JamFlux{#}
echo.
echo.
echo            *****************************************************
%cecho% *          Working with {0b}!format!{#} ROM: 
echo.
%cecho% *          {0b}!filename!{#}
echo.
echo            *****************************************************
echo.
echo.
echo.
%cecho% *          Repacking to: {0a}!format!{#} format...
echo.
if not exist %UNPACKDIR%\2-New_system mkdir %UNPACKDIR%\2-New_system >nul
if exist %UNPACKDIR%\vendor make_ext4fs -L vendor -T 2009110000 -S %UNPACKDIR%\1-Sources\file_contexts -l %VSIZE% -a vendor %UNPACKDIR%\2-New_system\vendor_ext4.img %UNPACKDIR%\vendor\ >nul 2>nul
make_ext4fs -L system -T 2009110000 -S %UNPACKDIR%\1-Sources\file_contexts -C %UNPACKDIR%\1-Sources\fs_config -l %SIZE% -a system %UNPACKDIR%\2-New_system\system_ext4.img %UNPACKDIR%\system\ >nul 2>nul
FOR %%B IN ("%UNPACKDIR%\2-New_system\system_ext4.img") DO SET SIZE2=%%~zB
echo %SIZE2% >> %UNPACKDIR%\1-Sources\sys_size2.txt
if %SIZE2%==0 (goto no_fs_config) else (goto decide_format)
:decide_format
cls
echo.
echo.
echo 	   ".##..##.#####.........######..####...####..##.....";
echo 	   ".##..##.##..##..........##...##..##.##..##.##.....";
echo 	   ".##..##.#####..######...##...##..##.##..##.##.....";
echo 	   ".##..##.##..##..........##...##..##.##..##.##.....";
echo 	   "..####..##..##..........##....####...####..######.";
echo 	   "..................................................";
echo.
%cecho%            Android version: {0a}!release!{#}                     {03}by JamFlux{#}
echo.
echo.
echo            *****************************************************
%cecho% *          Working with {0b}!format!{#} ROM: 
echo.
%cecho% *          {0b}!filename!{#}
echo.
echo            *****************************************************
echo.
echo.
echo.
%cecho% *          Repacking to: {0a}!format!{#} format...
echo.
if "!format!"=="payload.bin" (goto Repack_IMG) else goto next_1.1
:next_1.1
cls
if "!format!"=="system.new.dat.br" (goto re_brotli) else goto next_2.1
:next_2.1
cls
if "!format!"=="system.new.dat" (goto re_pack_dat) else goto next_3.1
:next_3.1
cls
if "!format!"=="system.img" (goto Repack_IMG) else goto not_supported
goto:eof
if exist %UNPACKDIR%\1-Sources\system.img !busybox! rm -rf %UNPACKDIR%\1-Sources\system.img > nul


::Pixel and mi a1 system images, double system slot
:system_AB
if not exist %UNPACKDIR%\system\system\build.prop goto Sin_proyecto
FOR /F "Tokens=2* Delims==" %%# In (
    'TYPE "%UNPACKDIR%\system\system\build.prop" ^| FINDSTR "ro.build.version.release="'
) Do (
    SET "release=%%#"
)
call :zipalign
cls
echo.
echo.
echo 	   ".##..##.#####.........######..####...####..##.....";
echo 	   ".##..##.##..##..........##...##..##.##..##.##.....";
echo 	   ".##..##.#####..######...##...##..##.##..##.##.....";
echo 	   ".##..##.##..##..........##...##..##.##..##.##.....";
echo 	   "..####..##..##..........##....####...####..######.";
echo 	   "..................................................";
echo.
%cecho%            Android version: {0a}!release!{#}                     {03}by JamFlux{#}
echo.
echo.
echo            *****************************************************
%cecho% *          Working with {0b}!format!{#} A/B ROM: 
echo.
%cecho% *          {0b}!filename!{#}
echo.
echo            *****************************************************
echo.
echo.
echo.
%cecho% *          Repacking to: {0a}system.img{#} format...
echo.
if not exist %UNPACKDIR%\2-New_system mkdir %UNPACKDIR%\2-New_system >nul
if exist %UNPACKDIR%\vendor make_ext4fs -L vendor -T 2009110000 -S %UNPACKDIR%\1-Sources\file_contexts -l %VSIZE% -a vendor %UNPACKDIR%\2-New_system\vendor_ext4.img %UNPACKDIR%\vendor\ >nul 2>nul
make_ext4fs -L system -T 2009110000 -S %UNPACKDIR%\1-Sources\file_contexts -C %UNPACKDIR%\1-Sources\fs_config -l %SIZE% -a system %UNPACKDIR%\2-New_system\system_ext4.img %UNPACKDIR%\system\ >nul 2>nul
FOR %%B IN ("%UNPACKDIR%\2-New_system\system_ext4.img") DO SET SIZE2=%%~zB
echo %SIZE2% >> %UNPACKDIR%\1-Sources\sys_size2.txt
if %SIZE2%==0 (goto no_fs_config_AB) else (goto decide_format2)
:decide_format2
cls
echo.
echo.
echo 	   ".##..##.#####.........######..####...####..##.....";
echo 	   ".##..##.##..##..........##...##..##.##..##.##.....";
echo 	   ".##..##.#####..######...##...##..##.##..##.##.....";
echo 	   ".##..##.##..##..........##...##..##.##..##.##.....";
echo 	   "..####..##..##..........##....####...####..######.";
echo 	   "..................................................";
echo.
%cecho%            Android version: {0a}!release!{#}                     {03}by JamFlux{#}
echo.
echo.
echo            *****************************************************
%cecho% *          Working with {0b}!format!{#} A/B ROM: 
echo.
%cecho% *          {0b}!filename!{#}
echo.
echo            *****************************************************
echo.
echo.
echo.
%cecho% *          Done, see: {0a}1-Finish{#} folder
echo.
call :Limpieza
TIMEOUT /T 3 /nobreak > nul & cls
goto work_place


::Compression for brotli ROMs - android 8.1+
:re_brotli
cls
echo.
echo.
echo 	   ".##..##.#####.........######..####...####..##.....";
echo 	   ".##..##.##..##..........##...##..##.##..##.##.....";
echo 	   ".##..##.#####..######...##...##..##.##..##.##.....";
echo 	   ".##..##.##..##..........##...##..##.##..##.##.....";
echo 	   "..####..##..##..........##....####...####..######.";
echo 	   "..................................................";
echo.
%cecho%            Android version: {0a}!release!{#}                     {03}by JamFlux{#}
echo.
echo.
echo            *****************************************************
%cecho% *          Working with {0b}!format!{#} ROM: 
echo.
%cecho% *          {0b}!filename!{#}
echo.
echo            *****************************************************
echo.
echo.
echo.
%cecho% *          Compressing to: {0a}!format!{#} format...
echo.
ext2simg -v %UNPACKDIR%\2-New_system\system_ext4.img %UNPACKDIR%\2-New_system\system.img >nul
TIMEOUT /T 3 /nobreak >nul
if exist %UNPACKDIR%\2-New_system\vendor_ext4.img ext2simg -v %UNPACKDIR%\2-New_system\vendor_ext4.img %UNPACKDIR%\2-New_system\vendor.img >nul
TIMEOUT /T 3 /nobreak >nul
simg2sdat %UNPACKDIR%\2-New_system\system.img %UNPACKDIR%\2-New_system >nul
TIMEOUT /T 3 /nobreak >nul
if exist %UNPACKDIR%\2-New_system\vendor.img simg2sdat %UNPACKDIR%\2-New_system\vendor.img %UNPACKDIR%\2-New_system >nul
TIMEOUT /T 3 /nobreak >nul
call :Just_Touch
brotli.exe -6 -j -w 24 %UNPACKDIR%\2-New_system\system.new.dat >nul 2>nul
TIMEOUT /T 3 /nobreak >nul
brotli.exe -6 -j -w 24 %UNPACKDIR%\2-New_system\vendor.new.dat >nul 2>nul
TIMEOUT /T 3 /nobreak >nul
if exist %UNPACKDIR%\2-New_system\system_ext4.img !busybox! rm -rf %UNPACKDIR%\2-New_system\system_ext4.img
if exist %UNPACKDIR%\2-New_system\vendor_ext4.img !busybox! rm -rf %UNPACKDIR%\2-New_system\vendor_ext4.img
cls
echo.
echo.
echo 	   ".##..##.#####.........######..####...####..##.....";
echo 	   ".##..##.##..##..........##...##..##.##..##.##.....";
echo 	   ".##..##.#####..######...##...##..##.##..##.##.....";
echo 	   ".##..##.##..##..........##...##..##.##..##.##.....";
echo 	   "..####..##..##..........##....####...####..######.";
echo 	   "..................................................";
echo.
%cecho%            Android version: {0a}!release!{#}                     {03}by JamFlux{#}
echo.
echo.
echo            *****************************************************
%cecho% *          Working with {0b}!format!{#} ROM: 
echo.
%cecho% *          {0b}!filename!{#}
echo.
echo            *****************************************************
echo.
echo.
echo.
%cecho% *          Done, see: {0a}1-Finish{#} folder
echo.
call :Limpieza
TIMEOUT /T 3 /nobreak > nul & cls
goto work_place


::Simple re-packing function for .dat compression
:re_pack_dat
cls
echo.
echo.
echo 	   ".##..##.#####.........######..####...####..##.....";
echo 	   ".##..##.##..##..........##...##..##.##..##.##.....";
echo 	   ".##..##.#####..######...##...##..##.##..##.##.....";
echo 	   ".##..##.##..##..........##...##..##.##..##.##.....";
echo 	   "..####..##..##..........##....####...####..######.";
echo 	   "..................................................";
echo.
%cecho%            Android version: {0a}!release!{#}                     {03}by JamFlux{#}
echo.
echo.
echo            *****************************************************
%cecho% *          Working with {0b}!format!{#} ROM: 
echo.
%cecho% *          {0b}!filename!{#}
echo.
echo            *****************************************************
echo.
echo.
echo.
%cecho% *          Repacking to: {0a}!format!{#} format...
echo.
ext2simg -v %UNPACKDIR%\2-New_system\system_ext4.img %UNPACKDIR%\2-New_system\system.img >nul
TIMEOUT /T 3 /nobreak >nul
if exist %UNPACKDIR%\2-New_system\vendor_ext4.img ext2simg -v %UNPACKDIR%\2-New_system\vendor_ext4.img %UNPACKDIR%\2-New_system\vendor.img >nul
TIMEOUT /T 3 /nobreak >nul
simg2sdat %UNPACKDIR%\2-New_system\system.img %UNPACKDIR%\2-New_system >nul
TIMEOUT /T 3 /nobreak >nul
if exist %UNPACKDIR%\2-New_system\vendor.img simg2sdat %UNPACKDIR%\2-New_system\vendor.img %UNPACKDIR%\2-New_system >nul
TIMEOUT /T 3 /nobreak >nul
call :Just_Touch
if exist %UNPACKDIR%\2-New_system\system_ext4.img !busybox! rm -rf %UNPACKDIR%\2-New_system\system_ext4.img >nul
cls
echo.
echo.
echo 	   ".##..##.#####.........######..####...####..##.....";
echo 	   ".##..##.##..##..........##...##..##.##..##.##.....";
echo 	   ".##..##.#####..######...##...##..##.##..##.##.....";
echo 	   ".##..##.##..##..........##...##..##.##..##.##.....";
echo 	   "..####..##..##..........##....####...####..######.";
echo 	   "..................................................";
echo.
%cecho%            Android version: {0a}!release!{#}                     {03}by JamFlux{#}
echo.
echo.
echo            *****************************************************
%cecho% *          Working with {0b}!format!{#} ROM: 
echo.
%cecho% *          {0b}!filename!{#}
echo.
echo            *****************************************************
echo.
echo.
echo.
%cecho% *          Done, see: {0a}1-Finish{#} folder
echo.
call :Limpieza
TIMEOUT /T 3 /nobreak > nul & cls
goto work_place


::Repacking into stock ext4 raw image
:Repack_IMG
cls
echo.
echo.
echo 	   ".##..##.#####.........######..####...####..##.....";
echo 	   ".##..##.##..##..........##...##..##.##..##.##.....";
echo 	   ".##..##.#####..######...##...##..##.##..##.##.....";
echo 	   ".##..##.##..##..........##...##..##.##..##.##.....";
echo 	   "..####..##..##..........##....####...####..######.";
echo 	   "..................................................";
echo.
%cecho%            Android version: {0a}!release!{#}                     {03}by JamFlux{#}
echo.
echo.
echo            *****************************************************
%cecho% *          Working with {0b}!format!{#} ROM: 
echo.
%cecho% *          {0b}!filename!{#}
echo.
echo            *****************************************************
echo.
echo.
echo.
%cecho% *          Done, see: {0a}1-Finish{#} folder
echo.
call :Limpieza
TIMEOUT /T 3 /nobreak > nul
goto work_place



::It's needed for some reason...
:Just_Touch
!busybox! touch %UNPACKDIR%\2-New_system\system.new.dat
TIMEOUT /T 3 /nobreak > nul
if exist %UNPACKDIR%\2-New_system\vendor.new.dat !busybox! touch %UNPACKDIR%\2-New_system\vendor.new.dat
TIMEOUT /T 3 /nobreak > nul
goto:eof



::Cleaning directories and non needed files
:Limpieza
if not exist 1-Finish mkdir 1-Finish
move /y %UNPACKDIR%\2-New_system\system.new.dat.br 1-Finish >nul 2>nul
move /y %UNPACKDIR%\2-New_system\system.new.dat 1-Finish >nul 2>nul
move /y %UNPACKDIR%\2-New_system\system_ext4.img 1-Finish\system.img >nul 2>nul
move /y %UNPACKDIR%\2-New_system\system.transfer.list 1-Finish >nul 2>nul
move /y %UNPACKDIR%\2-New_system\vendor.new.dat.br 1-Finish >nul 2>nul
move /y %UNPACKDIR%\2-New_system\vendor.new.dat 1-Finish >nul 2>nul
move /y %UNPACKDIR%\2-New_system\vendor_ext4.img 1-Finish\vendor.img >nul 2>nul
move /y %UNPACKDIR%\2-New_system\vendor.transfer.list 1-Finish >nul 2>nul
move /y %UNPACKDIR%\1-Sources\boot.img 1-Finish >nul 2>nul
move /y %UNPACKDIR%\1-Sources\file_contexts 1-Finish >nul 2>nul
move /y %UNPACKDIR%\1-Sources\original_symlinks 1-Finish >nul 2>nul
move /y %UNPACKDIR%\1-Sources\original_permissions 1-Finish >nul 2>nul
if exist "%UNPACKDIR%" rmdir /q /s "%UNPACKDIR%" >nul 2>nul
goto:eof


::--->Thanks to assayyed for his knowledge
:write_sys_symlinks
	if not exist "%UNPACKDIR%\1-Sources\symlinks" for /f "delims=" %%a in ('find "%UNPACKDIR%/system" -type l ^| !busybox! sed "s/%UNPACKDIR%//"') do (
		for /f "delims=" %%b in ('!busybox! readlink %UNPACKDIR%%%a') do echo symlink("%%b", "%%a";;;| !busybox! sed "s/;;;/);/">>%UNPACKDIR%\1-Sources\symlinks
	)
	for /f "delims=" %%a in ('echo "%cd%" ^| !busybox! cut -d":" -f1') do set drive_up=%%a
	for /f "delims=" %%a in ('echo "%cd%"^| !busybox! cut -d":" -f2') do set second=%%a
	set drive_low=!drive_up!
	for %%b in (a b c d e f g h i j k l m n o p q r s t u v w x y z) DO SET drive_low=!drive_low:%%b=%%b!
	for /f "delims=" %%a in ('echo \cygdrive\!drive_low!!second!\%UNPACKDIR%\system^| !busybox! tr \\ /') do set rm1=%%a
	for /f "delims=" %%a in ('echo \cygdrive\!drive_up!!second!\%UNPACKDIR%\system^| !busybox! tr \\ /') do set rm2=%%a
	set rm1=!rm1:/=\/!
	set rm2=!rm2:/=\/!
	set rm1=!rm1:"=!
	set rm2=!rm2:"=!
	set symlink_test=0
	for /f "delims=" %%a in ('!busybox! grep -cw "symlink" %UNPACKDIR%/1-Sources/symlinks') do set symlink_test=%%a
	if exist "%UNPACKDIR%\system\app_process64" (
		!busybox! sed -i '/^symlink("app_process32", "\/system\//app_process"/d' %UNPACKDIR%/1-Sources/symlinks
		!busybox! sed -i '/^symlink("dalvikvm32", "\/system\//dalvikvm"/d' %UNPACKDIR%/1-Sources/symlinks
	)
:second
start patchsyms.bat >nul
TIMEOUT /T 5 /nobreak > NUL
:third
if exist "%UNPACKDIR%\1-Sources\symlinks" !busybox! sort -u < "%UNPACKDIR%/1-Sources/symlinks" >> "%UNPACKDIR%/1-Sources/original_symlinks"
goto:eof


:write_vendor_symlinks
	if not exist "%UNPACKDIR%\1-Sources\symlinks" for /f "delims=" %%a in ('find %UNPACKDIR%/vendor -type l ^| !busybox! sed "s/%UNPACKDIR%//"') do (
		for /f "delims=" %%b in ('!busybox! readlink %UNPACKDIR%%%a') do echo symlink("%%b", "%%a";;;| !busybox! sed "s/;;;/);/">>%UNPACKDIR%\1-Sources\vendor_symlinks
	)
	for /f "delims=" %%a in ('echo "%cd%" ^| !busybox! cut -d":" -f1') do set drive_up=%%a
	for /f "delims=" %%a in ('echo "%cd%"^| !busybox! cut -d":" -f2') do set second=%%a
	set drive_low=!drive_up!
	for %%b in (a b c d e f g h i j k l m n o p q r s t u v w x y z) DO SET drive_low=!drive_low:%%b=%%b!
	for /f "delims=" %%a in ('echo \cygdrive\!drive_low!!second!\%UNPACKDIR%\vendor^| !busybox! tr \\ /') do set rm1=%%a
	for /f "delims=" %%a in ('echo \cygdrive\!drive_up!!second!\%UNPACKDIR%\vendor^| !busybox! tr \\ /') do set rm2=%%a
	set rm1=!rm1:/=\/!
	set rm2=!rm2:/=\/!
	set rm1=!rm1:"=!
	set rm2=!rm2:"=!
	set symlink_test=0
	for /f "delims=" %%a in ('!busybox! grep -cw "symlink" %UNPACKDIR%/1-Sources/vendor_symlinks') do set symlink_test=%%a
	if exist "%UNPACKDIR%\vendor\app_process64" (
		!busybox! sed -i '/^symlink("app_process32", "\/vendor\//app_process"/d' %UNPACKDIR%/1-Sources/vendor_symlinks
		!busybox! sed -i '/^symlink("dalvikvm32", "\/vendor\//dalvikvm"/d' %UNPACKDIR%/1-Sources/vendor_symlinks
	)
:second
start v_patchsyms.bat >nul
TIMEOUT /T 5 /nobreak > NUL
:third
if exist "%UNPACKDIR%\1-Sources\vendor_symlinks" !busybox! sort -u < "%UNPACKDIR%/1-Sources/symlinks" >> "%UNPACKDIR%/1-Sources/original_vendor_symlinks"
goto:eof


:write_sys_permissions
	!busybox! sed 's/--//g' %UNPACKDIR%\1-Sources\file_contexts | !busybox! grep "^/system/" | !busybox! sort > %UNPACKDIR%\1-Sources\system_contexts
	!busybox! sed 's/\\\././g; s/\\\+/+/g; s/(\/\.\*)?//g; s/\.\*//g; s/(\.\*)//g' %UNPACKDIR%\1-Sources\system_contexts | gawk "{ print $1, $NF }" | !busybox! sort > %UNPACKDIR%\1-Sources\system_contexts2
	!busybox! mv %UNPACKDIR%\1-Sources\system_contexts2 %UNPACKDIR%\1-Sources\system_contexts
	if exist "%UNPACKDIR%/1-Sources/file_contexts" for /f "delims=" %%f in ('!busybox! cat "metadata.txt" ^| !busybox! cut -d"""" -f2') do (
		set replace=no
		for /f "delims=" %%a in ('!busybox! grep -m 1 "%%f " %UNPACKDIR%\1-Sources\system_contexts ^| gawk "{ print $NF }"') do set replace=%%a
		if "!replace!"=="no" set replace=u:object_r:system_file:s0
		if exist "%UNPACKDIR%%%f" !busybox! grep -w '"%%f"' bins/metadata.txt | !busybox! sed "s/REPLACE_HERE/!replace!/">>%UNPACKDIR%\1-Sources\rom_permissions
	)
	for /f "delims=" %%a in ('type %UNPACKDIR%\1-Sources\system_contexts') do (
		for /f "delims=" %%b in ('echo %%a ^| gawk "{print $1}"') do set file2=%%b
		for /f "delims=" %%b in ('echo %%a ^| gawk "{print $NF}"') do set contexts=%%b
		for /f "delims=" %%v in ('!busybox! grep -cw '"!file2!"' %UNPACKDIR%/1-Sources/rom_permissions') do set check=%%v
		for /f "delims=" %%z in ('echo !file2!') do if "!check!"=="0" if not exist "%UNPACKDIR%\system\%%~nz" if exist "%UNPACKDIR%!file2!" echo set_metadata("!file2!", "capabilities", 0x0, "selabel", "!contexts!";;; | !busybox! sed "s/;;;/);/">>%UNPACKDIR%\1-Sources\rom_permissions
		for /f "delims=" %%z in ('echo !file2!') do if exist "%UNPACKDIR%\system\%%~nz" echo set_metadata("!file2!", "uid", 0, "gid", 2000, "mode", 0755, "capabilities", 0x0, "selabel", "!contexts!";;; | !busybox! sed "s/;;;/);/">>%UNPACKDIR%\1-Sources\rom_permissions
	)
	if exist "%UNPACKDIR%/1-Sources/file_contexts" (
		dos2unix -q %UNPACKDIR%\1-Sources\rom_permissions
		!busybox! sed -i -e "s/); /);/g" %UNPACKDIR%/1-Sources/rom_permissions
		!busybox! sort -u < %UNPACKDIR%/1-Sources/rom_permissions >> %UNPACKDIR%/1-Sources/permissions_sorted
		!busybox! grep "set_metadata_recursive" %UNPACKDIR%/1-Sources/permissions_sorted >> %UNPACKDIR%/1-Sources/recursive
		!busybox! grep -v "set_metadata_recursive" %UNPACKDIR%/1-Sources/permissions_sorted >> %UNPACKDIR%/1-Sources/not_recursive
		!busybox! cat %UNPACKDIR%/1-Sources/not_recursive >> %UNPACKDIR%/1-Sources/recursive
		type %UNPACKDIR%\1-Sources\recursive >> %UNPACKDIR%\1-Sources\original_permissions
	)
	goto:eof
::Till here<---


:Detect_vendor_size
FOR %%B IN ("%UNPACKDIR%\1-Sources"\vendor.img) DO SET VSIZE=%%~zB
goto:eof

:Detect_system_size
FOR %%A IN ("%UNPACKDIR%\1-Sources"\system.img) DO SET SIZE=%%~zA
::for %%A in (%peso%) do if %%~zA==0 (goto Peso_w10) else (goto:eof)
goto:eof

:img_extractor
IF EXIST %UNPACKDIR%\1-Sources\system.img (
"%imgextractor%" %UNPACKDIR%\1-Sources\system.img %UNPACKDIR%\system > nul
if exist %UNPACKDIR%\system_statfile.txt move /y %UNPACKDIR%\system_statfile.txt %UNPACKDIR%\1-Sources\fs_config >nul 2>nul
)
goto:eof

:Remove_pics_with_spaces
for /R %%j in (*.png*) do (
set filename=%%~nj
set filename=!filename:.=_!
set filename=!filename: =_!
if not "!filename!"=="%%~nj" del "%%j" > nul
)
for /R %%k in (*.jpg*) do (
set filename=%%~nk
set filename=!filename:.=_!
set filename=!filename: =_!
if not "!filename!"=="%%~nk" del "%%k" > nul
)
goto:eof

:no_fs_config
cls
echo.
echo.
echo 	   ".##..##.#####.........######..####...####..##.....";
echo 	   ".##..##.##..##..........##...##..##.##..##.##.....";
echo 	   ".##..##.#####..######...##...##..##.##..##.##.....";
echo 	   ".##..##.##..##..........##...##..##.##..##.##.....";
echo 	   "..####..##..##..........##....####...####..######.";
echo 	   "..................................................";
echo.
%cecho%            Android version: {0a}!release!{#}                     {03}by JamFlux{#}
echo.
echo.
echo            *****************************************************
%cecho% *          Working with {0b}!format!{#} ROM: 
echo.
%cecho% *          {0b}!filename!{#}
echo.
echo            *****************************************************
echo.
echo.
echo.
%cecho% *          Repacking to: {0a}!format!{#} format...
echo.
if exist %UNPACKDIR%\2-New_system rmdir /q /s %UNPACKDIR%\2-New_system >nul
if not exist %UNPACKDIR%\2-New_system mkdir %UNPACKDIR%\2-New_system >nul
make_ext4fs -L system -T 2009110000 -S %UNPACKDIR%\1-Sources\file_contexts -l %SIZE% -a system %UNPACKDIR%\2-New_system\system_ext4.img %UNPACKDIR%\system\ >nul 2>nul
goto decide_format


:no_fs_config_AB
cls
echo.
echo.
echo 	   ".##..##.#####.........######..####...####..##.....";
echo 	   ".##..##.##..##..........##...##..##.##..##.##.....";
echo 	   ".##..##.#####..######...##...##..##.##..##.##.....";
echo 	   ".##..##.##..##..........##...##..##.##..##.##.....";
echo 	   "..####..##..##..........##....####...####..######.";
echo 	   "..................................................";
echo.
%cecho%            Android version: {0a}!release!{#}                     {03}by JamFlux{#}
echo.
echo.
echo            *****************************************************
%cecho% *          Working with {0b}!format!{#} ROM: 
echo.
%cecho% *          {0b}!filename!{#}
echo.
echo            *****************************************************
echo.
echo.
echo.
%cecho% *          Repacking to: {0a}!format!{#} format...
echo.
if exist %UNPACKDIR%\2-New_system rmdir /q /s %UNPACKDIR%\2-New_system >nul
if not exist %UNPACKDIR%\2-New_system mkdir %UNPACKDIR%\2-New_system >nul
make_ext4fs -L system -T 2009110000 -S %UNPACKDIR%\1-Sources\file_contexts -l %SIZE% -a system %UNPACKDIR%\2-New_system\system_ext4.img %UNPACKDIR%\system\ >nul 2>nul
goto decide_format2


:zipalign
:: Batch file to recursively zip align *.apk files in a directory
:: and its sub-directories. This is significantly easier and faster
:: than manually zip aligning them.
cls
echo.
echo.
echo 	   ".##..##.#####.........######..####...####..##.....";
echo 	   ".##..##.##..##..........##...##..##.##..##.##.....";
echo 	   ".##..##.#####..######...##...##..##.##..##.##.....";
echo 	   ".##..##.##..##..........##...##..##.##..##.##.....";
echo 	   "..####..##..##..........##....####...####..######.";
echo 	   "..................................................";
echo.
%cecho%            Android version: {0a}!release!{#}                     {03}by JamFlux{#}
echo.
echo.
echo            *****************************************************
%cecho% *          Working with {0b}!format!{#} ROM: 
echo.
%cecho% *          {0b}!filename!{#}
echo.
echo            *****************************************************
echo.
echo.
echo.
%cecho% *          {0a}Zipaligning{#} applications...
echo.
for /R %%X in (*.apk) do zipalign -f 4 "%%X" "%%~dpX%%~nX.new"
for /R %%X in (*.new) do move /Y "%%X" "%%~dpX%%~nX.apk" >nul 2>nul
goto:eof



:Exit
exit