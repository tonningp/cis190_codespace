#!/bin/bash

export BASE_DIR="$(dirname "$(realpath "$0")")"
echo "🚀 Installing Tools ..."

# Ensure pip is available
if ! command -v pip3 &> /dev/null; then
    echo "❌ pip not found. Please install Python and pip first."
    exit 1
fi
python3 -m pip install --quiet  --upgrade pip
pip3 install --quiet rich
pip3 install --quiet asciinema

cat <<EOF | python -m rich.markdown -
# 🛰️ Week 1 Briefing

Welcome to your first Linux mission.

- Navigate using \`cd\`
- List files with \`ls\`
- Use \`man\` to get help

Good luck, on your Linux missions.
EOF
${BASE_DIR}/.scripts/run_lecture.sh
