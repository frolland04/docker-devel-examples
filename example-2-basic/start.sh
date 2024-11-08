#!/bin/bash

set -aeux
xhost +local:docker
docker run --rm \
           --interactive \
           --tty \
           --volume /tmp/.X11-unix:/tmp/.X11-unix \
           --env DISPLAY=${DISPLAY} \
           demos-docker-dev-basic \
           /bin/bash
