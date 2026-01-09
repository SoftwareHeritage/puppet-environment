#!/bin/bash

setup_reboot_tasks () {
    # This script is run as root, su'd from vagrant -- hence preventing easy
    # changes in uid/gid. Run a transient systemd unit at poweroff, then reboot
    # in Vagrantfile
    systemd-run \
        --unit=vagrant_provision_at_reboot.service \
        --property=Type=oneshot \
        --property='ExecStop=/usr/bin/bash /tmp/vagrant_provision_at_reboot.sh' \
        --property=RemainAfterExit=true \
        /usr/bin/true
}

install_apt_deps () {
    if dpkg -l puppet-agent >/dev/null 2>/dev/null; then
        return
    fi

    apt-get update
    apt-get -y dist-upgrade

    apt-get install -y puppet-agent gnupg
}

install_apt_deps
setup_reboot_tasks
