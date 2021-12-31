@echo off
if "_%branch%_" == "__" goto error
git push --set-upstream origin %branch%
goto end
:error
echo Cannot find branch name. Branch variable is not set.
echo %branch%
:end
