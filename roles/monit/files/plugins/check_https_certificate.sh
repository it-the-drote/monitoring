#!/usr/bin/env bash

source /etc/monit/plugins/okfail.sh

pubdate=`echo | openssl s_client -servername $1 -connect $1':443' 2>/dev/null | openssl x509 -noout -dates | grep notAfter | cut -f 2 -d '='`
pubdate_unix=`date +%s -d "$pubdate"`
current_date=`date +%s`
let delta="pubdate_unix - current_date"
let days="delta/86400"

if test $delta -lt 864000; then
    warning "The certificate of $1 will expire in $days days!" "$DESCRIPTION" "$ENVIRONMENT"
elif test $delta -lt 259200; then
    #### CERTIFICATE REISSUE BLOCK
    echo -e "~~~~~~~~~~\nATTEMPTING TO ISSUE A CERTIFICATE FOR ${1}\n~~~~~~~~~~\n" >> /var/log/acme.log
    /etc/monit/scripts/acme.sh --issue -d "$1" -w /var/www/acme >> /var/log/acme.log
    echo -e "~~~~~~~~~~\nATTEMPTING TO INSTALL A CERTIFICATE FOR ${1}\n~~~~~~~~~~\n" >> /var/log/acme.log
    /etc/monit/scripts/acme.sh --install-cert -d "$1" \
                                --cert-file "/etc/ssl/acme/${1}-cert.pem" \
                                --key-dile "/etc/ssl/acme/${1}-key.pem" \
                                --fullchain-file "/etc/ssl/acme/${1}-fullchain.pem" \
                                --reloadcmd "systemctl restart nginx.service" >> /var/log/acme.log
    #### CERTIFICATE REISSUE BLOCK
    fail "The certificate of $1 will expire in $days days!" "$DESCRIPTION" "$ENVIRONMENT"
else
    ok "Certificate is ok." "$DESCRIPTION" "$ENVIRONMENT"
fi
