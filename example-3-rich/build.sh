#!/bin/bash

set -aeux
docker build \
    --network host \
    --build-arg HTTP_PROXY="${HTTP_PROXY}" \
    --build-arg UID=$(id -u) \
    --build-arg GID=$(id -g) \
    --tag demos-docker-dev-rich \
    .
