#!/bin/bash

# Change to the directory containing this script
cd "$(dirname "$(realpath "$0")")" || exit 1

# Predefined credentials
VALID_USERNAME="student"
VALID_PASSWORD="linux123"

while true; do
    echo -n "Username: "
    read username

    echo -n "Password: "
    stty -echo
    read password
    stty echo
    echo

    if [[ "$username" == "$VALID_USERNAME" && "$password" == "$VALID_PASSWORD" ]]; then
        echo "Login successful. Welcome, $username!"
        break
    else
        echo "Login incorrect"
    fi
done
