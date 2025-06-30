#!/bin/bash

echo "Demonstrate basic 'sed' usage by printing lines containing 'line' twice:"
echo "sed '/line/ p' lines"

echo "Demonstrate selective printing with 'sed' to display only lines containing 'line':"
echo "sed -n '/line/ p' lines"

echo "Demonstrate line number selection with 'sed' to print lines 3 through 6:"
echo "sed -n '3,6 p' lines"

exec bash --rcfile $RCFILE
