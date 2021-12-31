@echo off
if "_%1_" == "__" goto err
set /A i=%1
for /L %%d in (1,1,%i%) DO cd ..
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
