#!/bin/bash
# check if $1 is provided
if [ -z "$1" ]; then
    echo "Usage: $0 <path_to_quiz_app_directory>"
    exit 1
fi
APP_DIR="$(realpath "$0")/quiz_app"
cd "${APP_DIR}" || exit 1
python3 main.py "$1"
