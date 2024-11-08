#!/bin/bash

echo "**************************************************"
echo "Please wait while the Docker image is being built."
echo "**************************************************"

set -aeux
export P_UID="$(id -u)"
export P_GID="$(id -g)"

docker compose build
