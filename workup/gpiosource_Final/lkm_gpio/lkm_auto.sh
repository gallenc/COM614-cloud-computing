#!/bin/bash
# lkm_auto.sh
# 12/27/2020
# John Schwartzman, Forte Systems, Inc.
# ARM64

# start lkm_gpio automatically
# this file must be run as root
# set -e
err_report()
{
    echo "Error on line $(caller)" >&2
}

trap 'err_report $LINENO' ERR

# append string 'lkm-gpio' to /etc/modules if it doesn't exist
grep -qxsF 'lkm_gpio' /etc/modules || echo 'lkm_gpio' >> /etc/modules
# copy lkm_gpio.ko to current lib modules directory
cp lkm_gpio.ko /lib/modules/$(uname -r)/.
depmod -a
modprobe lkm_gpio
