#!/bin/bash

echo "Demonstrate how to find documentation using man and info utilities."

echo "Using man to find system documentation for the 'ls' command:"
man ls

echo "Using info for detailed documentation, especially for GNU utilities like 'coreutils':"
info coreutils

echo "Using the --help option for quick utility guidance for the 'ls' command:"
ls --help

echo "Using apropos to search for commands related to a keyword, for example, 'list':"
apropos list

exec bash --rcfile $RCFILE
