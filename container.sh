#! /usr/bin/bash

# A script to quickly start off a container
# Example run : $ ./start-container.sh quay.io/a_maseghe/dev-exec-env my-dev-env

IMAGE_NAME=quay.io/a_maseghe/dev-exec-env
CONTAINER_NAME=black-panther-dev

# remove any possible running container with same name
echo "" && echo "Stop and remove any existing container name = $CONTAINER_NAME" && echo ""
podman stop $CONTAINER_NAME && podman rm $CONTAINER_NAME

# This command keeps the container running by executing a loop that sleeps indefinitely.
echo "" && echo "Start container name = $CONTAINER_NAME" && echo ""
podman run -d --name $CONTAINER_NAME $IMAGE_NAME  /bin/bash -c "while true; do sleep 3600; done"

# get into the container
echo "" && echo "get into container name = $CONTAINER_NAME" && echo ""
podman exec -it $CONTAINER_NAME /bin/bash
