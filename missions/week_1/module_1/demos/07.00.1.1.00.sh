#!/bin/bash
source ${BASE_DIR}/demos/environ.sh
clear

cat <<EOF
********************************************************************************
To check the Linux distribution:
$(cyan "cat /etc/os-release")

Exercise:
1. Type $(cyan 'cat /etc/os-release') followed by the Enter key to see the Linux
   distribution information.

NOTE: We will discuss what that file contains later
EOF

exec bash --rcfile $RCFILE
