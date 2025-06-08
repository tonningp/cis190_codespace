function pause() {
    echo
    read -p "Press ENTER to continue..."
}
# Set directories
export -f pause
export VPLAYER="asciinema play -i 2.5"
export CAT_CMD='python3 -m rich.markdown -y'

export DEMO_DIR="$BASE_DIR/demos"
export MARKDOWN_DIR="$BASE_DIR/content"
export PROFILE_DIR="$BASE_DIR/.profile"
