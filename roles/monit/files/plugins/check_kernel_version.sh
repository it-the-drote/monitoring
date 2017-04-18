#!/usr/bin/env bash

source /etc/monit/plugins/okfail.sh

current_running=`uname -v | awk '{print $4}'`

if dpkg -l | grep linux-image | awk '{print $3}' | grep -q $current_running; then
    ok "Current running kernel is up to date."
else
    fail "Current running $current_running kernel is out of date!"
fi
