#!/bin/bash

BASE_DIR=$(dirname $(realpath $0))

java -jar $BASE_DIR/../lib/frmsal.jar -url "http://localhost:9001/forms/frmservlet?config=hr-app"