#!/bin/bash

TARGET_DIR="${1:-.}"  # Default to current directory

cd "$TARGET_DIR" || {
  echo "❌ Cannot enter directory: $TARGET_DIR"
  exit 1
}

# Match files of the form NN.weekX
shopt -s nullglob
FILES=( [0-9][0-9].week* )

# Sort by name, extract suffixes
declare -a SUFFIXES
for file in "${FILES[@]}"; do
  suffix="${file#??.}"  # Remove first 3 chars (NN.)
  SUFFIXES+=("$suffix")
done

# Renumber and rename
counter=0
for suffix in "${SUFFIXES[@]}"; do
  old_file_glob="[0-9][0-9].$suffix"
  old_file=$(ls $old_file_glob 2>/dev/null | head -n 1)
  new_name=$(printf "%02d.%s" "$counter" "$suffix")

  if [[ "$old_file" != "$new_name" ]]; then
    echo "🔄 Renaming $old_file → $new_name"
    mv "$old_file" "$new_name"
  fi

  ((counter++))
done
