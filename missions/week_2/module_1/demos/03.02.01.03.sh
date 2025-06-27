#!/bin/bash
## -*- coding: utf-8 -*-
source "$TOP_DIR/colors.sh"
source "$TOP_DIR/utils.sh"

export lesson_title="Viewing Files with \`less\`"
export lesson="$(cat<<EOF

**Practice using the \`less\` command to view and navigate through files.**

This lesson focuses on:
1. Opening files with \`less\`
2. Navigating forward and backward
3. Searching for content
4. Viewing multiple files

> 🔍 \`less\` is a powerful pager program for viewing text one screen at a time.
EOF
)"

# Prepare a working environment
mkdir -p scrolltest
seq 1 100 > scrolltest/numbers.txt
cat > scrolltest/quotes.txt <<EOL
Success is not final, failure is not fatal.
The only thing we have to fear is fear itself.
To be yourself in a world that is constantly trying to make you something else is the greatest accomplishment.
EOL

# Training items
declare -g -a prompts=(
  "Use $(cyan 'less') to view the contents of scrolltest/numbers.txt"
  "While viewing with less, search for the number 42 using the slash key"
  "Scroll to the end of scrolltest/numbers.txt using the capital G key"
  "View both scrolltest/numbers.txt and scrolltest/quotes.txt at once with $(cyan 'less')"
)

declare -g -a hints=(
  "Run \`less scrolltest/numbers.txt\`"
  "Use \`/\` followed by 42 while inside less."
  "Press capital \`G\` to jump to the end."
  "You can provide multiple files to less, separated by spaces."
)

declare -g -a patterns=(
  "less scrolltest/numbers.txt"
  "less scrolltest/numbers.txt"
  "less scrolltest/numbers.txt"
  "less scrolltest/numbers.txt scrolltest/quotes.txt"
)

declare -g -a evals=(
  1
  "2@echo 'Search for 42 inside less using /42'"
  "2@echo 'Scroll to bottom of file using G inside less'"
  1
)

source "${TOP_DIR}/lesson_manager.sh"

