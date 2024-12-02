#!/bin/bash

export JAVA_HOME=/usr/java/jdk1.8.0-x64

export ORACLE_HOME=/home/oracle/FormsBuilder

bash $ORACLE_HOME/instance/forms1/bin/frmcmp.sh module=departments.fmb userid=hr/oracle@freepdb1 module_type=form compile_all=yes
