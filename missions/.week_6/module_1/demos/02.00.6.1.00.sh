#!/bin/bash

echo "Demonstrate decision-making with if...then and if...then...else"
echo "if [ \"\$1\" = \"start\" ]; then echo 'Starting drone system'; else echo 'Invalid command'; fi"

echo "Demonstrate multiway branching with case"
echo "case \"\$1\" in"
echo "  start) echo 'Drone system starting';;"
echo "  stop) echo 'Drone system stopping';;"
echo "  *) echo 'Unknown command';;"
echo "esac"

echo "Demonstrate looping with for...in"
echo "for i in {1..5}; do echo \"Checking drone \$i\"; done"

echo "Demonstrate looping with while"
echo "count=5; while [ \$count -gt 0 ]; do echo \"Drone battery level: \$count\"; ((count--)); done"

echo "Demonstrate looping with until"
echo "count=0; until [ \$count -ge 5 ]; do echo \"Drone signal strength: \$count\"; ((count++)); done"

exec bash --rcfile $RCFILE
