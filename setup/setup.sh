#!/bin/bash

# Get the directory of the current script
SCRIPT_DIR="$(dirname "$(realpath "$0")")"

# Path to the install_ansible.sh script
INSTALL_SCRIPT_PATH="$SCRIPT_DIR/install_ansible.sh"

if [ ! -f "$INSTALL_SCRIPT_PATH" ]; then
    echo "Error: $INSTALL_SCRIPT_PATH not found!"
    exit 1
fi

echo "Starting the installation of Ansible..."
bash "$INSTALL_SCRIPT_PATH"

if [ $? -eq 0 ]; then
    echo "Ansible installation completed successfully!"
else
    echo "An error occurred during the Ansible installation."
fi

# Path to your Ansible playbook
PLAYBOOK_PATH="$SCRIPT_DIR/playbooks"

# Run the Ansible playbook
echo "Installing apps I use..."
ansible-playbook $PLAYBOOK_PATH/common.yml

if [ $? -eq 0 ]; then
    echo "Ansible playbooks run successfully!"
else
    echo "An error occurred running the Ansible playbooks."
fi
