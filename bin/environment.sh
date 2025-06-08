#!/bin/bash
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

export VPLAYER="asciinema play -i 2.5"
export CAT_CMD='python3 -m rich.markdown -y -w 80 '

export DEMO_DIR="$BASE_DIR/demos"
export MARKDOWN_DIR="$BASE_DIR/content"
export PROFILE_DIR="$BASE_DIR/.profile"
