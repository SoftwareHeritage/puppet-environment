#!/bin/bash

if dpkg -l puppet-agent >/dev/null 2>/dev/null; then
    exit 0
fi

apt-get update
apt-get -y dist-upgrade

apt-get install -y puppet-agent gnupg
