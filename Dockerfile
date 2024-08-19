# Use an official Ubuntu base image
FROM ubuntu:22.04

# Set environment variables to avoid prompts during package installation
ENV DEBIAN_FRONTEND=noninteractive

# Copy the setup folder into the container
COPY setup /tmp/setup

# Make the script executable
RUN chmod +x /tmp/setup/setup.sh

# Run the setup script to install Ansible and its dependencies
RUN /tmp/setup/setup.sh

# Set default command to bash
CMD ["/bin/bash"]
