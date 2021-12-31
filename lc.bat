@echo off

IF "_%SCRIPT_DIR%_" == "__" goto err
pushd .
cd %SCRIPT_DIR%
dir /b *.bat
cd %SCRIPT_DIR%\.work
dir /b *.bat
cd %SCRIPT_DIR%\.git
dir /b *.bat
popd
goto end
:err
echo Script directory not set.
:end
