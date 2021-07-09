@echo off
echo.
echo run web project
echo.

cd %~dp0
cd ../work_rest/target

set JAVA_OPTS=-Xms256m -Xmx1024m -XX:MetaspaceSize=128m -XX:MaxMetaspaceSize=512m

java -jar %JAVA_OPTS% ruoyi-work_rest.jar

cd bin
pause