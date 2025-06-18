#!/bin/bash
# check if $1 is provided
if [ -z "$1" ]; then
    echo "Usage: $0 <path_to_quiz_app_directory>"
    exit 1
fi
PYTHON_DIR="$(dirname $(realpath "$0"))"
APP_DIR=$PYTHON_DIR/quiz_app
cd $PYTHON_DIR && source venv/bin/activate
cd "${APP_DIR}" || exit 1
python main.py "$1"
