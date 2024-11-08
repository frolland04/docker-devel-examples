#!/bin/bash

set -aeux
export P_UID=$(id -u)
export P_GID=$(id -g)
docker compose build
