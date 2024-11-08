FROM ubuntu

ARG DEBIAN_FRONTEND=noninteractive
SHELL ["/bin/bash", "-c"]


# Package manager setup
# *********************
RUN apt update && \
    apt install -y \
        apt-transport-https \
        bash-completion \
        build-essential \
        git \
        gosu \
        gpg \
        iputils-ping \
        locales \
        lsb-release \
        nano \
        openssl \
        python3 \
        sudo \
        tzdata


# Set the locale & timezone
# *************************
ENV LC="fr_FR.UTF-8"

RUN sed -i -e 's/# fr_FR.UTF-8 UTF-8/fr_FR.UTF-8 UTF-8/' /etc/locale.gen && \
    echo 'LANG="fr_FR.UTF-8"' > /etc/default/locale && \
    dpkg-reconfigure locales && \
    update-locale LANG=$LC

ENV TZ="Europe/Paris"
RUN ln -fs /usr/share/zoneinfo/$TZ /etc/localtime && \
    dpkg-reconfigure tzdata


# X11 support
# ***********
RUN apt install -y x11-utils x11-apps

# Graphical tools
# ***************
RUN apt install -y nedit


# Visual Studio Code
# ******************
RUN apt install -y \
        wget \
        apt-transport-https && \
    PKG_GPG="packages.microsoft.gpg" && \
    wget --quiet -O - "https://packages.microsoft.com/keys/microsoft.asc" | gpg --dearmor > ${PKG_GPG} && \
    install -D -o root -g root -m 644 ${PKG_GPG} /etc/apt/keyrings/${PKG_GPG} && \
    echo "deb [arch=amd64 signed-by=/etc/apt/keyrings/${PKG_GPG}] https://packages.microsoft.com/repos/code stable main" \
          > "/etc/apt/sources.list.d/vscode.list" && \
    rm -f ${PKG_GPG} && \
    apt update && \
    apt install -y \
        code


# Google chrome
# *************
RUN apt install -y \
        wget \
        apt-transport-https \
        libu2f-udev \
        fonts-liberation \
        libvulkan1 && \
    DEB_GG="google-chrome-stable_current_amd64.deb" && \
    wget --quiet "https://dl.google.com/linux/direct/${DEB_GG}" && \
    dpkg -i ${DEB_GG} && \
    rm ${DEB_GG}


# Dedicated *non-root* user
# *************************
ARG UID=10000
ARG GID=10000
ARG USERNAME=devel
ARG USERGROUP=${USERNAME}
ARG USERPASSWD=${USERNAME}

RUN <<EOF
    set -aeu
    PASSWD=$(openssl passwd ${USERPASSWD})
    ADD_GROUPS="sudo,users"
    SHELL="/bin/bash"

    groupadd --gid ${GID} \
             --non-unique \
             ${USERGROUP}

    useradd --uid ${UID} \
            --gid ${GID} \
            --groups "${ADD_GROUPS}" \
            --non-unique \
            --shell ${SHELL} \
            --password "${PASSWD}" \
            ${USERNAME}
EOF


# ********************************
# Polishing end-user environnement
# ********************************
ARG DEBIAN_FRONTEND=dialog

RUN <<EOF
    set -aeu
    apt clean
    HOME="/home/${USERNAME}"
    cp -r "/etc/skel/." ${HOME}
    chown -R ${USERNAME}:${USERGROUP} ${HOME}
    echo -e "alias ls='ls --color=auto'\nalias ll='ls -halF'" >> "${HOME}/.bash_aliases"
EOF

WORKDIR /tmp


# *******
# RUNTIME
# *******
ENV ENTRYPOINT_SCRIPT='/root/entrypoint.sh'
ARG START_DIR="/home/${USERNAME}"

COPY <<EOF "${ENTRYPOINT_SCRIPT}"
    #!/bin/bash
    echo ""
    echo "Welcome!"
    echo "********"
    echo "You can try using commands like 'id', 'hostname', 'ls -al', 'g++ --version', 'python3 --version', 'lsb_release -a' or even 'ping 8.8.8.8'"
    echo "You can also try these commands : 'nedit', 'googlechrome' or 'code'"
    echo "Please note that changes done to '/data' are persistent and visible from the host, looking at the 'sandbox' folder."
    echo "Hit CTRL-D or enter 'exit' to finish."
    echo ""
    cd ${START_DIR}
    gosu ${USERNAME} /bin/bash
EOF

RUN chmod +x "${ENTRYPOINT_SCRIPT}"
ENTRYPOINT ["bash", "-c", "${ENTRYPOINT_SCRIPT}"]


# **************************************************
# Finishing and labelling the image
# (keep interesting metadata for further processing)
# **************************************************
ARG BUILD_DATE="1970-01-01T00:00:00Z"
ARG BUILD_VERSION="1.0"
LABEL org.label-schema.schema-version="1.0"
LABEL org.label-schema.build-date=${BUILD_DATE}
LABEL org.label-schema.version=${BUILD_VERSION}