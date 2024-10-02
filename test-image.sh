#!/usr/bin/bash

test_image() {
    echo "" && echo "===> Start container"
    CONTAINER_NAME=$IMAGE_NAME

    # remove any possible running container.
    podman rm $CONTAINER_NAME 

    # This command keeps the container running by executing a loop that sleeps indefinitely.
    podman run -d --name $CONTAINER_NAME localhost/$IMAGE_NAME  /bin/bash -c "while true; do sleep 3600; done"

    if [ $? -ne 0 ]; then

        echo "Error: The command failed." >&2
        exit 1
    fi

    echo "" && echo "===> Confirm container uptime"

    podman ps | grep $CONTAINER_NAME

    echo "" && echo "===> Confirm ansible version"

    podman exec -i $CONTAINER_NAME ansible --version

    echo "" && echo "===> Check installed collections"
    
    podman exec -i $CONTAINER_NAME ansible-galaxy collection list

    echo "" && echo "===> Check python packages and versions"
    
    podman exec -i $CONTAINER_NAME pip3 freeze
}

test_image
