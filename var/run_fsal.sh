#!/bin/bash

# Add the following parameters to application configuration section
# baseSAAfile=webutilsaa.txt
# fsalcheck=true

java -jar "../lib/frmsal.jar" -url "http://localhost:9001/forms/frmservlet?config=hr-app"