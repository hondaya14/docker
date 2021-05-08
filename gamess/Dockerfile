# Dockerfile for gamess
# Gamess -> https://www.msg.chem.iastate.edu/GAMESS/

### Base image
FROM nvidia/cuda:10.1-cudnn7-devel-ubuntu18.04

### Configuration
# CUDA (must be the same as the base image's!)
ARG CUDA_TOOLKIT_VERSION=10.1

### User account in Docker image
# username
ARG USER_NAME=""
# groupname
ARG GROUP_NAME=""
# UID
ARG USER_ID=""
# GID
ARG GROUP_ID=""
# SSH public key
ARG USER_SSH_PUBKEY=""


### Install linux commands
RUN apt update && \
    apt upgrade -y && \
    apt install -y \
            openssh-server \
            less \
            vim \
            sudo \
            curl \
            git \
            htop \
            x11-app \
            gfortran

# SSH configuration
RUN sed -i "s/^.*PasswordAuthentication.*$/PasswordAuthentication no/" /etc/ssh/sshd_config && \
    sed -i "s/^.*X11Forwarding.*$/X11Forwarding yes/" /etc/ssh/sshd_config && \
    sed -i "s/^.*X11UseLocalhost.*$/X11UseLocalhost no/" /etc/ssh/sshd_config && \
    ssh-keygen -A && \
    mkdir -p /var/run/sshd


# Add user
RUN groupadd -g ${GROUP_ID} ${GROUP_NAME} && \
    useradd -u ${USER_ID} -g ${GROUP_ID} -m -G sudo -s /bin/bash ${USER_NAME} && \
    echo "${USER_NAME} ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers.d/${USER_NAME}


# User Env
USER ${USER_NAME}
WORKDIR /home/${USERNAME}
## Register SSH key
RUN mkdir .ssh && echo -e "${USER_SSH_PUBKEY}" >> .ssh/authorized_keys

# Setup GÅMESS
RUN tar -xzvf /net/fs09/homes/people/${USER_NAME}/repos/gamess-current.tar.gz \
    cd gamess \
    ./config

# Auto start sshd (port 22)
USER root
WORKDIR /home/${USER_NAME}
EXPOSE 22
CMD ["/usr/sbin/sshd", "-D"]
