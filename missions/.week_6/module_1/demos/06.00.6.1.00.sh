#!/bin/bash

echo "Demonstrate arithmetic expressions using 'let':"
echo "Initial VALUE is set to 5"
VALUE=5
let "VALUE=VALUE * 10 + 3"
echo "After operation VALUE * 10 + 3, VALUE is now: $VALUE"

echo "Demonstrate logical expressions using '[[' ']]':"
age=20
echo "Set age to 20"
if [[ $age -gt 18 ]]; then
  echo "Age is greater than 18, therefore: Adult"
else
  echo "Age is not greater than 18"
fi

exec bash --rcfile $RCFILE
