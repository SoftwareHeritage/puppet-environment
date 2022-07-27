#!/bin/bash -eu

####
# apt configuration
####
source /etc/os-release
cat <<EOF >/etc/apt/sources.list.d/debian.list
deb http://deb.debian.org/debian ${VERSION_CODENAME} main
deb-src http://deb.debian.org/debian ${VERSION_CODENAME} main

deb http://deb.debian.org/debian ${VERSION_CODENAME}-updates main
deb-src http://deb.debian.org/debian ${VERSION_CODENAME}-updates main
EOF

export DEBIAN_FRONTEND=noninteractive

apt-get update
apt-get upgrade -y

apt-get install -y man wget curl telnet net-tools dnsutils traceroute unbound gpg

####
# allow vagrant user to sudo to root without password
####
cat <<EOF >/etc/sudoers.d/vagrant
vagrant ALL= NOPASSWD: ALL
EOF
chmod 0440 /etc/sudoers.d/vagrant

####
# Configure authorized_keys to allow vagrant command line to interact with the VM
####
mkdir -m 700 /home/vagrant/.ssh
curl -s https://raw.githubusercontent.com/hashicorp/vagrant/master/keys/vagrant.pub >> /home/vagrant/.ssh/authorized_keys
chmod 0600 /home/vagrant/.ssh/authorized_keys
chown -R vagrant:vagrant /home/vagrant/.ssh

####
# Puppet
####
apt-get install -y puppet

# Configure the fileserver for the "le_certs" share
# In the vm, this directory is a mount of the vagrant/le_certs directory configured on the vagrantfile
mkdir -p /var/lib/puppet/letsencrypt_exports
cat > /etc/puppet/fileserver.conf <<EOF
[le_certs]
  path /var/lib/puppet/letsencrypt_exports
  allow *
EOF

####
# Boot config
####
# Restore the dirty default interface naming
# The default behavior can't be used as the mac address of the interfaces
# are changed for each instanciation of this image
sed -i 's|^GRUB_CMDLINE_LINUX="\(.*\)"|GRUB_CMDLINE_LINUX="\1 net.ifnames=0 biosdevname=0"|' /etc/default/grub
grub-mkconfig -o /boot/grub/grub.cfg

# configure default interfaces
cat > /etc/network/interfaces <<EOF
source /etc/network/interfaces.d/*

# The loopback network interface
auto lo
iface lo inet loopback

# The primary network interface
allow-hotplug eth0
iface eth0 inet dhcp
EOF
