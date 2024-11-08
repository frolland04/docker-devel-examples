#!/bin/bash

set -aeux
DOCKER_IMAGE_NAME='demo-3-enhanced'
X11_SOCKET_PATH='/tmp/.X11-unix'

xhost +local:docker
docker run --rm \
           --interactive \
           --tty \
           --mount type=bind,source="${X11_SOCKET_PATH}",target="${X11_SOCKET_PATH}" \
           --mount type=bind,source="./sandbox",target="/data" \
           --env DISPLAY=${DISPLAY} \
           --privileged \
           ${DOCKER_IMAGE_NAME} \
           /bin/bash
