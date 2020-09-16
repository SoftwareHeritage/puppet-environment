Packer usage
============

packer[1] is used to generate the virtualbox[2] images used to locally simulate the different servers and to test the puppet configuration and the service deployments.

Setup
-----

Packer and virtualbox tools are needed to create the base image.
An additional plugin must be installed to manage the virtualbox addons in the vms.

On debian(10) :
```
apt install vagrant virtualbox-6.0  # 2020-09-17 vagrant is not working with virtualbox 6.1
vagrant plugin install vagrant-vbguest
```

Generate a new virtualbox image
-------------------------------

### Configuration description

For the debian buster image, this files are used :
* `debian_buster.json`: the configuration entrypoint describing the tasks packer will execute to generate the image
* `http/buster-preseed.cfg`: The debian preseed file used by debian to manage the installation. Debian loads it through an http server started by packer during the build.
* `scripts/post-install.sh`: Post install script containing the post installation tasks needed to prepare the vms to ready to apply the puppet configuration (install puppet, manage vagrant's user key, ...)

### Build the image

To build an image, use this command in the current directory :

```
packer build <json file>
```

For example, to build or rebuild the debian buster image :
```
packer build debian_buster.json
```
:WARNING: virtualbox open the vm's console during the build. Don't interact with it to avoid to interfer with the packer execution.

This command executes this process :
* Create a new VM in virtualbox and boot it with the iso image defines in the ``iso_image`` parameter. 
* Simulate keyboard interactions to enter the ``boot_command`` which basically tells debian to start the installation based on the ``buster_preseed.cfg`` file
* Call one or several provisioners after the installation to fine tune the installation. For our needs, only the ``scripts/post-install.sh`` script is executed
* package the image into a vbox file directly usable by virtualbox and place it in the ``builds`` directory.

### Publish the image

The image must be publish on the public annex site[3] to be usable by other persons than the person who build it.
The images are published in the ``/isos/virtualbox/debian``[4] directory.

The ``git-annex`` usage is documented on the intranet[5].

Once the new image is published, the ``Vagrantfile`` [4] file can be updated to declare it (``$global_debian10_box`` and ``$global_debian10_box_url`` properties[6]).


[1]: https://www.packer.io
[2]: https://www.virtualbox.org
[3]: https://annex.softwareheritage.org/public
[4]: https://forge.softwareheritage.org/source/annex-public/browse/master/isos/virtualbox/debian/
[5]: https://intranet.softwareheritage.org/wiki/Git_annex
[6]: https://forge.softwareheritage.org/source/puppet-environment/browse/master/Vagrantfile

Annex
-----

### Generate a preseed file

It can be useful to prepare the installation for a new debian version :
* install the new version on a vm
* execute the following commands:
```
apt update
apt install curl debconf debconf-utils
debconf-get-selections --installer > /tmp/preseed.cfg
debconf-get-selections >>/tmp/preseed.cfg
```

The preseed file must be adapted to specify the user passwords or the partitionning apparently not included in the preseed file.

For buster, the following lines were added :
```
d-i pkgsel/include string puppet openssh-server apt-transport-https
# Whether to upgrade packages after debootstrap.
# Allowed values: none, safe-upgrade, full-upgrade
d-i pkgsel/upgrade select full-upgrade

# Root password, either in clear text
d-i passwd/root-password password rootroot
d-i passwd/root-password-again password rootroot
# To create a normal user account.
d-i passwd/username string vagrant
# Normal user's password, either in clear text
d-i passwd/user-password password vagrant
d-i passwd/user-password-again password vagrant
d-i passwd/user-fullname string Vagrant
# Create the first user with the specified UID instead of the default.
d-i passwd/user-uid string 999
# The user account will be added to some standard initial groups. To
# override that, use this.
d-i passwd/user-default-groups string audio cdrom video sudo

### Partitioning
d-i partman-auto/init_automatically_partition select biggest_free
#d-i partman-auto/disk string /dev/vda
d-i partman-auto/method string lvm
# Keep some space on the lvm volume to play with snapshots
d-i partman-auto-lvm/guided_size string 90%
# If one of the disks that are going to be automatically partitioned
# contains an old LVM configuration, the user will normally receive a
# warning. This can be preseeded away...
d-i partman-lvm/device_remove_lvm boolean true
# The same applies to pre-existing software RAID array:
d-i partman-md/device_remove_md boolean true
# And the same goes for the confirmation to write the lvm partitions.
d-i partman-lvm/confirm boolean true
d-i partman-lvm/confirm_nooverwrite boolean true
d-i partman-auto-lvm/no_boot boolean true
d-i partman-auto/choose_recipe select atomic
d-i partman-lvm/device_remove_lvm boolean true
d-i partman-md/device_remove_md boolean true
d-i partman-lvm/confirm boolean true
d-i partman-lvm/confirm_nooverwrite boolean true
d-i partman-partitioning/confirm_write_new_label boolean true
d-i partman/choose_partition select finish
d-i partman/confirm boolean true
d-i partman/confirm_nooverwrite boolean true

d-i apt-setup/cdrom/set-first boolean false
d-i apt-setup/cdrom/set-next boolean false   
d-i apt-setup/cdrom/set-failed boolean false

d-i mirror/country string manual
d-i mirror/http/hostname string http.fr.debian.org
d-i mirror/http/directory string /debian
d-i mirror/http/proxy string

d-i apt-setup/use_mirror boolean false

popularity-contest popularity-contest/participate boolean false
```

It's important that the vagrant user doesn't have an UID of 1000 as puppet will try to create a user with a uid/gid of 1000/1000.
