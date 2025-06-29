#!/bin/bash

echo "Demonstrate how to dereference symbolic links using the -L option with ls."

echo "Create a symbolic link to a target file:"
echo "ln -s /path/to/target/file link"

echo "Use ls with the -lL options to show details of the target file:"
echo "ls -lL link"

echo "Use ls with the -l options to show details of the symbolic link itself:"
echo "ls -l link"

exec bash --rcfile $RCFILE
