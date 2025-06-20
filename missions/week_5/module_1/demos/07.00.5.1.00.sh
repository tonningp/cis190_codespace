#!/bin/bash

echo "Demonstrate how to determine the current locale settings."
echo "Run the following command to view the current locale settings:"
echo "locale"

echo "Demonstrate how to set and display the time zone using the TZ variable."
echo "Run the following command to temporarily set the time zone to UTC and display the date:"
echo "TZ='UTC' date"

exec bash --rcfile $RCFILE
