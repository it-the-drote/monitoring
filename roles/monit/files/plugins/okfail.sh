function ok() {
    echo $MONIT_DESCRIPTION >> /tmp/monit_okail.log
    echo -n "OK - "$1
    exit 0
}

function warning() {
    echo -n "WARNING - "$1
    exit 1
}

function fail() {
    echo -n "CRITICAL - "$1
    exit 2
}
