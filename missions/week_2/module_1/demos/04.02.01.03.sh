#!/bin/bash
## -*- coding: utf-8 -*-
source "$TOP_DIR/colors.sh"
source "$TOP_DIR/utils.sh"

export lesson_title="Previewing Files with \`head\` and \`tail\`"
export lesson="$(cat<<EOF

**Practice using the \`head\` and \`tail\` commands to preview file content.**

This lesson focuses on:
1. Viewing the first few lines of a file with \`head\`
2. Viewing the last few lines of a file with \`tail\`
3. Using the \`-n\` option to specify the number of lines to show

> 📄 These commands are helpful when inspecting logs or verifying file structure without opening large files entirely.
EOF
)"

# Prepare a working environment
mkdir -p pagetest
seq 1 20 > pagetest/sample.txt

# Training items
declare -g -a prompts=(
  "Use $(cyan 'head') to display the first 10 lines of pagetest/sample.txt"
  "Use $(cyan 'head -n 5') to display the first 5 lines of pagetest/sample.txt"
  "Use $(cyan 'head -n 3') to display the first 3 lines of pagetest/sample.txt"
  "Use $(cyan 'tail') to display the last 10 lines of pagetest/sample.txt"
  "Use $(cyan 'tail -n 5') to display the last 5 lines of pagetest/sample.txt"
  "Use $(cyan 'tail -n 3') to display the last 3 lines of pagetest/sample.txt"
)

declare -g -a hints=(
  "Default \`head\` shows the first 10 lines."
  "Use \`-n\` to control how many lines are shown."
  "Remember to use the correct filename."
  "Default \`tail\` shows the last 10 lines."
  "Use \`tail -n 5\` to see the last 5 lines."
  "Try combining \`-n\` with \`tail\` for precision."
)

declare -g -a patterns=(
  "head pagetest/sample.txt"
  "head -n 5 pagetest/sample.txt"
  "head -n 3 pagetest/sample.txt"
  "tail pagetest/sample.txt"
  "tail -n 5 pagetest/sample.txt"
  "tail -n 3 pagetest/sample.txt"
)

declare -g -a evals=(
  1
  1
  1
  1
  1
  1
)

source "${TOP_DIR}/lesson_manager.sh"

