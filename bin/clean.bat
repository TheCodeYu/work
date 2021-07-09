@echo off
echo.
echo clear project
echo.

%~d0
cd %~dp0

cd ../work_rest
call mvn clean

pause