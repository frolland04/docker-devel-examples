#!/bin/bash

echo ""
echo "Welcome!"
echo "********"
echo ""
echo "You can try using commands like 'id', 'hostname', 'ls -al', 'g++ --version', 'python3 --version', 'lsb_release -a' or even 'ping 8.8.8.8'"
echo "Hit CTRL-D or enter 'exit' to finish."
echo ""

set -aeux
DOCKER_IMAGE_NAME='demo-1-cli'

docker run --rm \
           --interactive \
           --tty \
           ${DOCKER_IMAGE_NAME} \
           /bin/bash
