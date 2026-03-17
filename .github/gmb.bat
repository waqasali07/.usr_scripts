@echo off
if "_%1_" == "__" goto err
git merge %*
goto end
:err
echo no branch name provided
:end