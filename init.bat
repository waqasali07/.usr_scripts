@echo off
goto check_Permissions

:check_Permissions
echo Checking for Admin rights.

net session >nul 2>&1
if %errorLevel% == 0 (
    goto yes
) else (
    echo Failure: Please run the script as administrator to set system wide environment variables.
	goto no
)

:yes
call setscript.bat
call setapps.bat
call setcomp.bat
echo SCRIPT_DIR path is 
echo %SCRIPT_DIR%
setx SCRIPT_DIR %SCRIPT_DIR% /M
echo COMP_DIR path is 
echo %COMP_DIR%
setx COMP_DIR %COMP_DIR% /M
echo APPSDIR path is 
echo %APPSDIR%
setx APPSDIR %APPSDIR% /M
echo Backing up PATH environment variable
setx PATH_BAK %PATH% /M
echo Adding COMP_DIR to PATH environment variable
setx PATH "%PATH%;%COMP_DIR%" /M
echo Adding APPSDIR to PATH environment variable
setx PATH "%PATH%;%APPSDIR%" /M
echo Adding SCRIPT_DIR to PATH environment variable
setx PATH "%PATH%;%SCRIPT_DIR%" /M
echo Setup successful
:no
