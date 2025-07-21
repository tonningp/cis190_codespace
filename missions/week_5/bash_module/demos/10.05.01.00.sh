#!/bin/bash -x

MODULE_NAME="Loops and Functions"
(
mkdir -p ~/drone_toolkit/flight_logs
for i in {1..5}; do
    echo "$(date) - System Ready" > ~/drone_toolkit/flight_logs/log_$i.log
done
)
source "$TOP_DIR/lesson_viewer.sh"
