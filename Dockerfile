# Use an official Ubuntu base image
FROM ubuntu:22.04

# Set environment variables to avoid prompts during package installation
ENV DEBIAN_FRONTEND=noninteractive

# Install sudo
RUN apt-get update && apt-get install -y sudo && rm -rf /var/lib/apt/lists/*

# Create a non-root user and add to sudo group
RUN useradd -m -s /bin/bash rookmate && \
    usermod -aG sudo rookmate && \
    echo "rookmate ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

COPY setup /tmp/setup
RUN chmod +x /tmp/setup/setup.sh

USER rookmate
WORKDIR /home/rookmate

# Run the setup script to install Ansible and its dependencies
# Also runs all playbooks in the setup folder
RUN /tmp/setup/setup.sh

# Start the container with a tmux session
CMD ["tmux"]
