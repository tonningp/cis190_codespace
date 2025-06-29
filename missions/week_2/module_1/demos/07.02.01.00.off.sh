#!/bin/bash

echo "Demonstrate how to monitor system usage and user activity."

echo "Show users logged into the system:"
who

echo "Display system uptime and load:"
uptime

echo "List users and their activities:"
w

exec bash --rcfile $RCFILE
