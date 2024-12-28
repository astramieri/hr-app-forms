#!/bin/bash

export JAVA_HOME=/usr/java/jdk1.8.0-x64

export ORACLE_HOME=/home/oracle/FormsBuilder

export FORMS_INSTANCE=$ORACLE_HOME/instance/forms1

export SRC_DIR=/home/oracle/hr-app-forms/src
export BIN_DIR=/home/oracle/hr-app-forms/bin

export DB_STRING=hr/oracle@freepdb1

$FORMS_INSTANCE/bin/frmcmp.sh module_type=form module=$SRC_DIR/general.fmb output_file=$BIN_DIR/general.fmx userid=$DB_STRING batch=yes compile_all=yes 

git restore $SRC_DIR/general.fmb
