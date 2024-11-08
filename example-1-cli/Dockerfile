FROM ubuntu

ARG DEBIAN_FRONTEND=noninteractive
SHELL ["/bin/bash", "-c"]

RUN apt update && \
    apt install -y build-essential python3 nano lsb-release iputils-ping
