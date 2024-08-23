# Use an official Ubuntu base image
FROM ubuntu:22.04

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

RUN /tmp/setup/setup.sh
CMD ["tmux"]
