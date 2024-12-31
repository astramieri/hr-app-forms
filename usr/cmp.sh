#!/bin/bash

BASE_DIR=$(dirname $(realpath $0))

source $BASE_DIR/env.sh

SRC_DIR=$BASE_DIR/../src
BIN_DIR=$BASE_DIR/../bin

mkdir -p $BIN_DIR

$FORMS_INSTANCE/bin/frmcmp.sh module_type=form module=$SRC_DIR/login.fmb output_file=$BIN_DIR/login.fmx userid=$DB_CONNECT_STRING batch=no compile_all=yes 
$FORMS_INSTANCE/bin/frmcmp.sh module_type=form module=$SRC_DIR/console.fmb output_file=$BIN_DIR/console.fmx userid=$DB_CONNECT_STRING batch=no compile_all=yes 
$FORMS_INSTANCE/bin/frmcmp.sh module_type=form module=$SRC_DIR/employee_list.fmb output_file=$BIN_DIR/employee_list.fmx userid=$DB_CONNECT_STRING batch=no compile_all=yes 
$FORMS_INSTANCE/bin/frmcmp.sh module_type=form module=$SRC_DIR/employee_edit.fmb output_file=$BIN_DIR/employee_edit.fmx userid=$DB_CONNECT_STRING batch=no compile_all=yes 

git restore $SRC_DIR/*.fmb
