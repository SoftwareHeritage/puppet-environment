#!/usr/bin/env bash

set -eu

CERT_DIR="/tmp/puppet_master"
PUPPET_CERT_DIR=/var/lib/puppet/ssl

if [ ! -d ${PUPPET_CERT_DIR} ]; then
  apt-get update
  apt-get install -y postgresql
  mkdir -p ${PUPPET_CERT_DIR}/
  cp -r $CERT_DIR/* ${PUPPET_CERT_DIR}
  chown -R puppet:puppet ${PUPPET_CERT_DIR}
fi
