#!/bin/bash

echo "Install the openssh-server package to set up an OpenSSH Server."
echo "sudo apt-get install openssh-server"
echo

echo "Modify the SSH configuration file for custom settings."
echo "sudo nano /etc/ssh/sshd_config"
echo

echo "In the configuration file, set PermitRootLogin to 'no' for enhanced security."
echo "PermitRootLogin no"
echo

echo "Set PasswordAuthentication to 'no' to enforce key-based authentication."
echo "PasswordAuthentication no"
echo

echo "Start the sshd service to apply the changes."
echo "sudo systemctl start sshd"
echo

echo "Make sure the sshd service is enabled to start on boot."
echo "sudo systemctl enable sshd"
echo

echo "Ensure that the sshd service is listening on the designated port."
echo "sudo systemctl status sshd"
echo

exec bash --rcfile $RCFILE
