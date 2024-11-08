#!/bin/bash

set -aeux
docker run --rm \
           --interactive \
           --tty \
           demos-docker-dev-cli \
           /bin/bash
