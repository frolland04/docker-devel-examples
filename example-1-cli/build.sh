#!/bin/bash

echo "**************************************************"
echo "Please wait while the Docker image is being built."
echo "**************************************************"

set -aeux
DOCKER_IMAGE_NAME='demo-1-cli'

docker build \
    --network host \
    --build-arg HTTP_PROXY="${HTTP_PROXY}" \
    --tag ${DOCKER_IMAGE_NAME} \
    .
