DESCRIPTION=$2
ENVIRONMENT=$3

counter_file="/var/lib/monit/counters/"`basename -s '.sh' ${0}`"-${4}"

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
    counter=`cat ${counter_file}`
    let 'counter=counter+1'
    echo $counter > $counter_file

    if [[ "$counter" -gt "2" ]]; then
      echo -n "CRITICAL - "$1
      exit 2
    fi
}
