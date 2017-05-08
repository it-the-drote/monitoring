#!/usr/bin/env bash

source /etc/sensu/lib/okfail.sh

usage=`df $1 | tail -n 1 | awk '{print $5}' | sed 's|%||'`

if [[ $usage -lt 95 ]]; then
    ok "enough free space on disk"
else
    fail "only $usage% of disk space left"
fi
