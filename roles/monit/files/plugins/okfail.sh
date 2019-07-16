DESCRIPTION=$2
ENVIRONMENT=$3

function ok() {
    echo "0" > $counter_file
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
