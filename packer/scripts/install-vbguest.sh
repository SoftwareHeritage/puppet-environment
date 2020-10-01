#!/bin/bash

# Install kernel headers
export DEBIAN_FRONTEND=noninteractive
apt-get install -y build-essential linux-headers-$(uname -r)

# mount the vbguest iso
env

mount VBoxGuestAdditions_*.iso /media/cdrom
cd /media/cdrom

./VBoxLinuxAdditions.run

if ! test -f /lib/modules/$(uname -r)/kernel/drivers/virt/vboxguest/vboxguest.ko
then
  echo "vboxsf module not detected"
  echo "Installation of guest additions was not successful"
  exit 1
fi

####
# Cleanup
####
umount /media/cdrom
rm -v /home/vagrant/VBoxGuestAdditions*.iso
