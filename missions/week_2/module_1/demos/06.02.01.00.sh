#!/bin/bash
# mission_template
# -*- coding: utf-8 -*-
source "$TOP_DIR/colors.sh"
source "$TOP_DIR/emojis.sh"
source "$TOP_DIR/utils.sh"

export lesson_title="Locating Commands with which and whereis"
export lesson="$(cat<<EOF

**Learn to use the \`which\` and \`whereis\` commands to locate command binaries and related files on your system.**

> $(emoji magnifying_glass) The \`which\` and \`whereis\` commands are essential for finding where executables and their associated files are located, aiding in system management and troubleshooting.

***This lesson focuses on:***

**Using whereis:**
1. Locate a Command:
   - Prompt: Use \`whereis\` to find all locations of the \`bash\` executable and its related files.
   - Skill: Basic usage of \`whereis\`.

2. Locate a Command with Source and Man Pages:
   - Prompt: Use \`whereis\` to find the locations of both executable and documentation files for \`ls\`.
   - Skill: Finding binaries, source, and man pages with \`whereis\`.

3. Locate a Command and Inspect the Output Path:
   - Prompt: Use \`whereis\` to find all related paths for \`grep\`, then check the directory from the output.
   - Skill: Navigate file paths returned by \`whereis\`.

**Using which:**
4. Identify the Executable Path:
   - Prompt: Use \`which\` to find the path of the \`python3\` interpreter.
   - Skill: Simple path retrieval for executables with \`which\`.

5. Confirm Command Presence in PATH:
   - Prompt: Use \`which\` to confirm if \`git\` is available on the system and see its installation path.
   - Skill: Verify command availability and path with \`which\`.

EOF
)"

# Prepare a working environment
mkdir -p ~/.test_environment

# Create dummy files to simulate an environment if necessary
# Example: Install git, bash extensions, or additional packages needed for testing these commands
# Skipping actual installations since this is purely an educational script

# Training items
declare -g -a prompts=(
  "Use \`whereis\` to find all locations for the \`bash\` executable and its related files."
  "Use \`whereis\` to locate the main executable, source code, and manual pages for \`ls\`."
  "Use \`whereis\` to find all related paths for \`grep\`, then navigate to one of the directories listed."
  "Use \`which\` to find the path of the \`python3\` interpreter."
  "Use \`which\` to check if \`git\` is available on your system and see its path."
)

declare -g -a hints=(
  "Use \`whereis bash\` to find its binary and related files."
  "Use \`whereis ls\` to see its executable, source, and man pages."
  "Use \`whereis grep\` and check the output paths with \`ls\` or \`cd\`."
  "Use \`which python3\` to get the location of the Python 3 executable."
  "Use \`which git\` to confirm its installation and see its linked path."
)

declare -g -a patterns=(
  "whereis bash"
  "whereis ls"
  "whereis grep"
  "which python3"
  "which git"
)

declare -g -a evals=(
  1
  1
  1
  1
  1
)

export TREE_VIEW="$(tree -C ~/.test_environment)"
source "${TOP_DIR}/lesson_manager.sh"
