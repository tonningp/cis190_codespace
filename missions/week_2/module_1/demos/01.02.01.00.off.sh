#!/bin/bash

cat << 'EOF'

********************************************************************************

Demonstrate listing special characters and methods to prevent shell interpretation.
Try creating a file named 'testfile' and then use the following to echo a dollar sign:
echo \$\$ > testfile
cat testfile
EOF

exec bash --rcfile $RCFILE
