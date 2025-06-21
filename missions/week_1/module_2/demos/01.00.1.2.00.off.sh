#!/bin/bash
source $BASE_DIR/demos/environ.sh
clear

cat <<EOS

Tasks to complete:
1.  List running jobs
    $(cyan jobs)

2. Kill the background process using the 'kill' command
    kill 
EOS

cat >> $RCFILE <<EOF
echo "Demonstrating how to use 'kill' to abort program execution using the termination signal."
echo "We will start a simple background process and then terminate it."

# Start a background process (e.g., sleep for 100 seconds)
echo "Starting a background process..."
sleep 100 &

EOF

exec bash --rcfile $RCFILE
