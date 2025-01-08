
FROM ubuntu:22.04
ARG DEBIAN_FRONTEND=noninteractive

USER root

SHELL ["/bin/bash", "-c"]

# Apt packages
RUN dpkg --add-architecture i386
RUN apt-get update && apt-get install --yes --no-install-recommends \
        # required Yocto dependencies
        apt-utils \
        autoconf \
        automake \
        build-essential \
        debianutils \
        gcc-multilib \
        git \
        iproute2 \
        iputils-ping \
        less \
        locales \
        net-tools \
        openssl \
        python3 \
        python3-git \
        python3-jinja2 \
        python3-pexpect \
        python3-pip \
        python3-subunit \
        python3-yaml \
        qemu-system \
        qemu-user-static \
        sudo \
        tar \
        tree \
        unzip \
        wget \
        rsync \
        ssh \
        usbutils \
        # verify this
        libc6:i386 libncurses5:i386 libstdc++6:i386 lib32z1 libbz2-1.0:i386 \
        #libxrender1 libxtst6 libxi6 libfreetype6 libxft2 xz-utils vim\
        #qemu qemu-kvm libvirt-bin ubuntu-vm-builder bridge-utils libnotify4 libglu1 libqt5widgets5 openjdk-8-jdk openjdk-11-jdk xvfb \
        && apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Pip packages
RUN pip install \
        pip-tools

# Set locality because of 'noninteractive' install type
RUN locale-gen en_US && locale-gen en_US.UTF-8
ENV LANG=en_US.UTF-8

# Disable password prompt using 'sudo' for all members of sudo group
RUN echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers
