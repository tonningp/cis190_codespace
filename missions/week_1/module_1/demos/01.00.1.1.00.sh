#!/bin/bash
source ${BASE_DIR}/demos/environ.sh
clear
cat <<EOF
********************************************************************************
This is the training shell for the Linux course lab manager.

In this shell, you will practice linux commands.

All work that is required is recorded in this shell.  

For this first exercise:
1. type $(yellow 'pwd') followed by the Enter key, to see your current working 
   directory.
2. Type $(yellow 'exit') followed by the Enter key.

Note, you can also press the Ctrl-D keys to exit this shell.  Hold Ctrl down and 
press D.
EOF

exec bash --rcfile $RCFILE
