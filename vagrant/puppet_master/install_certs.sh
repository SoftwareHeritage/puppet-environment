#!/bin/bash

CERT_DIR="/tmp/puppet_master"
PUPPET_CERT_DIR=/var/lib/puppet/ssl

sudo mkdir -p ${PUPPET_CERT_DIR}/ 

sudo rsync -avP $CERT_DIR/* ${PUPPET_CERT_DIR}

sudo chown -R puppet:puppet ${PUPPET_CERT_DIR}
