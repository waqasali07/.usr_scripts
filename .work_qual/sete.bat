@echo off
setlocal
if "_%1_" == "__" goto err
set ARG=%1
set CODE_DIR=C:\Users\wali4\Code
set ROOT_DIR=%CODE_DIR%\%ARG%
call mcd %ROOT_DIR%
echo %ARG%>.branch
call mcd .vscode
copy %CODE_DIR%\.vscode .
cd %ROOT_DIR%
call code .
goto end
:err
echo please provide a directory name to setup repositories into.
:end
EXIT /B 0