@echo off
if "_%INSTALL_DIR%_" == "__" goto no
set SCRIPT_DIR=%INSTALL_DIR%
goto end
:no
set SCRIPT_DIR=%CD%
:end
