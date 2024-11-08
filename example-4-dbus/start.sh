#!/bin/bash

set -aeux
xhost +local:docker
docker run --rm \
           --interactive \
           --tty \
           --volume /tmp/.X11-unix:/tmp/.X11-unix \
           --volume /run/user/$(id -u)/bus:/run/user/$(id -u)/bus \
           --env DISPLAY=${DISPLAY} \
           --env DBUS_SESSION_BUS_ADDRESS=${DBUS_SESSION_BUS_ADDRESS} \
           --privileged \
           demos-docker-dev-dbus \
           /bin/bash
