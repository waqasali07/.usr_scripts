@echo off
setlocal
if "_BRANCH_" == "__" call setbranch
set ARG=%BRANCH%
set CODE_DIR=C:\Users\wali4\Code
set ROOT_DIR=%CODE_DIR%\%ARG%
set SYNC_TESTS=git@github.ford.com:TAT/sync-tests.git
set SYNC_TEST_LIB=git@github.ford.com:TAT/sync-test-lib.git
set SYNC_UI_LIB=git@github.ford.com:TAT/sync-ui-lib.git
cd %ROOT_DIR%
virtualenv venv-%ARG%
cd %ROOT_DIR%
call gcl %SYNC_TESTS%
cd sync-tests
call requp
call :BRANCH
call gcl %SYNC_TEST_LIB%
cd sync-test-lib
call :BRANCH
call gcl %SYNC_UI_LIB%
cd sync-ui-lib
call :BRANCH
goto end
:err
echo please provide a directory name to setup repositories into.
:end
EXIT /B 0

:BRANCH
git branch %ARG%
git checkout %ARG%
cd %ROOT_DIR%
EXIT /B 0