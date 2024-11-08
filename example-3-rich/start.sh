#!/bin/bash

set -aeux
xhost +local:docker
docker run --rm \
           --interactive \
           --tty \
           --volume /tmp/.X11-unix:/tmp/.X11-unix \
           --volume ./sandbox:/data \
           --env DISPLAY=${DISPLAY} \
           --privileged \
           demos-docker-dev-rich \
           /bin/bash
