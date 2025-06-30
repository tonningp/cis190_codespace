#!/bin/bash

echo "Demonstrate how to list background jobs using the 'jobs' command."
echo "jobs"

echo "Demonstrate how to move a job to the foreground using the 'fg' command."
echo "fg %1  # Replace %1 with the job number to bring it to the foreground."

echo "Demonstrate how to move a job to the background using the 'bg' command."
echo "bg %1  # Replace %1 with the job number to resume it in the background."

echo "Demonstrate how to suspend a job using CONTROL-Z."
echo "Press CONTROL-Z while a job is running to suspend it."

exec bash --rcfile $RCFILE
