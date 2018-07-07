@echo off
echo # Starting Elasticsearch, please wait ...
cd elasticsearch\bin
start /MIN "Elasticsearch" elasticsearch.bat
cd..\..
REM timeout 12
cd sepia-assist-server
FOR /F "delims=|" %%I IN ('DIR "tools-*.jar" /B /O:D') DO SET TOOLS_JAR=%%I
java -jar %TOOLS_JAR% connection-check httpGetJson -url=http://localhost:20724 -maxTries=25 -waitBetween=2000
echo # Starting SEPIA Assist-Server, please wait ...
start /b "SEPIA-Assist" run.bat > nul
cd..
timeout 4 > nul
echo # Starting SEPIA Chat-Server, please wait ...
cd sepia-websocket-server-java
start /b "SEPIA-Chat" run.bat > nul
cd..
timeout 2 > nul
echo # Starting SEPIA Teach-Server, please wait ...
cd sepia-teach-server
start /b "SEPIA-Teach" run.bat > nul
cd..
echo # DONE - please check the individual log-files for errors (sepia-*/log.out).
echo # NOTE: Closing this window will shutdown the SEPIA servers."