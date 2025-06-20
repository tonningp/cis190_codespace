#!/bin/bash

echo "Demonstrate how to run a command in the background."
echo "Running 'sleep 30 &' will start the sleep command in the background."
sleep 30 &

echo
echo "Demonstrate how to bring a background job to the foreground."
echo "Use 'fg %1' to bring the first background job to the foreground."
# Note: The user will need to use 'jobs' to find the correct job number.

echo
echo "Demonstrate how to resume a stopped job in the background."
echo "Use 'bg %1' to resume the first stopped job in the background."
# Note: The user will need to use 'jobs' to find the correct job number.

echo
echo "Demonstrate how to terminate a job using its PID."
echo "Use 'ps' to list processes and find the PID of the sleep command."
echo "Then use 'kill <PID>' to terminate the sleep command."

exec bash --rcfile $RCFILE
