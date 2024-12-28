REM Usage: jws.bat <hostname>

SET SERVER=%1

javaws "http://%SERVER%:9001/forms/frmservlet?config=hr-app"
