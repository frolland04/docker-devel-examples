#!/bin/bash

set -aeux
DOCKER_IMAGE_NAME='demo-4-dbus'
X11_SOCKET_PATH='/tmp/.X11-unix'
DBUS_SOCKET_PATH="/run/user/$(id -u)/bus"

xhost +local:docker
docker run --rm \
           --interactive \
           --tty \
           --mount type=bind,source="${X11_SOCKET_PATH}",target="${X11_SOCKET_PATH}" \
           --mount type=bind,source="${DBUS_SOCKET_PATH}",target="${DBUS_SOCKET_PATH}" \
           --env DISPLAY=${DISPLAY} \
           --env DBUS_SESSION_BUS_ADDRESS=${DBUS_SESSION_BUS_ADDRESS} \
           --privileged \
           ${DOCKER_IMAGE_NAME} \
           /bin/bash
