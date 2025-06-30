#!/bin/bash

echo "Demonstrate how to create directories recursively without using mkdir -p."

function makepath() {
  echo "Checking if directory \$1 exists..."
  echo "[[ -d \"\$1\" ]] || { makepath \"\${1%/*}\" && mkdir \"\$1\"; }"
  [[ -d "$1" ]] || { makepath "${1%/*}" && mkdir "$1"; }
}

echo "Example usage of makepath function:"
echo "makepath /path/to/your/directory"

exec bash --rcfile $RCFILE
