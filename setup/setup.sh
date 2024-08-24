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
run_ansible_playbook() {
    local playbook_path="$1"

    ansible-playbook "$playbook_path"

    if [ $? -eq 0 ]; then
        echo "Ansible playbook ran successfully!"
    else
        echo "An error occurred running the Ansible playbook."
    fi
}

echo "Installing essential packages"
run_ansible_playbook $PLAYBOOK_PATH/essentials.yml
echo "Installing and configuring tmux"
run_ansible_playbook $PLAYBOOK_PATH/tmux.yml
echo "Installing and configuring neovim and bashrc"
run_ansible_playbook $PLAYBOOK_PATH/neovim.yml
echo "Installing node and npm"
run_ansible_playbook $PLAYBOOK_PATH/node.yml
