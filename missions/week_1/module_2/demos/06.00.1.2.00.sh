#!/bin/bash
source $BASE_DIR/demos/environ.sh
clear
cat <<EOS
 Demonstrating how to use root privileges with su and sudo.

 Using 'sudo' to execute a command with your password:
 \$ $(cyan 'sudo whoami')

 Run whoami without sudo to see the current user:
\$ $(cyan whoami)
EOS

exec bash --rcfile $RCFILE
