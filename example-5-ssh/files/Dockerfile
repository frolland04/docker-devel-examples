FROM ubuntu:latest


# Keep docker build fully automated
# *********************************
ARG DEBIAN_FRONTEND=noninteractive
SHELL ["/bin/bash", "-c"]


# Package manager setup
# *********************
RUN apt update && \
    apt install --assume-yes \
        apt-transport-https \
        bash-completion \
        build-essential \
        git \
        gosu \
        gpg \
        iputils-ping \
        libssl-dev \
        locales \
        lsb-release \
        nano \
        openssh-client \
        openssl \
        python3 \
        sudo \
        tzdata \
        wget


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


# Dedicated *non-root* user
# *************************
ARG UID=10000
ARG GID=10000
ARG USERNAME=devel
ARG USERGROUP=${USERNAME}
ARG USERPASSWD=${USERNAME}
ARG USERHOME="/home/${USERNAME}"

ENV USERNAME=${USERNAME}
ENV USERGROUP=${USERGROUP}
ENV USERHOME=${USERHOME}

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
ARG START_DIR="/home/${USERNAME}"
ARG SSH_SOURCE_DIR
ARG SSH_KEYSTORE_DIR="${USERHOME}/.ssh"

ENV SSH_SOURCE_DIR=${SSH_SOURCE_DIR}
ENV SSH_KEYSTORE_DIR=${SSH_KEYSTORE_DIR}
ENV ENTRYPOINT_SCRIPT='/root/entrypoint.sh'

COPY <<EOF "${ENTRYPOINT_SCRIPT}"
    #!/bin/bash
    set -aeu -o pipefail
    env

    mkdir -p ${USERHOME} ${SSH_KEYSTORE_DIR}
    cp ${SSH_SOURCE_DIR}/* ${SSH_KEYSTORE_DIR} || true
    chown -R ${USERNAME}:${USERGROUP} ${USERHOME} ${SSH_KEYSTORE_DIR}
    chmod 500 ${SSH_KEYSTORE_DIR}
    chmod 400 ${SSH_KEYSTORE_DIR}/* || true

    ls -al ${SSH_KEYSTORE_DIR}
    cat ${SSH_KEYSTORE_DIR}/config | grep ^Host || true

    echo ""
    echo "Welcome!"
    echo "********"
    echo ""
    echo "You can try using commands like 'id', 'hostname', 'ls -al', 'g++ --version', 'python3 --version', 'lsb_release -a' or even 'ping 8.8.8.8'"
    echo "You can also try using 'git' or 'ssh' with an URL that requires a given ssh key and/or config. Please have a look into 'example-5-ssh/.ssh' before starting the container and provides the needed credentials and/or configuration"
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