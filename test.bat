@echo off
REM set PSModulePath=%PSModulePath%;%SCRIPT_DIR%
REM echo %PSModulePath%
set /p in="Input : "
REM echo %in%
powershell test.ps1
REM if "_%1_" == "__" goto err
REM set /A i=%1
REM for /L %%d in (1,1,%i%) DO cd ..
goto end
:err
echo error
goto end
REM SETLOCAL 
REM CALL :Display 
REM echo The value of index is %index% 
REM EXIT /B %ERRORLEVEL% 
REM :Display 
REM SET /A index=5 
REM echo The value of index is %index% 
REM EXIT /B 0

:end
