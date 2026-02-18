#!/usr/bin/env bash

set -eu

PROV_MARKER=/var/lib/puppet/.vagrant_puppet_server_provisionned
PROV_DIR="/tmp/vagrant_provisioning/puppet_server/"

if ! [ -f $PROV_MARKER ]; then
    apt-get update
    apt-get install -y \
        unbound puppetserver dbconfig-no-thanks puppetdb ruby-scanf

    echo "puppet/code" > /etc/.gitignore
    apt install -y etckeeper

    # disable etckeeper pre-commits doing a find on nfs mounts
    pushd /etc/etckeeper/pre-commit.d
    find . -name "[0-9][0-9]*" -type f -exec mv {} {}.disabled \;
    popd

    # Configure an unbound forwarder: Puppet might leave pergamon in an unstable
    # state in Vagrant otherwise, and overwrites this file if unwanted
    if ! [ -f /etc/unbound/unbound.conf.d/forwarders.conf ]; then
        cp $PROV_DIR/forwarders.conf /etc/unbound/unbound.conf.d/forwarders.conf
        sudo systemctl restart unbound.service
    fi

    # Initialize Puppet server's CA
    puppetserver ca setup \
        --subject-alt-names pergamon.internal.softwareheritage.org,puppet,puppet.internal.softwareheritage.org

    # Apply the pergamon_bootstrap.pp manifest -- applying it from Vagrant
    # would result in a failure as some operations (eg. mail) fail here, and
    # prevent Vagrant from applying main.pp after
    puppet apply \
        --codedir=/etc/puppet/code/ \
        /etc/puppet/code/environments/production/bootstrap_manifests/pergamon_bootstrap.pp

    # Mark as provisionned
    touch $PROV_MARKER
fi
