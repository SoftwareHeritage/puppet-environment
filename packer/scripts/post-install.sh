#!/bin/bash -eu

####
# apt configuration
####
cat <<EOF >/etc/apt/sources.list.d/debian.list
deb http://deb.debian.org/debian buster main
deb-src http://deb.debian.org/debian buster main

deb http://deb.debian.org/debian-security/ buster/updates main
deb-src http://deb.debian.org/debian-security/ buster/updates main

deb http://deb.debian.org/debian buster-updates main
deb-src http://deb.debian.org/debian buster-updates main
EOF

apt-get update
apt-get install -y man wget curl telnet net-tools dnsutils traceroute unbound

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

####
# Cleanup
####
#rm -v /home/vagrant/VBoxGuestAdditions*.iso
