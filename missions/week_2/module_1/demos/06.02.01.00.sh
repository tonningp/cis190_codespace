#!/bin/bash

echo "Demonstrate locating utilities on your Linux system."

echo "1. Use 'which' to display the path of an executable:"
echo "   which ls"
which ls

echo ""

echo "2. Use 'whereis' to locate binary, source, and manual page files:"
echo "   whereis tar"
whereis tar

exec bash --rcfile $RCFILE
