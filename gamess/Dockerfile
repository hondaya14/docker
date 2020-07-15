# Dockerfile for gamess
# Gamess -> https://www.msg.chem.iastate.edu/GAMESS/

### Base image: DockerHub nvidia/cuda, CUDA v9.2, cuDNN v7, development package, CentOS7
FROM nvidia/cuda:10.1-cudnn7-devel-ubuntu18.04

### Configuration
# CUDA (must be the same as the base image's!)
ARG CUDA_TOOLKIT_VERSION=10.1


### User account in Docker image
# username
ARG USER_NAME="hondaya"
# groupname
ARG GROUP_NAME="yasunaga-lab"
# UID
ARG USER_ID="12121"
# GID
ARG GROUP_ID="1001"
# SSH public key
ARG USER_SSH_PUBKEY="ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQC82C1j47UiCR4j3iKxb6fs/3E+6dOCa2kH5Dcr1iaZje9EOtUDvS70JkvPR61H35x81o2Vp8Ep5CR5ZrH411tZauTO7H8vLOzhba1MFcEaWKkhmwInLtfj+GFF09bb5Vu9bgQfsqzHUVNzAIflSaUxfR+W64dTYz4rmNfjFe764gSqIWi74tMgo2RG5unsHuyGMmb1DrRn1sxKSQonHyqNXs0zi1FRlLhzmOKGNVH+qRNjvgl1k5aVizuhqHhM6PSwWNHCqkLp0OfMbSvsbKIm/viIaw15MKouy4cHBAOtHEzyoIN8USCd6Hr+wk7pgM6dCFg+jdSa8d5NKkIUiLNj "
# Specify GID of "vglusers" group if exists, else leave this empty
ARG VGLUSERS_GROUP_ID=""

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
            x11-apps

# SSH configuration
RUN sed -i "s/^.*PasswordAuthentication.*$/PasswordAuthentication no/" /etc/ssh/sshd_config && \
    sed -i "s/^.*X11Forwarding.*$/X11Forwarding yes/" /etc/ssh/sshd_config && \
    sed -i "s/^.*X11UseLocalhost.*$/X11UseLocalhost no/" /etc/ssh/sshd_config && \
    ssh-keygen -A && \
    mkdir -p /var/run/sshd

# User Env
USER ${USER_NAME}
WORKDIR /home/${USERNAME}
## Register SSH key
RUN mkdir .ssh && echo -e "${USER_SSH_PUBKEY}" >> .ssh/authorized_keys

# Install GÅMESS

RUN tar xzvf gamess-current.tar.gz \
    cd 