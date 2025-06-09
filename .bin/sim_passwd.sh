#!/bin/bash

# Simulated passwd command for student environments

USER=$(whoami)
DB_LOG="$HOME/.profile/password_changes.log"

echo "Changing password for $USER"

read -s -p "Current password: " current
echo
read -s -p "New password: " new1
echo
read -s -p "Retype new password: " new2
echo

# Simulated password match check
if [[ "$new1" != "$new2" ]]; then
  echo "Sorry, passwords do not match."
  exit 1
fi

# Simulated password policy check
if [[ ${#new1} -lt 6 ]]; then
  echo "Password must be at least 6 characters."
  exit 1
fi

# Fake validation step
if [[ -n "$current" ]]; then
  echo "passwd: password updated successfully"
  exit 0
else
  echo "Authentication token manipulation error"
  exit 1
fi
