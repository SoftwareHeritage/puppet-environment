#!/usr/bin/env bash

set -xe

DEPLOYMENT=$1
SUBNET=$2

FACTS_D=/etc/facter/facts.d

if [ ! -d $FACTS_D ] ; then
    mkdir -p $FACTS_D
    echo deployment=${DEPLOYMENT} > $FACTS_D/deployment.txt
    echo subnet=${SUBNET} > $FACTS_D/subnet.txt
fi
