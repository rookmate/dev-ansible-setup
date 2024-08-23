#!/bin/bash

# Get all dangling image IDs
dangling_images=$(docker images -f "dangling=true" -q)

# Loop through each dangling image
for image in $dangling_images; do
    echo "Processing image: $image"

    # Find containers using this image
    containers=$(docker ps -a --filter ancestor=$image -q)

    # If containers exist, stop and remove them
    if [ ! -z "$containers" ]; then
        echo "Stopping and removing containers for image $image"
        docker stop $containers
        docker rm $containers
    fi

    # Remove the image
    echo "Removing image $image"
    docker rmi $image
done

echo "Building ansible test image"
docker build -t ansible_test -f Dockerfile .
docker run -it ansible_test
