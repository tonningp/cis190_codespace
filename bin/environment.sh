#!/bin/bash
export content_base="missions"
function pause() {
    echo
    read -p "Press ENTER to continue..."
}

function strip_leading_numbers() {
  local filename="$1"
  # Use parameter expansion with pattern matching
  local stripped="${filename##*[0-9].}"
  
  # Match both ##. and ##.#. patterns using regex fallback
  if [[ "$filename" =~ ^[0-9]{2}(\.[0-9]+)?\.(week_.*) ]]; then
    echo "${BASH_REMATCH[2]}"
  else
    echo "$filename"  # return unchanged if pattern doesn't match
  fi
}

# Set directories
export -f pause
export -f strip_leading_numbers

export BASE_DIR=${PWD}
export PROFILE_DB="$(dirname $TOP_DIR)/.db/profile.sqlite3"

if [[ ! -f ${PROFILE_DB} ]];then
   echo 
   echo "❌ student profile not found. Please run ./bootstrap again."
   echo
   exit 1
fi
if [[ "$BASE_DIR" != *${content_base}* ]]; then
    echo "❌ Make sure to start this in the directory for the "
    echo "   week and module you are working on."
    echo "--------------------------------------------------------------------------------"
    echo "For example:"
    echo "$ cd /workspaces/codespaces-blank/cis190_codespace/missions/week_1/module_1"
    echo "$ start"
    exit 1
else
    if [[ "$BASE_DIR" == *week* && "$BASE_DIR" != *module* ]]; then
      echo "❌ You are almost there."
      echo "--------------------------------------------------------------------------------"
      ls -1
      exit 1
    fi
fi

export DEMO_DIR="$BASE_DIR/demos"
export MARKDOWN_DIR="$BASE_DIR/content"
export PROFILE_DIR="$BASE_DIR/.profile"

export VPLAYER="asciinema play -i 2.5"
export CAT_CMD='python3 -m rich.markdown -y -w 80 '
