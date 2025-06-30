#!/bin/bash

echo "Demonstrating how to use rsync to mirror and backup directories."

# Mirroring a directory with rsync
echo "To mirror a directory from a remote system accessible via OpenSSH, use:"
echo 'rsync --compress --update -e ssh user@remote_host:/path/to/source/ /path/to/destination/'

# Backup strategy with rsync
echo "To automate backups and use hard links for efficiency, use:"
echo 'rsync --archive --link-dest=../bu.1 memos/ bu.0'

# Tip for automation with crontab
echo "Automate your backup scripts for regular execution by adding them to crontab."

exec bash --rcfile $RCFILE
