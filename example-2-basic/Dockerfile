FROM ubuntu

ENV DEBIAN_FRONTEND=noninteractive
SHELL ["/bin/bash", "-c"]

# Package manager setup
# *********************
RUN apt update && apt install -y build-essential nano lsb-release 

# Set the timezone
# ****************
ENV TZ="Europe/Paris"
RUN ln -fs /usr/share/zoneinfo/$TZ /etc/localtime && \
    apt update && \
    apt -y install tzdata && \
    dpkg-reconfigure tzdata

# X11 support
# ***********
RUN apt install -y x11-utils x11-apps

# Graphical tools
# ***************
RUN apt install -y nedit

