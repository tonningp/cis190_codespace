#!/bin/bash
## -*- coding: utf-8 -*-
source "$TOP_DIR/colors.sh"
source "$TOP_DIR/utils.sh"

export lesson_title="Sorting and Filtering with \`sort\` and \`uniq\`"
export lesson="$(cat<<EOF

**Learn how to organize and deduplicate text using \`sort\` and \`uniq\`.**

This lesson focuses on:
1. Sorting file contents alphabetically or numerically
2. Reversing sort order
3. Removing duplicate lines from sorted files using \`uniq\`

> 🧠 Use \`sort\` before \`uniq\` — \`uniq\` only removes *adjacent* duplicate lines.
EOF
)"

# Prepare a working environment
mkdir -p datalist
cat > datalist/fruits.txt <<EOL
banana
apple
apple
orange
banana
grape
grape
EOL

# Training items
declare -g -a prompts=(
  "Use $(cyan 'sort') to alphabetically sort datalist/fruits.txt"
  "Use $(cyan 'sort -r') to reverse sort datalist/fruits.txt"
  "Use $(cyan 'sort -u') to sort and remove duplicates from datalist/fruits.txt"
  "Use $(cyan 'sort datalist/fruits.txt | uniq') to remove duplicate lines"
  "Use $(cyan 'uniq') with sorted input to display unique lines"
  "Use $(cyan 'uniq -c') with sorted input to count occurrences of each line"
)

declare -g -a hints=(
  "Try basic alphabetical sort first."
  "Use \`-r\` to reverse sort order."
  "The \`-u\` flag both sorts and removes duplicates."
  "Pipe \`sort\` into \`uniq\` to remove duplicates."
  "\`uniq\` requires sorted input to work correctly."
  "Use \`-c\` to prefix lines with the number of times they occur."
)

declare -g -a patterns=(
  "sort datalist/fruits.txt"
  "sort -r datalist/fruits.txt"
  "sort -u datalist/fruits.txt"
  "sort datalist/fruits.txt | uniq"
  "uniq"
  "uniq -c"
)

declare -g -a evals=(
  1
  1
  1
  1
  "2@sort datalist/fruits.txt | uniq"
  "2@sort datalist/fruits.txt | uniq -c"
)

source "${TOP_DIR}/lesson_manager.sh"

