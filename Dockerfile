FROM ubuntu:focal-20220316

ENV PACKER_VERSION=1.6.6

# libvirt-bin has been split into packages: 
#   - libvirt-daemon-system
#   - libvirt-clients
# see: https://lists.debian.org/debian-user/2016/11/msg00518.html

# Install locales to prevent tzdata configuration during build
RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
    apt-utils \
    build-essential \
    ca-certificates \
    curl \
    less \
    rsync \
    vim \
    unzip \
    &&  rm -rf /var/lib/apt/lists/* 

# install qemu
RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
    qemu \
    libvirt0 libvirt-daemon-system libvirt-clients ruby-libvirt \
    ebtables dnsmasq-base libguestfs-tools \
    vagrant \
    parted \
    grub-efi-amd64-bin \
    grub-pc \
    libxslt-dev libxml2-dev libvirt-dev zlib1g-dev ruby-dev \
    ansible \
    && rm -rf /var/lib/apt/lists/*

RUN vagrant plugin install vagrant-libvirt

ADD ./package_domain.rb /tmp
RUN cp /tmp/package_domain.rb ./root/.vagrant.d/gems/2.*/gems/vagrant-libvirt-*/lib/vagrant-libvirt/action/package_domain.rb

# add packer binaries
RUN curl https://releases.hashicorp.com/packer/${PACKER_VERSION}/packer_${PACKER_VERSION}_linux_amd64.zip > /tmp/packer.zip && \
    unzip /tmp/packer.zip -d /usr/local/bin/ && \
    rm /tmp/packer.zip

RUN mkdir -p /work

WORKDIR /work
