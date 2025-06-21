#!/bin/bash
source $BASE_DIR/demos/environ.sh
clear
cat <<EOS
********************************************************************************
1.  Demonstrate how to find documentation using man and info utilities.

2.  Using man to find system documentation for the 'ls' command:
\$ $(cyan 'man ls')

3.  Using man to find an introduction to unix/linux:
\$ $(cyan 'man intro')

4.  Using the --help option for quick utility guidance for the 'ls' command:
\$ $(cyan 'tar --help | less')

   Note: The output is piped to 'less' for easier reading, this requires the use of the pipe operator '|' 
   it is located above the enter key on most keyboards.

5.  Use apropos to search for commands related to a keyword, for example, 'archive':
\$ $(cyan 'apropos archive')
EOS

exec bash --rcfile $RCFILE
