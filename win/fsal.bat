REM Usage: fsal.bat <hostname>

SET SERVER=%1

SET BASE_DIR=%~dp0
SET BASE_DIR=%BASE_DIR:~0,-1%

java -jar "%BASE_DIR%\..\lib\frmsal.jar" -url "http://%SERVER%:9001/forms/frmservlet?config=hr-app"
