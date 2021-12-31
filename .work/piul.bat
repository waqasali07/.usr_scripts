@echo off
if "_%1_" == "__" goto err
pip install -U sync-test-lib==%1
goto end
:err
echo please provide a version number to upgrade sync-test-lib.
:end