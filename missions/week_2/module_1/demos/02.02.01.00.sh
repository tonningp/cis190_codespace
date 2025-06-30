#!/bin/bash
## -*- coding: utf-8 -*-
source "$TOP_DIR/colors.sh"
source "$TOP_DIR/utils.sh"

#TRAINING_SHELL=true
lesson_title="Special Characters in the Shell"
export lesson="$(cat<<EOF

**In this lesson, you will demonstrate how special characters function in the shell and how to quote them correctly.**

This is an especially important topic for understanding shell scripting and command line usage.

1. The following are special characters in the shell:

    $(backticks_3)& ; | * ? ' \ [ ] ( ) $ < > { } # / \\ ! ~$(backticks_3)

1. Whitespace characters like RETURN, SPACE, and TAB are also interpreted specially.
1. In this lesson, you will demonstrate quoting special characters:
   - Using a backslash to escape a special character:
      \`\`\`echo \\\\ is a back slash \`\`\`
   - Using single quotes to treat special characters as regular characters:
      echo 'This is a single-quoted text with a special character: * '
EOF
)"
touch a b c d
# Training items: expected commands
declare -g -a prompts=(
"Use the \`echo\` command to print a backslash"
"Use the \`echo\` command to print a * character"
"Use the \`echo\` command to print an unquoted * character"
"Use the \`echo\` command to print a ' between single quotes"
)
declare -g -a hints=(
  "Remember to escape the backslash with another backslash."
  'Use single quotes to treat * literally, otherwise it will expand what is in the current working directory.'
  "This will print the * character as is, without any special meaning."
  "Use single quotes and a backslash. "
)
declare -g -a patterns=(
  "echo \\"
  "echo '*'"
  "echo *"
  "echo '\\''"
)
declare -g -a evals=(
  1
  1
  1
  "2@echo 'This is a single-quoted text with a : '\\' '"
)

source ${TOP_DIR}/lesson_manager.sh
