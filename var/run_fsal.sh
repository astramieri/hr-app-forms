REM Add the following parameters to application configuration section
REM baseSAAfile=webutilsaa.txt
REM fsalcheck=true

REM Oracle Forms Stand Alone Launcher (FSAL)
java -jar "../lib/frmsal.jar" -url "http://localhost:9001/forms/frmservlet?config=hr-app"