#!/bin/bash

echo ""
echo "Welcome!"
echo "********"
echo ""
echo "You can try using commands like 'id', 'hostname', 'ls -al', 'g++ --version', 'python3 --version', 'lsb_release -a' or even 'ping 8.8.8.8'"
echo "You can also try 'nedit'"
echo "Hit CTRL-D or enter 'exit' to finish."
echo ""

set -aeux
DOCKER_IMAGE_NAME='demo-2-basic'
X11_SOCKET_PATH='/tmp/.X11-unix'

xhost +local:docker
docker run --rm \
           --interactive \
           --tty \
           --mount type=bind,source="${X11_SOCKET_PATH}",target="${X11_SOCKET_PATH}" \
           --env DISPLAY=${DISPLAY} \
           ${DOCKER_IMAGE_NAME} \
           /bin/bash
