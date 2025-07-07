#!/bin/bash -x
# mission_absolute_relative_paths.sh
# -*- coding: utf-8 -*-
export TRAINING_SHELL="1"
source "$TOP_DIR/colors.sh"
source "$TOP_DIR/emojis.sh"
source "$TOP_DIR/utils.sh"
source "$TOP_DIR/copy_data.sh"

export WORK_DIR="/data/aircraft/configurations"
export lesson_title="Working with Absolute and Relative Paths"
export lesson="$(cat<<EOS

# Lab Exercise: Filesystem, Permissions, Paths
In this set of exercises, you will manipulate a drone configuration directory structure 
using both **absolute** and **relative** paths. 

* The exercises will walk through navigating the directory structure
* copying, renaming, linking, and removing files and directories.
* We will also cover the **du** command and the **find** command.
EOS
)"

declare -g -a prompts=(
  "$(cat <<'EOS'
Navigate to the working directory ${WORK_DIR}.;
re:cd ${WORK_DIR}|cd ${WORK_DIR}/;
Use 'cd' to change to the working directory defined by the WORK_DIR variable.;

Print the current working directory to confirm your location.;
pwd;
Use `pwd` to print the current working directory.;

Get a long directory listing of the root directory using an absolute path.;
ls -l /;
Use \`ls -l\` with an absolute path starting with \`/\`.;

You should notice the root directory contains several directories including 'data'.  Acknowledge the presence of 'data' and by entering name of the user that owns it as a comment \`# username\`;
re:# codespace|\$(whoami);
Acknowledge the presence of 'data' in the root directory normally # codespace.;

Navigate to the '/data' directory using an absolute path.;
cd /data;
Use an absolute path that starts with \`/\`.;

Use the find command to locate the 'mq-9' directory from the current location.;
re:find . -type d -name mq-9|find /data -type d -name mq-9|find . -name mq-9 -type d|find . -name mq-9;
Use \`find\` to search for directories named 'mq-9', try \`find . -type d -name mq-9\` .;

Navigate to the 'mq-9' directory using an absolute path.;
cd /data/aircraft/configurations/mq-9;
Use an absolute path that starts with \`/data\`.;

Print the current working directory to confirm your location.;
pwd;
Use \`pwd\` to print the current working directory.;

Navigate to the 'xq-67a' directory using a relative path from the 'mq-9' directory.;
cd ../xq-67a;
You can use a relative path from the current directory to go up one level and then into 'xq-67a' think of using \`..\`;

List all files in the 'xq-67a' directory.;
re:ls -l|ls -l .|ls;
Use \`ls -l\` to list files in the current directory.;
Move 'n223wx.cfg' to the 'mq-1c' directory, using a relative path.;
re:mv n223wx.cfg ../mq-1c/|mv n223wx.cfg ../mq-1c|mv n223wx.cfg ../mq-1c/.;
Use \`mv\` with a relative path. Try ../mq-1c/;

Move 'n901uv.cfg' to the 'mojave' directory, using a relative path.;
re:mv n901uv.cfg ../mojave/|mv n901uv.cfg ../mojave|mv n901uv.cfg ../mojave/.;
Use \`mv\` with a relative path.  Try ../mojave/;

Navigate to the parent directory of 'mq-9' using a relative path.;
re:cd ..|cd ../.|cd ../;
Use \`cd ..\` to go up one level from 'mq-9'.;

Print the current working directory to confirm your location.;
pwd;
Use \`pwd\` to print the current working directory. You should be in '/data/aircraft/configurations' directory.;

Create a backup directory in the 'aircraft' directory;
re:mkdir ../backup|mkdir ../backup/|mkdir /data/aircraft/backup|mkdir /data/aircraft/backup/;
Use \`mkdir\` with a relative path ../backup and \`cp\` with wildcard and relative paths.;

Copy all the configuration files into the ../backup/ directory.;
cp \*/\*.cfg ../backup/;
Use the relative path ../backup and \`cp\` with wildcards.;

List the i-nodes of all configuration files in 'mq-20'.;
ls -i mq-20/*.cfg;
Use \`ls -i\` to list i-nodes.;

Remove the 'mq-9b' directory using 'rmdir'.;
rmdir mq-9b;
It will fail if the directory is not empty.;

Explain why 'rmdir' failed to remove 'mq-9b' with a comment (just put the error message).;
re: # .*;
The directory 'mq-9b' is not empty, so 'rmdir' cannot remove it.;

Create a 'locations' directory in 'aircraft' using a relative path ../.;
mkdir ../locations;
You need to move up one level and use \`mkdir\`.;

Create symbolic links in 'locations' for 'xq-67a';
re:ln -s xq-67a ../locations/xq-67a|ln -s xq-67a ../locations/.;
Use \`ln -s\` for symbolic links.;

Navigate to the 'aircraft' directory using an absolute path.;
re:cd /data/aircraft|cd /data/aircraft/;
Start your path with \`/\`.;

Navigate to 'mojave' in 'configurations' using a relative path from 'aircraft'.;
re:cd configurations/mojave|cd configurations/mojave/;
Start from \`aircraft\`, descend into \`configurations\`, then \`mojave\`.;

Navigate to the aircraft directory.;
re:cd /data/aircraft|cd /data/aircraft/|cd ../../aircraft|cd ../../aircraft/;
Depending on your current location, you can use an absolute path or a relative path to go back to the 'aircraft' directory.;

Using the 'find' command, locate the n112op.cfg configuration file in the 'aircraft/config' directory.;
re:find . -name n112op.cfg|find /data/aircraft/configurations -name n112op.cfg|find /data/aircraft/configurations/mq-9 -name n112op.cfg;
Use \`find\` to search for the file by name.;


Copy 'n112op.cfg' to the 'backup' directory.;
re:cp configurations/mq-9/n112op.cfg /data/aircraft/backup/|cp /data/aircraft/configurations/mq-9/n112op.cfg /data/aircraft/backup/|cp /data/aircraft/configurations/mq-9/n112op.cfg /data/aircraft/backup/;
Use \`cp\` with relative or absolute paths or a combination.;

List all files in the 'configurations' directory with their sizes as human.;
re:ls -lRh **/*.cfg|ls -lRh */*.cfg|ls -lRh configurations/*.cfg|ls -lRh configurations/;
Use \`ls -lRh\` for recursive descent and human-readable sizes.;

Move 'n890mn.cfg' from 'mq-9' to 'mq-20'.;
re:mv configurations/mq-9/n890mn.cfg configurations/mq-20/|mv mq-9/n890mn.cfg mq-20/|mv /data/aircraft/configurations/mq-9/n890mn.cfg /data/aircraft/configurations/mq-20/;
Use \`mv\` with source and destination paths.;

Create a symbolic link to 'n101gh.cfg' in the 'locations' directory.;
ln -s mq-1c/n101gh.cfg ../locations/n101gh.cfg;
Use \`ln -s\` and ensure the source exists.;

Navigate to 'mq-1c' using an absolute path.;
cd /data/aircraft/configurations/mq-1c;
Start your path with \`/\`.;

Remove the symbolic link to 'xq-67a' in the 'locations' directory.;
re:rm ../locations/xq-67a|rm /data/aircraft/locations/xq-67a;
Use \`rm\` on the symlink itself.;

Using touch create a new configuration file 'n567kl.cfg' in the 'mojave' directory.;
re:touch mojave/n567kl.cfg|touch /data/aircraft/configurations/mojave/n567kl.cfg;
Use \`touch\` to create files.;

Display the disk usage of the 'configurations' directory.;
re:du -sh ../../configurations|du -sh /data/aircraft/configurations;
Use \`du -sh\` on the parent dir or absolute path.;

Create a directory 'test' inside 'mq-9' and remove it using 'rmdir'.;
re:mkdir configuration/mq-9/test|mkdir /data/aircraft/configurations/mq-9/test;
Use \`mkdir\` to create a directory the path can be relative or absolute.;

Rename 'index.cfg' in 'xq-67a' to 'main.cfg'.;
re:mv configurations/xq-67a/index.cfg configurations/xq-67a/main.cfg|mv /data/aircraft/configurations/xq-67a/index.cfg /data/aircraft/configurations/xq-67a/main.cfg;
Use \`mv\` to rename files using either relative or absolute paths.;
EOS
)
"
)

source "$TOP_DIR/lesson_manager.sh"
