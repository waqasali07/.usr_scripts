@echo off
set F=%1
set FILE=%F%
IF "_%SCRIPT_DIR%_" == "__" goto end
IF EXIST %SCRIPT_DIR%\%F%.bat (
set FILE=%SCRIPT_DIR%\%F%.bat
goto end
)
IF exist %SCRIPT_DIR%\.work\%F%.bat (
set FILE=%SCRIPT_DIR%\.work\%F%.bat
goto end
)
IF exist %SCRIPT_DIR%\.git\%F%.bat (
set FILE=%SCRIPT_DIR%\.git\%F%.bat
goto end
)
:end
set F=
type %FILE%
set FILE=
