@echo off
if "_%1_" == "__" goto alt
git checkout %1
goto end
:alt
if "_%BRANCH%_" == "__" goto err
git checkout %BRANCH%
goto end
:err
echo BRANCH env not set.
:end
