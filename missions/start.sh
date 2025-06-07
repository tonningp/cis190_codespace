#!/bin/bash

export BASE_DIR="$(dirname "$(realpath "$0")")"
cat <<EOF | python -m rich.markdown -
# 🛰️ Week 1 Briefing

Welcome to your first Linux mission.

- Navigate using \`cd\`
- List files with \`ls\`
- Use \`man\` to get help

Good luck, on your Linux missions.
EOF
${BASE_DIR}/.scripts/run_lecture.sh
