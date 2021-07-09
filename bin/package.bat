@echo off
echo.
echo clean and package project
echo.

%~d0
cd %~dp0

cd ../work_rest
call mvn clean package -Dmaven.test.skip=true

pause