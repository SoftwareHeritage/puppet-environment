#!/bin/bash -eu

####
# apt configuration
####
source /etc/os-release

cat <<EOF >/etc/apt/sources.list.d/backports.list
deb http://deb.debian.org/debian/ bullseye-backports main contrib
EOF

export DEBIAN_FRONTEND=noninteractive

apt-get update
apt-get install -y zfs-dkms
