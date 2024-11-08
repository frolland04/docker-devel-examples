#!/bin/bash

set -aeux
docker build \
    --network host \
    --build-arg HTTP_PROXY="${HTTP_PROXY}" \
    --tag demos-docker-dev-basic \
    .
