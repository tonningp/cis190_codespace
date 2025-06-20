#!/bin/bash

echo "Demonstrate how to list running virtual machines and their statuses."

echo "To list running virtual machines and their statuses, you can use the following command:"
echo "virsh list"

exec bash --rcfile $RCFILE
