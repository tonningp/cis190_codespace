#!/bin/bash
source ${BASE_DIR}/demos/environ.sh
clear

cat <<EOF

Demonstrate how to list all currently logged-in users.
Command: $(cyan "who")

Exercise:
1. Type $(cyan 'who') followed by the Enter key to see the list of currently 
   logged-in users.  NOTE: This command shows who is currently logged into the 
   system, but it may not show any users depending on the system's current state.

   On a typical system, you might see output like this:
    paul     pts/0        2025-06-20 08:04 (83.171.251.186)
    paul     pts/1        2025-06-20 08:06 (83.171.251.186)
EOF

exec bash --rcfile $RCFILE
