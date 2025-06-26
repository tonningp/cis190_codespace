#!/bin/bash
## -*- coding: utf-8 -*-
source "${TOP_DIR}/utils.sh"
SCRIPTED=1
export HOME=$(pwd)
echo "locale: $(locale)"
printf "📛 enter something\n"

display_lesson "$(cat << EOF
Demonstrate how special characters function in the shell and how to quote them correctly.

This is an especially important topic for understanding shell scripting and command line usage.

1. List special characters in the shell:
    & ; | * ? ' \ [ ] ( ) $ < > { } # / \\ ! ~

2. Show how whitespace characters like RETURN, SPACE, and TAB are interpreted specially.

3. Demonstrate quoting special characters:
   a. Using a backslash to escape a special character:
      echo This is a backslash: \\
   b. Using single quotes to treat special characters as regular characters:
      echo 'This is a single-quoted text with special characters: & ; | * ? '
EOF
)"

# Training items: expected commands
declare -a -g PROMPTS=(
  "Type this command to echo a backslash"
  "Type this command to quote special characters"
)

declare -a -g EXPECTED=(
  'echo This is a backslash: \\'
  'echo '\''This is a single-quoted text with special characters: & ; | * ? '\'''
)
do_training
echo "Training completed successfully."
exec bash --rcfile $RCFILE
