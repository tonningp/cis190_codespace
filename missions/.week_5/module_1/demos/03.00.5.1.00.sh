#!/bin/bash

echo "Demonstrate how to change your login shell to a different shell using chsh."

echo "The following command will change your login shell to /bin/dash:"
echo "chsh -s /bin/dash"

exec bash --rcfile $RCFILE
