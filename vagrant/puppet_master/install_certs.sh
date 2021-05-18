#!/bin/bash

CERT_DIR="/tmp/puppet_master"
PUPPET_CERT_DIR=/var/lib/puppet/ssl

apt-get update

apt-get install -y rsync

mkdir -p ${PUPPET_CERT_DIR}/

rsync -avP $CERT_DIR/* ${PUPPET_CERT_DIR}

chown -R puppet:puppet ${PUPPET_CERT_DIR}
