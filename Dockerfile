FROM ubuntu:bionic

ENV PACKER_VERSION=1.4.1 

# install qemu
RUN apt-get update && apt-get install -y --no-install-recommends \
		qemu \
  	        libvirt-bin ebtables dnsmasq-base libguestfs-tools \ 
                curl \
                unzip \
                ca-certificates \
                vagrant \
                vim less \
		gcc \
		libxslt-dev libxml2-dev libvirt-dev zlib1g-dev ruby-dev \
	        && rm -rf /var/lib/apt/lists/*

RUN vagrant plugin install vagrant-libvirt

# add packer binaries
RUN curl https://releases.hashicorp.com/packer/${PACKER_VERSION}/packer_${PACKER_VERSION}_linux_amd64.zip > /tmp/packer.zip && \
    unzip /tmp/packer.zip -d /usr/local/bin/ && \
    rm /tmp/packer.zip

RUN mkdir -p /work

WORKDIR /work