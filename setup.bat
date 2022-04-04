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
set INSTALL_DIR=%CD%
echo Setting up %CD% as script path
call setscript.bat
set /P GH="Do you want to install .github dir [y/n]? "
if "%GH%" == "n" goto ng
set GH_DIR=%INSTALL_DIR%\.github
echo Setting up %GH_DIR% as github script path
:ng
set /P WORK="Do you want to install .work dir [y/n]? "
if "%WORK%" == "n" goto nw
call ld .w*
set /P WORK="Enter the work dir? "
set WRK_DIR=%INSTALL_DIR%\%WORK%
echo Setting up %WRK_DIR% as work script path
:nw
set /P APPS="Do you want to install portable apps dir [y/n]? "
if "%APPS%" == "n" goto na
set /P APPS_DIR="Enter the portable apps dir : "
:na
echo Adding following directories to path
echo SCRIPT_DIR = %SCRIPT_DIR%
echo GH_Dir = %GH_DIR%
echo WRK_DIR = %WRK_DIR%
echo APPS_DIR = %APPS_DIR%
powershell .\setup.ps1 '%SCRIPT_DIR%' '%GH_DIR%' '%WRK_DIR%' '%APPS_DIR%'
:no
echo Bye!