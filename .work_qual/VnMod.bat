@echo off
if "_%APPSDIR%_" == "__" call setapps.bat
cd /D %APPSDIR%\VnModSim_v%VNMOD_VER%
start VnModuleSim.exe
