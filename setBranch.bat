@echo off
IF NOT EXIST .branch (
call :SET_BRANCH
)
set /P BRANCH=<.branch
:end
EXIT /B 0

:SET_BRANCH
Set filename=%CD%
For %%A in ("%filename%") do (
    Set Folder=%%~dpA
    Set Name=%%~nxA
)
echo %Name%>.branch
set filename=
set Folder=
set Name=
EXIT /B 0