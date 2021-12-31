@echo off
if "_%1_" == "__" goto err
pip install -U sync-ui-lib==%1
goto end
:err
echo please provide a version number to upgrade sync-ui-lib.
:end