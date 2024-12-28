#!/bin/bash

# Add the following parameters to application configuration section
# baseSAAfile=webutilsaa.txt
# fsalcheck=true

BASE_DIR=$(dirname $(realpath $0))

java -jar $BASE_DIR/../lib/frmsal.jar -url "http://localhost:9001/forms/frmservlet?config=hr-app"