@echo off
setlocal enabledelayedexpansion

set ERROR_FLAG=0

set const=1
set registinfo="HKEY_CURRENT_USER\Software\Gamfs\BrownDust II"

set root=C:\Users\Rin\.browndust2\
set acc="%root%B%const%.reg"
set config="%root%last.txt"
set log="%root%log.log"

if not exist "%root%" (
	echo Directory not found: %root%
	set ERROR_FLAG=1
	echo.
	pause
    exit /b -1
)
echo [%date% %time%] - Purging log file... > %log% 2>&1
REM config file handle
echo [%date% %time%] - checking config file...>> %log% 2>&1
if not exist "%config%" (
	echo %const% > "%config%"
	echo [%date% %time%] - Config file not found, create with default value %const% >> %log% 2>&1
)
for /f %%a in ('type %config%') do set value=%%a
echo [%date% %time%] - the config value is: !value!, the const is %const% >> %log% 2>&1


if "%value%" == "%const%" (
	echo [%date% %time%] - the registry account is current, try to start program direcly... >> %log% 2>&1
	goto :startProgram
) else (
	call :exportREG !value!
	goto :startProgram
)


:startProgram
if !errorlevel! EQU 0 if !ERROR_FLAG! EQU 0 (
	echo [%date% %time%] - Start program... >> %log% 2>&1
	C:\ProgramData\Neowiz\Browndust2Starter\Browndust2Starter.exe browndust2:games/10000001?usn=0
	echo [%date% %time%] - Program started >> %log% 2>&1
) else (
	echo [%date% %time%] - An error occurred, program not started >> %log% 2>&1
)

echo. >> %log% 2>&1
goto :eof


:exportREG
REM backup account in registry
echo [%date% %time%] - the registry account is B%1, switch to B%const%...  >> %log% 2>&1
set regFile="%root%B%1.reg"
echo [%date% %time%] - the registry will be export as: !regFile!  >> %log% 2>&1
if exist !regFile! (
	echo [%date% %time%] - regFile !regFile! already exists, deleting... >> %log% 2>&1
	del /f !regFile! >> %log% 2>&1
	echo [%date% %time%] - regFile !regFile! deleted successfully. >> %log% 2>&1
)
REG EXPORT %registinfo% !regFile!  >> %log% 2>&1
if !errorlevel! neq 0 (
	echo [%date% %time%] - regFile !regFile! export Failed. >> %log% 2>&1
	set ERROR_FLAG=1
) else (
	echo [%date% %time%] - regFile !regFile! export Successful. >> %log% 2>&1
)
REM import account info to registry
echo [%date% %time%] - check account info to be imported... %acc% >> %log% 2>&1
if exist %acc% (
	echo [%date% %time%] - deleting the registry %registinfo% >> %log% 2>&1
	REG DELETE %registinfo% /f >> %log% 2>&1
	echo [%date% %time%] - the registry deleted Successfully... >> %log% 2>&1
	echo [%date% %time%] - try to import local account: %acc% >> %log% 2>&1
	REG IMPORT %acc% >> %log% 2>&1
	echo [%date% %time%] - Local Registry data %acc% imported... >> %log% 2>&1
) else (
	echo [%date% %time%] - account regFile %acc% not exists, seems to be a new account, will start current... >> %log% 2>&1
)
if !errorlevel! neq 0 (
	set ERROR_FLAG=1
	echo [%date% %time%] - Command execution Failed. >> %log% 2>&1
) else (
	echo [%date% %time%] - Command executed Successfully. >> %log% 2>&1
	echo [%date% %time%] - update config info... >> %log% 2>&1
	echo %const% > "%config%"
	echo [%date% %time%] - last login account changed to %const% >> %log% 2>&1
)
exit /b

pause
