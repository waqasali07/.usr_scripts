@echo off
if "_%1_" == "__" goto err
git merge %1
goto end
:err
echo no branch name provided
:end