#!/bin/bash

echo "Demonstrate how to use pipelines and filters to process data."

echo "Step 1: Create a sample file with some text."
echo "echo -e 'drone\ndata\nmaintenance\nsystem' > sample.txt"
echo -e 'drone\ndata\nmaintenance\nsystem' > sample.txt

echo "Step 2: Use the 'cat' command to display the contents of the file."
echo "cat sample.txt"
cat sample.txt

echo "Step 3: Use the 'sort' command to order the lines in the file."
echo "cat sample.txt | sort"
cat sample.txt | sort

echo "Step 4: Use the 'tr' command to transform text, such as converting lowercase to uppercase."
echo "cat sample.txt | tr '[:lower:]' '[:upper:]'"
cat sample.txt | tr '[:lower:]' '[:upper:]'

echo "Step 5: Combine 'tr' and 'sort' in a pipeline."
echo "cat sample.txt | tr '[:lower:]' '[:upper:]' | sort"
cat sample.txt | tr '[:lower:]' '[:upper:]' | sort

exec bash --rcfile $RCFILE
