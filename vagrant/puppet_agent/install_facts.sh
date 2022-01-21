#!/usr/bin/env bash

set -xe

DEPLOYMENT=$1
SUBNET=$2

FACTS_D=/etc/facter/facts.d

mkdir -p $FACTS_D
echo deployment=${DEPLOYMENT} > $FACTS_D/deployment.txt
echo subnet=${SUBNET} > $FACTS_D/subnet.txt
