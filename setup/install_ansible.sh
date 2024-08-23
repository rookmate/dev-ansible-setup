#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

# Check if the script is being run as root
if [ "$EUID" -ne 0 ]; then
    SUDO='sudo -E'
else
    SUDO=''
fi

echo "Updating the package list..."
$SUDO apt-get update

echo "Installing Python3 and pip3..."
$SUDO apt-get install -y python3 python3-pip

echo "Installing Ansible using pip3..."
$SUDO pip3 install ansible

echo "Verifying the installation..."
ansible --version

echo "Installation completed successfully!"
