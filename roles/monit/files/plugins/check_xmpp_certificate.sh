#!/usr/bin/env bash

source /etc/monit/plugins/okfail.sh

pubdate=`echo | openssl s_client -connect $1':5222' 2>/dev/null -starttls xmpp | openssl x509 -noout -dates | grep notAfter | cut -f 2 -d '='`
pubdate_unix=`date +%s -d "$pubdate"`
current_date=`date +%s`
let delta="pubdate_unix - current_date"
let days="delta/86400"

if test $delta -lt 2592000; then
    fail "The certificate of $1 will expire in $days days!"
else
    ok "Certificate is ok."
fi