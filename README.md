## Installation

- libvirt needs to be running on the host
- A storage pool with the name `default` will need to be created. The path for it needs to be supplied as a volume to the Docker container.

## Usage example

```
docker run -it --rm --privileged --cap-add=NET_ADMIN --net=host -v /var/lib/libvirt:/var/lib/libvirt -v /var/run/libvirt:/var/run/libvirt -v /var/lib/ctr-vagrant-libvirt:/persistent-data -v /opt/vagrant-builder/images/:/opt/vagrant-builder/images/ atlantic-crypto/packer-valgrind-libvirt-docker
```
