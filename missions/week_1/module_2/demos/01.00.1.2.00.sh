#!/bin/bash

echo "Demonstrating how to use 'kill' to abort program execution using the termination signal."
echo "We will start a simple background process and then terminate it."

# Start a background process (e.g., sleep for 100 seconds)
echo "Starting a background process..."
sleep 100 &
BACKGROUND_PID=$!

echo "Background process started with PID: $BACKGROUND_PID"

# Display the list of running jobs
echo "Listing running jobs:"
jobs

# Kill the background process using the 'kill' command
echo "Terminating the background process using 'kill'..."
kill $BACKGROUND_PID

# Verify if the process has been terminated
wait $BACKGROUND_PID 2>/dev/null
if [ $? -eq 0 ]; then
  echo "The process with PID $BACKGROUND_PID has been terminated successfully."
else
  echo "Failed to terminate the process with PID $BACKGROUND_PID or it was already terminated."
fi

exec bash --rcfile $RCFILE
