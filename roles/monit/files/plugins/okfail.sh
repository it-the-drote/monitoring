DESCRIPTION=$2
ENVIRONMENT=$3

counter_file="/var/lib/monit/counters/"`basename -s '.sh' ${0}`"-${4}"

function ok() {
    if [[ $3 = 'external' ]]; then
      mongo --quiet --port 27018 monitoring --eval 'db.checks.update({name: "'"$2"'"}, {name: "'"$2"'", status: 0}, { upsert: true })'
    fi
    echo "0" > $counter_file
    echo -n "OK - "$1
    exit 0
}

function warning() {
    if [[ $3 = 'external' ]]; then
      mongo --quiet --port 27018 monitoring --eval 'db.checks.update({name: "'"$2"'"}, {name: "'"$2"'", status: 1}, { upsert: true })'
    fi
    echo -n "WARNING - "$1
    exit 1
}

function fail() {
    if [[ $3 = 'external' ]]; then
      mongo --quiet --port 27018 monitoring --eval 'db.checks.update({name: "'"$2"'"}, {name: "'"$2"'", status: 2}, { upsert: true })'
    fi
    counter=`cat ${counter_file}`
    let 'counter=counter+1'
    echo $counter > $counter_file

    if [[ "$counter" -gt "2" ]]; then
      echo -n "CRITICAL - "$1
      exit 2
    fi
}
