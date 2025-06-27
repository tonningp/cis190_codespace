#!/bin/bash
## -*- coding: utf-8 -*-
source "$TOP_DIR/colors.sh"
source "$TOP_DIR/utils.sh"

export lesson_title="Searching Text with \`grep\`"
export lesson="$(cat<<EOF

**Demonstrate how to use the \`grep\` command to search for patterns in files.**

This lesson focuses on:
1. Basic pattern matching with \`grep\`
2. Case-insensitive searches
3. Showing line numbers in results
4. Searching recursively through directories
5. Using regular expressions with \`grep\`

> 🔍 \`grep\` is a powerful tool for searching through files and command output. Learn to combine options for effective searches.
EOF
)"

# Prepare a working environment
mkdir -p greptest/subdir
cat > greptest/file1.txt <<EOT
Hello world
The quick brown fox
jumps over the lazy dog
HELLO AGAIN
EOT

cp greptest/file1.txt greptest/subdir/file2.txt

# Training items
declare -g -a prompts=(
  "Search for the word 'Hello' in greptest/file1.txt using $(cyan 'grep')"
  "Search case-insensitively for 'hello' in greptest/file1.txt"
  "Show matching lines with line numbers for 'fox' in greptest/file1.txt"
  "Search recursively for 'dog' in the greptest directory"
  "Use a regular expression to find lines starting with 'The' in greptest/file1.txt"
)

declare -g -a hints=(
  "Use \`grep 'Hello' filename\`."
  "Use \`-i\` for case-insensitive search."
  "Use \`-n\` to show line numbers."
  "Use \`-r\` or \`-R\` for recursive search."
  "Use \`^The\` to match lines that start with 'The'."
)

declare -g -a patterns=(
  "grep 'Hello' greptest/file1.txt"
  "grep -i 'hello' greptest/file1.txt"
  "grep -n 'fox' greptest/file1.txt"
  "grep -r 'dog' greptest"
  "grep '^The' greptest/file1.txt"
)

declare -g -a evals=(
  1
  1
  1
  1
  1
)

source "${TOP_DIR}/lesson_manager.sh"

