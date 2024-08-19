#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

# Check if the script is being run as root
if [ "$EUID" -ne 0 ]; then
    SUDO='sudo'
else
    SUDO=''
fi

echo "Updating the package list..."
$SUDO apt-get update

echo "Installing prerequisites..."
$SUDO apt-get install -y \
    software-properties-common \
    curl \
    git \
    python3 \
    python3-pip

echo "Adding Ansible PPA (Personal Package Archive)..."
$SUDO add-apt-repository --yes --update ppa:ansible/ansible

echo "Installing Ansible..."
$SUDO apt-get install -y ansible

echo "Verifying the installation..."
ansible --version

echo "Installation completed successfully!"
