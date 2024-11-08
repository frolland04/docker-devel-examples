#!/bin/bash

echo "**************************************************"
echo "Please wait while the Docker image is being built."
echo "**************************************************"

set -aeux
DOCKER_IMAGE_NAME='demo-3-enhanced'

docker build \
    --network host \
    --build-arg HTTP_PROXY="${HTTP_PROXY}" \
    --build-arg UID=$(id -u) \
    --build-arg GID=$(id -g) \
    --tag ${DOCKER_IMAGE_NAME} \
    .
