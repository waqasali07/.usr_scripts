@echo off
if "_%1_" == "__" goto do_one
if "%1" == "/?" goto help
if "%1" == "-h" goto help

set /A i=%1%
for /L %%d in (1,1,%i%) DO cd ..
goto end
REM label version below
REM :loop
REM if %i% LEQ 0 goto end
REM cd ..
REM set /A i=%i% - 1
REM goto loop
:help
echo UP [Argument] & echo. & echo     Argument    Number of directories to move back.
echo 		If no number is provided, only one directory will be moved up
:do_one
cd ..
:end