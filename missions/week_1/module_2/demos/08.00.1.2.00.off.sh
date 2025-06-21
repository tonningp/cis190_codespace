#!/bin/bash

echo "Demonstrate how to use ssh for secure remote login."
echo "ssh username@hostname"

echo "Demonstrate how to change your password securely."
echo "passwd"

exec bash --rcfile $RCFILE
