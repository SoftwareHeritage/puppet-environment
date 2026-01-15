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

    apt-get install -y \
        puppet-agent puppet-terminus-puppetdb \
        man wget curl telnet net-tools dnsutils traceroute mtr-tiny \
        gnupg
}

bootstrap_puppet_agent () {
    # Running puppet as local does not setup host certificates, while at least
    # Icinga expects a SSL certificate to be already set up. Initialize this
    # ahead of first puppet run.

    if puppet ssl show >/dev/null 2>/dev/null; then
        return
    fi

    rm -rf /var/lib/puppet/ssl

    echo '10.168.100.29     pergamon.internal.softwareheritage.org' >> /etc/hosts
    cat > /etc/puppet/puppet.conf << EOF
# Temporary file, should be overwritten by Puppet
[main]
    certname = $(hostname -f)
    vardir = /var/lib/puppet
    ssldir = /var/lib/puppet/ssl
    privatekeydir = \$ssldir/private_keys { group = service }
    hostprivkey = \$privatekeydir/\$certname.pem { mode = 640 }
    rundir = /var/run/puppet
    server = pergamon.internal.softwareheritage.org
EOF
    puppet ssl bootstrap
}

install_apt_deps
setup_reboot_tasks
bootstrap_puppet_agent
